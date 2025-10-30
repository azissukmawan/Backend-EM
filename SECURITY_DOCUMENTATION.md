# Security Features Documentation

**Version:** 2.0  
**Last Update:** October 30, 2025  
**Status:** ✅ All Features Implemented & Tested

---

## 🔒 Overview

Sistem backend Event Management dilengkapi dengan berbagai fitur keamanan untuk melindungi dari berbagai serangan seperti brute force, spam, dan abuse.

---

## 🛡️ Implemented Security Features

### 1. Account Locking (Login Protection)

**Tujuan:** Mencegah brute force attack pada endpoint login

**Detail:**
- **Trigger:** 5x failed login attempts dengan password salah
- **Lock Duration:** 15 menit otomatis
- **HTTP Status:** `423 Locked` (bukan 429)
- **Database Tracking:** 
  - Kolom `failed_login_attempts` (integer, default 0)
  - Kolom `locked_until` (timestamp, nullable)
- **Reset Mechanism:**
  - Otomatis setelah 15 menit
  - Manual reset setelah login berhasil
- **Counter Accuracy:** Menggunakan `refresh()` setelah `increment()` untuk nilai akurat
  
**Response saat akun terkunci:**
```json
{
  "success": false,
  "message": "Account is temporarily locked due to too many failed login attempts",
  "locked_until": "2025-10-30 21:47:53",
  "minutes_remaining": 14
}
```
**HTTP Status:** `423 Locked`

**Response dengan remaining attempts:**
```json
{
  "success": false,
  "message": "Invalid credentials",
  "remaining_attempts": 2
}
```
**HTTP Status:** `401 Unauthorized`

**Implementasi:**
- File: `app/Models/User.php`
  - Method: `isLocked()`, `incrementFailedLoginAttempts()`, `resetFailedLoginAttempts()`
  - **Fix:** Ditambahkan `$this->refresh()` setelah `increment()` untuk akurasi counter
- File: `app/Http/Controllers/AuthController.php`
  - Login method cek `isLocked()` sebelum validasi password
  - Show remaining attempts setelah failed login
- Migration: `database/migrations/2025_10_30_150000_add_account_locking_to_users_table.php`

**Key Code:**
```php
public function incrementFailedLoginAttempts()
{
    $this->increment('failed_login_attempts');
    $this->refresh(); // PENTING: Reload untuk mendapatkan nilai terbaru
    
    if ($this->failed_login_attempts >= 5) {
        $this->update([
            'locked_until' => now()->addMinutes(15),
        ]);
    }
}
```

---

### 2. Rate Limiting (Smart Throttling)

**Tujuan:** Membatasi jumlah request per waktu untuk mencegah spam dan abuse, namun tidak mengganggu account locking

**Perubahan Penting:**
- **Login rate limit dinaikkan dari 5/min → 15/min** agar account locking bisa berfungsi dengan baik
- Menggunakan **key per email+IP** untuk quota individual per user

**Custom Rate Limiters:**

| Endpoint | Limit | Key | Reasoning |
|----------|-------|-----|-----------|
| `/login` | **15 req/min** | Email + IP | Lebih tinggi dari 5x failed attempts agar HTTP 423 bisa muncul sebelum HTTP 429 |
| `/register` | 5 req/min | IP Address | Prevent spam registration |
| `/verify-otp` | 5 req/min | Email + IP | Per-user quota |
| `/resend-otp` | 5 req/min | Email + IP | Combined with cooldown check |
| `/forgot-password` | 5 req/5min | IP Address | Extra protection |
| `/reset-password` | 5 req/5min | IP Address | Password reset limit |
| `/events` | 60 req/min | IP Address | Public endpoint |
| `/events/all` | 30 req/min | IP Address | More intensive query |
| `/events/{id}` | 120 req/min | IP Address | Detail endpoint |

**Response saat rate limit tercapai:**
```json
{
  "message": "Too Many Attempts.",
  "exception": "Illuminate\\Http\\Exceptions\\ThrottleRequestsException"
}
```
**HTTP Status:** `429 Too Many Requests`

**Implementasi:**
- File: `app/Providers/AppServiceProvider.php`
  - Custom rate limiter dengan `RateLimiter::for()`
  - Menggunakan `by($email . '|' . $request->ip())` untuk per-user quota
- File: `routes/api.php`
  - Middleware: `->middleware('throttle:login')`, `->middleware('throttle:otp')`, etc.

