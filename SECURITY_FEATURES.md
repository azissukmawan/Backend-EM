# 🔐 Security Features Documentation

## Overview

Authentication system dilengkapi dengan berbagai fitur keamanan untuk melindungi dari serangan umum seperti brute force, spam attacks, dan account takeover.

---

## 1. Rate Limiting

### Implementasi
Rate limiting diterapkan menggunakan Laravel Rate Limiter untuk membatasi jumlah request per IP address.

### Konfigurasi

| Endpoint | Limit | Window | Throttle Key |
|----------|-------|--------|--------------|
| `/api/login` | 5 requests | 1 minute | `throttle:login` |
| `/api/verify-otp` | 3 requests | 1 minute | `throttle:otp` |
| `/api/resend-otp` | 3 requests | 1 minute | `throttle:otp` |
| `/api/forgot-password` | 3 requests | 5 minutes | `throttle:reset` |
| `/api/reset-password` | 3 requests | 5 minutes | `throttle:reset` |
| `/api/register` | 60 requests | 1 minute | `throttle:api` |
| Other API endpoints | 60 requests | 1 minute | `throttle:api` |

### Response ketika Rate Limit Exceeded

**HTTP Status:** `429 Too Many Requests`

```json
{
  "message": "Too Many Requests"
}
```

**Headers:**
```
X-RateLimit-Limit: 5
X-RateLimit-Remaining: 0
Retry-After: 60
```

### Cara Kerja:
- Rate limit berdasarkan **IP address**
- Menggunakan cache untuk tracking requests
- Auto-reset setelah window berakhir
- Mencegah brute force attacks

---

## 2. Account Locking (Failed Login Protection)

### Implementasi
Akun otomatis terkunci setelah terlalu banyak percobaan login gagal untuk mencegah brute force attacks.

### Konfigurasi:
- **Max Attempts:** 5 kali gagal login
- **Lock Duration:** 15 menit
- **Tracking:** Database (`failed_login_attempts`, `locked_until`)

### Alur Kerja:

1. **Login Gagal (Wrong Password):**
   - Increment `failed_login_attempts`
   - Response menunjukkan remaining attempts
   ```json
   {
     "success": false,
     "message": "Invalid credentials",
     "remaining_attempts": 4
   }
   ```

2. **Setelah 5x Gagal:**
   - Set `locked_until` = now + 15 minutes
   - HTTP Status: `423 Locked`
   ```json
   {
     "success": false,
     "message": "Too many failed login attempts. Account locked for 15 minutes.",
     "locked_until": "2025-10-30 12:45:00"
   }
   ```

3. **Akun Masih Terkunci:**
   - HTTP Status: `423 Locked`
   ```json
   {
     "success": false,
     "message": "Account is temporarily locked due to too many failed login attempts",
     "locked_until": "2025-10-30 12:45:00",
     "minutes_remaining": 12
   }
   ```

4. **Login Berhasil:**
   - Reset `failed_login_attempts` = 0
   - Set `locked_until` = null
   - Generate access token

### Database Schema:
```sql
-- Migration: add_failed_login_tracking_to_users_table
ALTER TABLE users ADD COLUMN failed_login_attempts INT DEFAULT 0;
ALTER TABLE users ADD COLUMN locked_until TIMESTAMP NULL;
```

### User Model Methods:

```php
// Cek apakah akun terkunci
$user->isLocked(); // Returns boolean

// Reset failed attempts (dipanggil saat login berhasil)
$user->resetFailedLoginAttempts();

// Increment attempts (dipanggil saat login gagal)
$user->incrementFailedLoginAttempts();
```

---

## 3. OTP Resend Cooldown

### Implementasi
Mencegah spam OTP requests dengan menerapkan cooldown 2 menit antara resend attempts.

### Konfigurasi:
- **Cooldown Duration:** 2 menit
- **Check:** Database timestamp `created_at` pada tabel `otps`

### Response ketika Cooldown Aktif:

**HTTP Status:** `429 Too Many Requests`

```json
{
  "success": false,
  "message": "Please wait before requesting a new OTP",
  "wait_seconds": 87
}
```

### Cara Kerja:
1. User request resend OTP
2. Check OTP terakhir yang dibuat dalam 2 menit terakhir
3. Jika ada, return error dengan remaining seconds
4. Jika tidak ada, generate & kirim OTP baru

