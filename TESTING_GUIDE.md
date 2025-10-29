# Testing Guide - Quick Reference

## 🚀 Quick Start

1. **Jalankan Server**
```bash
php artisan serve
```

2. **Cek Konfigurasi Email**
Buka `.env` dan pastikan:
```env
MAIL_MAILER=log  # untuk testing lokal (cek di storage/logs/laravel.log)
# atau
MAIL_MAILER=smtp # untuk production (perlu setup Gmail)
```

## 📧 Testing Flow

### Scenario 1: Register → Verify → Login

**Step 1: Register**
```bash
POST http://localhost:8000/api/register
Content-Type: application/json

{
    "name": "Test User",
    "username": "testuser",
    "email": "test@example.com",
    "telp": "081234567890",
    "password": "password123",
    "password_confirmation": "password123",
    "role": "peserta"
}
```

Expected: `201 Created` dengan pesan "Please check your email for OTP code"

**Step 2: Cek OTP**

Jika `MAIL_MAILER=log`, buka:
```
storage/logs/laravel.log
```
Cari 6 digit OTP code

Jika `MAIL_MAILER=smtp`, cek inbox email

**Step 3: Verify OTP**
```bash
POST http://localhost:8000/api/verify-otp
Content-Type: application/json

{
    "email": "test@example.com",
    "otp": "123456"  # ganti dengan OTP dari email
}
```

Expected: `200 OK` dengan pesan "Email verified successfully"

**Step 4: Login**
```bash
POST http://localhost:8000/api/login
Content-Type: application/json

{
    "email": "test@example.com",
    "password": "password123"
}
```

Expected: `200 OK` dengan `access_token`

**Step 5: Get User Info**
```bash
GET http://localhost:8000/api/me
Authorization: Bearer {token_dari_login}
```

Expected: `200 OK` dengan data user

---

### Scenario 2: OTP Expired → Resend

**Step 1: Resend OTP**
```bash
POST http://localhost:8000/api/resend-otp
Content-Type: application/json

{
    "email": "test@example.com"
}
```

Expected: `200 OK` dengan pesan "OTP code has been resent"

---

### Scenario 3: Logout

**Step 1: Logout**
```bash
POST http://localhost:8000/api/logout
Authorization: Bearer {token}
```

Expected: `200 OK` dengan pesan "Logout successful"

---

## ⚠️ Common Errors

### 1. Email not verified
```json
{
    "success": false,
    "message": "Please verify your email first"
}
```
**Solution:** Verify OTP terlebih dahulu

### 2. OTP expired
```json
{
    "success": false,
    "message": "OTP code has expired"
}
```
**Solution:** Gunakan endpoint `/resend-otp`

### 3. Invalid OTP
```json
{
    "success": false,
    "message": "Invalid OTP code"
}
```
**Solution:** Cek kembali OTP code atau request resend

### 4. Validation errors
```json
{
    "success": false,
    "message": "Validation error",
    "errors": {...}
}
```
**Solution:** Cek field yang required

### 5. Email already exists
```json
{
    "success": false,
    "errors": {
        "email": ["The email has already been taken."]
    }
}
```
**Solution:** Gunakan email lain atau login dengan email tersebut

---

## 🔍 Debug Tips

### Cek OTP di Database
```sql
SELECT * FROM otps ORDER BY created_at DESC LIMIT 5;
```

### Cek User Registration
```sql
SELECT id, name, email, email_verified_at FROM users;
```

### Clear All Data (Reset)
```bash
php artisan migrate:fresh
```

### Cek Laravel Logs
```bash
tail -f storage/logs/laravel.log
```

---

## 📊 Database Query Examples

### Cek semua user yang belum verify email
```sql
SELECT * FROM users WHERE email_verified_at IS NULL;
```

### Cek OTP yang masih valid
```sql
SELECT * FROM otps 
WHERE verified_at IS NULL 
AND expires_at > NOW();
```

### Cek token yang aktif
```sql
SELECT * FROM personal_access_tokens 
ORDER BY created_at DESC;
```

---

## 🎯 Testing Checklist

- [ ] Register dengan data lengkap
- [ ] Terima OTP di email/log
- [ ] Verify OTP berhasil
- [ ] Login dengan email terverifikasi
- [ ] Dapat access token
- [ ] Access protected endpoint dengan token
- [ ] Logout berhasil
- [ ] Test resend OTP
- [ ] Test invalid OTP
- [ ] Test expired OTP
- [ ] Test login sebelum verify email

---

## 🌐 Production Checklist

- [ ] Update `MAIL_MAILER` ke `smtp`
- [ ] Setup Gmail App Password
- [ ] Test email terkirim
- [ ] Set `APP_ENV` ke `production`
- [ ] Set `APP_DEBUG` ke `false`
- [ ] Update `APP_URL` dengan domain real
- [ ] Setup SSL/HTTPS
- [ ] Backup database