**Key Code:**
```php
RateLimiter::for('login', function (Request $request) {
    $email = $request->input('login', 'guest');
    return Limit::perMinute(15)->by($email . '|' . $request->ip());
});
```

**Why 15/min for login?**
- User bisa login 5x salah → HTTP 423 (account locked)
- Masih bisa coba lagi 10x (walaupun locked) sebelum kena HTTP 429
- Mencegah rate limiting override account locking response

---

### 3. OTP Cooldown

**Tujuan:** Mencegah spam email OTP dan abuse resend functionality

**Detail:**
- **Cooldown Duration:** 2 menit
- **Check Mechanism:** Bandingkan `created_at` OTP terakhir dengan waktu sekarang
- **HTTP Status:** `429 Too Many Requests` (berbeda dengan account locking yang 423)
- **Expiration:** 10 menit setelah generate
- **Code Format:** 6 digit random number

**Response saat cooldown aktif:**
```json
{
  "success": false,
  "message": "Please wait before requesting a new OTP",
  "wait_seconds": 85
}
```
**HTTP Status:** `429 Too Many Requests`

**Implementasi:**
- File: `app/Http/Controllers/AuthController.php`
  - Method: `resendOtp()`
  - Query OTP terakhir: `Otp::where('user_id', $user->id)->where('created_at', '>', Carbon::now()->subMinutes(2))->latest()->first()`
  - Check: Calculate wait time dengan `diffInSeconds()`

---

### 4. Password Security

**Hash Algorithm:** Bcrypt (default Laravel)

**Validation Rules:**
- Minimal 8 karakter
- Wajib konfirmasi (password_confirmation)
- Auto-hash saat store: `Hash::make($request->password)`
- Verify saat login: `Hash::check($request->password, $user->password)`

**Implementasi:**
- File: `app/Models/User.php`
  - Cast: `'password' => 'hashed'`
- File: `app/Http/Controllers/AuthController.php`
  - Register: `Hash::make()`
  - Login: `Hash::check()`

---

### 5. Email Verification

**Flow:**
1. Register → kirim OTP via email
2. User verify OTP → set `email_verified_at`
3. Login check: `if (!$user->email_verified_at)` → HTTP 403

**Purpose:**
- Pastikan email valid dan dimiliki user
- Prevent fake registration
- Enable email-based recovery

**Response saat email belum verified:**
```json
{
  "success": false,
  "message": "Please verify your email first"
}
```
**HTTP Status:** `403 Forbidden`

---

### 6. Production Error Hiding

**Tujuan:** Menyembunyikan technical details di production untuk security

**Mechanism:**
```php
'error' => config('app.debug') ? $e->getMessage() : null
```

**Behavior:**
- **Development** (`APP_DEBUG=true`): Show full error message
- **Production** (`APP_DEBUG=false`): Hide error, return `null`

**Implementasi di semua error handlers:**
- ✅ `AuthController::register()` - Email sending error & general exception
- ✅ `AuthController::resendOtp()` - Email sending error
- ✅ `AuthController::forgotPassword()` - Email sending error
- ✅ `EventController::index()` - Query error
- ✅ `EventController::upcoming()` - Query error
- ✅ `EventController::past()` - Query error
- ✅ `EventController::all()` - Query error
- ✅ `EventController::show()` - Query error

**Example:**
```json
// Development (APP_DEBUG=true)
{
  "success": false,
  "message": "Failed to send OTP email",
  "error": "Connection timeout to mail.google.com:587"
}

// Production (APP_DEBUG=false)
{
  "success": false,
  "message": "Failed to send OTP email",
  "error": null
}
```

---

## 📊 Security Metrics

### HTTP Status Codes Used

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Success response |
| 201 | Created | User registered |
| 401 | Unauthorized | Invalid credentials (wrong password) |
| 403 | Forbidden | Email not verified |
| 404 | Not Found | User/resource not found |
| 422 | Unprocessable | Validation error |
| **423** | **Locked** | **Account locked (5x failed login)** |
| **429** | **Too Many Requests** | **Rate limit OR OTP cooldown** |
| 500 | Server Error | Internal error |

**Perbedaan 423 vs 429:**
- **423 Locked:** Account locking setelah 5x failed login
- **429 Too Many Requests:** Rate limiting (>15 req/min) atau OTP cooldown (<2 min)

### Database Schema Changes

**Table: `users`**
```sql
-- Kolom baru untuk account locking
failed_login_attempts INT DEFAULT 0
locked_until TIMESTAMP NULL
```