### Logic di Controller:
```php
$lastOtp = Otp::where('user_id', $user->id)
    ->where('created_at', '>', Carbon::now()->subMinutes(2))
    ->latest()
    ->first();

if ($lastOtp) {
    $waitTime = Carbon::now()->diffInSeconds($lastOtp->created_at->addMinutes(2));
    return response()->json([
        'success' => false,
        'message' => 'Please wait before requesting a new OTP',
        'wait_seconds' => $waitTime
    ], 429);
}
```

---

## 4. Password Security

### Hashing Algorithm:
- **Bcrypt** (Laravel default)
- Cost factor: 10 (default)
- Auto-salted

### Password Requirements:
- Minimum: **8 characters**
- Must confirm password (`password_confirmation`)
- Hashed before saving to database

### Implementation:
```php
// Register
'password' => Hash::make($request->password)

// Verify
Hash::check($request->password, $user->password)
```

### Password Never Exposed:
- Hidden dari serialization (User model)
- Never returned in API responses
- Always hashed in database

---

## 5. Token Management

### Laravel Sanctum Implementation:

#### Token Creation (Login):
```php
$token = $user->createToken('auth_token')->plainTextToken;
```

#### Token Revocation:

**Logout (Current Device):**
```php
$request->user()->currentAccessToken()->delete();
```

**Reset Password (All Devices):**
```php
$user->tokens()->delete(); // Revoke semua tokens
```

### Token Security:
- Stored hashed in database (`personal_access_tokens` table)
- No expiration (unless set via config)
- Can be revoked anytime
- Unique per login session

---

## 6. Email Verification

### Implementation:
- Email verification **WAJIB** sebelum bisa login
- OTP dikirim via email saat register
- OTP expire dalam **10 menit**
- OTP hanya bisa digunakan 1x (marked `verified_at`)

### Login Protection:
```php
if (!$user->email_verified_at) {
    return response()->json([
        'success' => false,
        'message' => 'Please verify your email first'
    ], 403);
}
```

### OTP Reuse Prevention:
```php
$otp = Otp::where('user_id', $user->id)
    ->where('code', $request->otp)
    ->whereNull('verified_at') // Hanya OTP yang belum diverifikasi
    ->first();
```

---

## 7. Password Reset Token Security

### Token Generation:
- **Length:** 60 random characters
- **Algorithm:** `Str::random(60)`
- **Storage:** Hashed dengan bcrypt

### Token Expiration:
- **Duration:** 60 menit
- **Check:** `created_at` timestamp
- **Auto-delete:** Token dihapus setelah digunakan

### Security Flow:

1. **Request Reset:**
   - User submit email
   - Generate random token
   - Hash token before store
   - Send plain token via email
   - Old tokens deleted

2. **Reset Password:**
   - Verify token exists
   - Check expiration (60 min)
   - Verify hashed token matches
   - Update password
   - Delete token
   - Revoke all access tokens

### Implementation:
```php
// Generate & store hashed token
$token = Str::random(60);
DB::table('password_resets')->insert([
    'email' => $request->email,
    'token' => Hash::make($token), // Hashed!
    'created_at' => Carbon::now()
]);

// Verify token
if (!Hash::check($request->token, $passwordReset->token)) {
    return response()->json(['message' => 'Invalid token'], 400);
}

// Check expiration
if ($createdAt->addMinutes(60)->isPast()) {
    return response()->json(['message' => 'Token expired'], 400);
}
```

---

## 8. Input Validation

### Validation Rules:

**Register:**
```php
'name' => 'required|string|max:255',
'username' => 'required|string|max:255|unique:users',
'email' => 'required|string|email|max:255|unique:users',
'telp' => 'required|string|max:20',
'password' => 'required|string|min:8|confirmed',
```

**Login:**
```php
'login' => 'required|string', // Email or username
'password' => 'required|string',
```

**Verify OTP:**
```php
'email' => 'required|email',
'otp' => 'required|string|size:6',
```

**Reset Password:**
```php
'email' => 'required|email',
'token' => 'required|string',
'password' => 'required|string|min:8|confirmed',
```

### Protection Against:
- SQL Injection (via Eloquent ORM)
- Mass Assignment (via `$fillable`)
- Invalid data types
- Missing required fields

---

## 9. Response Error Codes

### HTTP Status Codes:

| Code | Status | Description | Use Case |
|------|--------|-------------|----------|
| 200 | OK | Success | Login, Logout, OTP verified |
| 201 | Created | Resource created | Register |
| 400 | Bad Request | Invalid input | Invalid OTP, expired token |
| 401 | Unauthorized | Invalid credentials | Wrong password |
| 403 | Forbidden | Access denied | Email not verified |
| 404 | Not Found | Resource not found | User not found |
| 422 | Unprocessable Entity | Validation error | Missing fields |
| 423 | Locked | Account locked | Too many failed logins |
| 429 | Too Many Requests | Rate limit exceeded | Brute force attempt |
| 500 | Server Error | Server error | Email send failed |

---

## 10. Best Practices Implemented

✅ **Never expose passwords** - Always hashed, never in responses  
✅ **Token-based auth** - Stateless authentication  
✅ **Rate limiting** - Prevent brute force & DoS  
✅ **Account locking** - Auto-lock after failed attempts  
✅ **Email verification** - Confirm user ownership  
✅ **Secure password reset** - Time-limited, hashed tokens  
✅ **Input validation** - Strict validation rules  
✅ **Database security** - Eloquent ORM prevents SQL injection  
✅ **Cooldown mechanisms** - Prevent spam attacks  
✅ **Proper HTTP status codes** - Clear error communication  

---

## Testing Security Features

### 1. Test Rate Limiting

**Login Rate Limit:**
```bash
# Kirim 6 requests dalam 1 menit
for i in {1..6}; do
  curl -X POST http://localhost:8000/api/login \
    -H "Content-Type: application/json" \
    -d '{"login":"test@example.com","password":"wrong"}'
done
# Request ke-6 harus return 429
```

### 2. Test Account Locking

**Failed Login Attempts:**
```bash
# Login dengan password salah 5x
# Request ke-5 harus return 423 (Locked)
POST /api/login
{
  "login": "test@example.com",
  "password": "wrongpassword"
}
```

### 3. Test OTP Cooldown

**Resend OTP Spam:**
```bash
# Resend OTP 2x dalam 2 menit
POST /api/resend-otp {"email": "test@example.com"}
# Request ke-2 dalam 2 menit harus return 429
```

---

## Configuration Files

### `app/Providers/AppServiceProvider.php`
```php
RateLimiter::for('login', function (Request $request) {
    return Limit::perMinute(5)->by($request->ip());
});
```

### `routes/api.php`
```php
Route::middleware('throttle:login')->group(function () {
    Route::post('/login', [AuthController::class, 'login']);
});
```

### `app/Models/User.php`
```php
protected $fillable = [
    'name', 'username', 'email', 'password',
    'failed_login_attempts', 'locked_until'
];

protected $casts = [
    'locked_until' => 'datetime',
];
```

---

## Maintenance & Monitoring

### Recommended Monitoring:

1. **Track failed login attempts:**
   - Query users dengan `failed_login_attempts > 0`
   - Alert jika ada spike

2. **Monitor rate limit hits:**
   - Log 429 responses
   - Identify suspicious IPs

3. **Check locked accounts:**
   - Query users dengan `locked_until IS NOT NULL`
   - Provide manual unlock untuk false positives

4. **OTP usage stats:**
   - Monitor OTP generation rate
   - Track verification success rate

### Database Queries:

```sql
-- Akun yang terkunci
SELECT * FROM users WHERE locked_until > NOW();

-- Failed login attempts
SELECT email, failed_login_attempts, locked_until 
FROM users 
WHERE failed_login_attempts > 0 
ORDER BY failed_login_attempts DESC;

-- OTP yang belum verified
SELECT u.email, o.code, o.expires_at 
FROM otps o 
JOIN users u ON o.user_id = u.id 
WHERE o.verified_at IS NULL;
```

---

## Future Improvements (Optional)

🔄 **2FA (Two-Factor Authentication)** - Google Authenticator  
🔄 **IP Whitelist/Blacklist** - Block suspicious IPs  
🔄 **Login History** - Track all login attempts with IP & device  
🔄 **Session Management** - List & revoke active sessions  
🔄 **CAPTCHA** - After 3 failed attempts  
🔄 **Geolocation Check** - Alert login from new location  
🔄 **Device Fingerprinting** - Detect new devices  

---

## Support & Documentation

- **Main Docs:** `SETUP_AUTH_API.md`
- **API Docs:** `API_DOCUMENTATION.md`
- **Testing Guide:** `TESTING_GUIDE.md`
- **Backend Flow:** `BACKEND_FLOW_DOCUMENTATION.md`

---

**Last Updated:** October 30, 2025  
**Version:** 1.0.0  
**Security Level:** Production Ready ✅
