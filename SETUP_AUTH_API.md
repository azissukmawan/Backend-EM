# Setup Authentication API dengan OTP Email

## 🚀 Fitur yang Telah Dibuat

✅ **Register** - Registrasi user baru dengan OTP email verification  
✅ **Login** - Login dengan Laravel Sanctum token (email/username)  
✅ **Verify OTP** - Verifikasi email dengan kode OTP 6 digit  
✅ **Resend OTP** - Kirim ulang OTP jika expired atau hilang  
✅ **Logout** - Logout dan hapus token  
✅ **Get User** - Mendapatkan data user yang sedang login  
✅ **Forgot Password** - Kirim link reset password via email  
✅ **Reset Password** - Reset password dengan token  

## 🔐 Security Features

✅ **Rate Limiting** - Mencegah brute force & spam attacks  
✅ **Account Locking** - Kunci akun setelah 5x failed login (15 menit)  
✅ **OTP Cooldown** - Cooldown 2 menit untuk resend OTP  
✅ **Password Hashing** - Bcrypt untuk semua password  
✅ **Token Expiration** - OTP (10 min), Password Reset (60 min)  
✅ **Email Verification** - Wajib verify email sebelum login  

### Rate Limiting Details:
- **Login**: 5 attempts per minute (per IP)
- **OTP Verify/Resend**: 3 attempts per minute (per IP)
- **Password Reset**: 3 attempts per 5 minutes (per IP)
- **General API**: 60 requests per minute (per user/IP)

### Account Locking:
- Akun terkunci setelah 5x failed login attempts
- Lock duration: 15 menit
- Auto-reset counter setelah login berhasil

## 📋 Struktur Database

### Tabel `users`
- id
- name
- username (unique)
- email (unique)
- telp
- role (superadmin/peserta)
- password
- email_verified_at
- **failed_login_attempts** (new)
- **locked_until** (new)
- created_at, updated_at

### Tabel `otps`
- id
- user_id (foreign key)
- code (6 digit)
- expires_at (berlaku 10 menit)
- verified_at
- created_at, updated_at

### Tabel `password_resets`
- email (indexed)
- token (hashed)
- created_at

## 🔧 Setup

### 1. Install Dependencies
```bash
composer install
```

### 2. Copy Environment File
```bash
copy .env.example .env
```

### 3. Generate Application Key
```bash
php artisan key:generate
```

### 4. Konfigurasi Database (.env)
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=bem
DB_USERNAME=root
DB_PASSWORD=
```

### 5. Konfigurasi Email (.env)

**Untuk Gmail:**
```env
MAIL_MAILER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=587
MAIL_USERNAME=your-email@gmail.com
MAIL_PASSWORD=your-app-password
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=your-email@gmail.com
MAIL_FROM_NAME="${APP_NAME}"
```

**Cara Mendapat App Password Gmail:**
1. Buka [Google Account](https://myaccount.google.com/)
2. Security → 2-Step Verification (aktifkan)
3. Security → App passwords
4. Pilih "Mail" dan device "Other"
5. Copy password yang di-generate
6. Paste ke `MAIL_PASSWORD` di .env

**Untuk Testing Lokal (tanpa kirim email):**
```env
MAIL_MAILER=log
```
OTP akan disimpan di `storage/logs/laravel.log`

### 6. Jalankan Migration
```bash
php artisan migrate
```

### 7. Jalankan Server
```bash
php artisan serve
```

Server akan berjalan di `http://localhost:8000`

## 🧪 Testing API

### Menggunakan Postman

1. Import file `postman_collection.json` ke Postman
2. Set environment variable `base_url` = `http://localhost:8000`
3. Testing flow:
   - **Register** → Cek email untuk OTP
   - **Verify OTP** → Input kode OTP 6 digit
   - **Login** → Token akan otomatis tersimpan
   - **Get User** → Menggunakan token dari login
   - **Logout** → Hapus token

### Testing Manual dengan cURL

**1. Register**
```bash
curl -X POST http://localhost:8000/api/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "username": "johndoe",
    "email": "john@example.com",
    "telp": "081234567890",
    "password": "password123",
    "password_confirmation": "password123",
    "role": "peserta"
  }'
```

**2. Verify OTP**
```bash
curl -X POST http://localhost:8000/api/verify-otp \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "otp": "123456"
  }'
```

**3. Login**
```bash
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

**4. Get User (dengan token)**
```bash
curl -X GET http://localhost:8000/api/me \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## 📁 File-File Penting

```
app/
├── Http/Controllers/
│   └── AuthController.php          # Controller untuk autentikasi
├── Models/
│   ├── User.php                    # Model User dengan HasApiTokens
│   └── Otp.php                     # Model OTP
└── Mail/
    └── OtpMail.php                 # Mail class untuk kirim OTP

database/migrations/
├── 0001_01_01_000000_create_users_table.php
└── 2025_10_28_135045_create_otps_table.php

resources/views/emails/
└── otp.blade.php                   # Template email OTP

routes/
└── api.php                         # API routes

API_DOCUMENTATION.md                # Dokumentasi lengkap API
postman_collection.json            # Postman collection untuk testing
```

## 🔐 Security

- Password di-hash menggunakan bcrypt
- OTP berlaku 10 menit
- Email harus diverifikasi sebelum login
- Token menggunakan Laravel Sanctum
- Validasi input di semua endpoint

## 📝 Catatan

- OTP adalah 6 digit angka random
- Setiap user bisa memiliki multiple OTP (history)
- OTP yang sudah diverifikasi tidak bisa digunakan lagi
- User harus verifikasi email sebelum bisa login
- Token harus disertakan di header untuk protected routes

## 🐛 Troubleshooting

**Email tidak terkirim:**
- Cek konfigurasi MAIL di .env
- Pastikan App Password Gmail sudah benar
- Cek `storage/logs/laravel.log` untuk error

**Migration error:**
- Pastikan database sudah dibuat
- Jalankan `php artisan migrate:fresh` untuk reset

**Token tidak valid:**
- Pastikan header Authorization format: `Bearer {token}`
- Token harus dari endpoint login

## 📞 Support

Untuk pertanyaan atau issue, silakan buka issue di repository ini.