**Migration file:** `2025_10_30_150000_add_account_locking_to_users_table.php`

**Fillable fields updated:**
```php
protected $fillable = [
    'name', 'username', 'telp', 'role', 'email', 'password',
    'email_verified_at',
    'failed_login_attempts',  // Ditambahkan
    'locked_until',           // Ditambahkan
];
```

---

## 🧪 Testing Security Features

### Test 1: Account Locking

```bash
# Kirim 5x login dengan password salah
POST http://localhost:8000/api/login
Body: {"login": "test@test.com", "password": "wrong"}

# Expected:
# Attempt 1-4: HTTP 401 dengan remaining_attempts countdown
# Attempt 5: HTTP 423 dengan locked_until & minutes_remaining
```

**Expected Responses:**
```json
// Attempt 1-4
{
  "success": false,
  "message": "Invalid credentials",
  "remaining_attempts": 4  // countdown: 4, 3, 2, 1
}
// HTTP 401

// Attempt 5+
{
  "success": false,
  "message": "Too many failed login attempts. Account locked for 15 minutes.",
  "locked_until": "2025-10-30 21:47:53"
}
// HTTP 423
```

### Test 2: Rate Limiting (Should NOT interfere with Account Locking)

```bash
# Kirim 6x login dalam 1 menit (harus dapat HTTP 423, bukan 429)
for i in {1..6}; do
  curl -X POST http://localhost:8000/api/login \
    -H "Content-Type: application/json" \
    -d '{"login":"test@test.com","password":"wrong"}'
done

# Expected:
# Request 1-4: HTTP 401 (Invalid credentials)
# Request 5: HTTP 423 (Account locked) ← BUKAN 429!
# Request 6-15: HTTP 423 (Masih locked)
# Request 16+: Baru HTTP 429 (Rate limit exceeded)
```

### Test 3: OTP Cooldown

```bash
# Request OTP 2x dalam < 2 menit
POST /api/resend-otp
Body: {"email": "test@test.com"}

# Request 1: Success
# Request 2 (< 2 min): HTTP 429 dengan wait_seconds
```

### Test 4: Production Error Hiding

```bash
# Set APP_DEBUG=false di .env
APP_DEBUG=false

# Trigger error (misal: SMTP down)
POST /api/register
# Response error harus null, bukan technical details
```

### Manual Database Check

```sql
-- Cek counter failed login
SELECT email, failed_login_attempts, locked_until 
FROM users 
WHERE email = 'test@test.com';

-- Expected setelah 5x gagal:
-- failed_login_attempts: 5
-- locked_until: 2025-10-30 21:47:53

-- Reset manual untuk testing
UPDATE users 
SET failed_login_attempts = 0, locked_until = NULL 
WHERE email = 'test@test.com';
```

---

## 🔧 Configuration

### Environment Variables

```env
# App mode
APP_DEBUG=false  # Set false di production untuk hide errors

# Email (untuk OTP & password reset)
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your@gmail.com
MAIL_PASSWORD=your_app_password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your@gmail.com
MAIL_FROM_NAME="Event Management"
```

### Rate Limiter Configuration

Edit `app/Providers/AppServiceProvider.php`:

```php
protected function configureRateLimiting(): void
{
    // Login - 15/min per email+IP (lebih tinggi dari 5 failed attempts)
    RateLimiter::for('login', function (Request $request) {
        $email = $request->input('login', 'guest');
        return Limit::perMinute(15)->by($email . '|' . $request->ip());
    });
    
    // OTP - 5/min per email+IP
    RateLimiter::for('otp', function (Request $request) {
        $email = $request->input('email', 'guest');
        return Limit::perMinute(5)->by($email . '|' . $request->ip());
    });
    
    // Reset - 5/5min per IP
    RateLimiter::for('reset', function (Request $request) {
        return Limit::perMinutes(5, 5)->by($request->ip());
    });
}
```

**Adjust limits jika perlu:**
- Change `perMinute(15)` untuk increase/decrease limit
- Change key strategy: `by($request->ip())` untuk IP-only (tidak recommended)

---

## 📝 Best Practices

### ✅ DO:
- Selalu gunakan HTTPS di production
- Set `APP_DEBUG=false` di production
- Monitor failed login attempts dengan logging
- Backup database secara berkala
- Test semua security features di staging sebelum production
- Gunakan strong email password untuk SMTP
- Rate limit harus lebih tinggi dari failed login limit (15 > 5)

### ❌ DON'T:
- Jangan expose error details di production
- Jangan hardcode credentials di code
- Jangan disable rate limiting
- Jangan set lockout duration terlalu pendek (< 5 menit)
- Jangan simpan password plain text
- Jangan set rate limit terlalu ketat (akan override account locking)

---

## 🚀 Deployment Checklist

### Pre-deployment:
- [ ] Set `APP_DEBUG=false` di `.env`
- [ ] Configure email SMTP credentials
- [ ] Test semua security features di staging
- [ ] Verify rate limiting tidak interfere dengan account locking
- [ ] Backup database

### Deployment Steps:
```bash
# 1. Upload files yang berubah
- app/Models/User.php
- app/Providers/AppServiceProvider.php
- app/Http/Controllers/AuthController.php
- app/Http/Controllers/EventController.php
- routes/api.php
- database/migrations/2025_10_30_150000_add_account_locking_to_users_table.php

# 2. Run migration
php artisan migrate

# 3. Clear caches
php artisan config:clear
php artisan cache:clear
php artisan route:clear

# 4. Verify database
mysql> DESCRIBE users;
# Check: failed_login_attempts & locked_until columns exist
```

### Post-deployment Testing:
- [ ] Test login 5x dengan password salah → verify HTTP 423 (bukan 429)
- [ ] Test rate limiting → verify HTTP 429 hanya muncul setelah 15 req/min
- [ ] Test OTP cooldown → verify wait_seconds ditampilkan
- [ ] Check error responses tidak expose technical details
- [ ] Monitor logs untuk suspicious activity

---

## 🐛 Troubleshooting

### Problem: Status 429 muncul setelah 5x login, bukan 423
**Cause:** Rate limit terlalu ketat (5/min), sama dengan failed login limit  
**Solution:** Naikkan rate limit login ke 15/min
```php
RateLimiter::for('login', function (Request $request) {
    return Limit::perMinute(15)->by(...); // Naikkan dari 5 ke 15
});
```

### Problem: Counter failed_login_attempts tidak bertambah
**Cause:** Missing `refresh()` setelah `increment()`  
**Solution:** Tambahkan `$this->refresh()` di method `incrementFailedLoginAttempts()`

### Problem: User terkunci terus menerus
**Cause:** `locked_until` tidak reset setelah berhasil login  
**Solution:** Pastikan `resetFailedLoginAttempts()` dipanggil setelah login berhasil

### Problem: Rate limit terlalu strict untuk legitimate users
**Cause:** Limit terlalu rendah atau key tidak optimal  
**Solution:** 
- Naikkan limit di `AppServiceProvider.php`
- Gunakan key per email+IP untuk quota individual

### Problem: OTP tidak diterima
**Cause:** SMTP error atau spam filter  
**Solution:** 
- Check SMTP credentials di `.env`
- Check spam folder
- Verify email logs: `tail -f storage/logs/laravel.log`

### Problem: Database column 'failed_login_attempts' tidak ditemukan
**Cause:** Migration belum dijalankan  
**Solution:** 
```bash
php artisan migrate
# Atau manual add column:
ALTER TABLE users ADD COLUMN failed_login_attempts INT DEFAULT 0;
ALTER TABLE users ADD COLUMN locked_until TIMESTAMP NULL;
```

---

## 📚 Related Documentation

- [API_DOCUMENTATION.md](./API_DOCUMENTATION.md) - Complete API reference dengan security info
- [README.md](./README.md) - Project overview & installation guide
- [SETUP_AUTH_API.md](./SETUP_AUTH_API.md) - Authentication setup guide

---

## ✅ Security Checklist Summary

| Feature | Status | HTTP Code | Notes |
|---------|--------|-----------|-------|
| Account Locking | ✅ | 423 | 5x fail → 15 min lock |
| Rate Limiting | ✅ | 429 | 15/min login, per email+IP |
| OTP Cooldown | ✅ | 429 | 2 min wait |
| Password Hash | ✅ | - | Bcrypt, min 8 char |
| Email Verify | ✅ | 403 | Required before login |
| Error Hiding | ✅ | - | Production mode |
| Remaining Attempts | ✅ | 401 | Show countdown |
| Smart Throttling | ✅ | - | Tidak interfere dengan locking |

**Last Tested:** October 30, 2025  
**Test Environment:** Local & Remote (178.128.208.73)  
**Test Result:** ✅ All features working correctly  
**Critical Fix:** Rate limit login 15/min untuk mencegah 429 override 423
