# API Authentication Documentation

## Base URL
```
http://localhost:8000/api
```

## Endpoints

### 1. Register
**POST** `/register`

Mendaftarkan user baru dan mengirim OTP ke email.

**Request Body:**
```json
{
    "name": "John Doe",
    "username": "johndoe",
    "email": "john@example.com",
    "telp": "081234567890",
    "password": "password123",
    "password_confirmation": "password123",
    "role": "peserta"
}
```

**Validation Rules:**
- `name`: required, string, max 255
- `username`: required, string, max 255, unique
- `email`: required, email, max 255, unique
- `telp`: required, string, max 20
- `password`: required, string, min 8, confirmed
- `role`: required, enum (superadmin, peserta)

**Response Success (201):**
```json
{
    "success": true,
    "message": "User registered successfully. Please check your email for OTP code.",
    "data": {
        "user": {
            "id": 1,
            "name": "John Doe",
            "username": "johndoe",
            "email": "john@example.com",
            "telp": "081234567890",
            "role": "peserta"
        }
    }
}
```

**Response Error - Validation (422):**
```json
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "email": ["The email has already been taken."],
        "username": ["The username has already been taken."]
    }
}
```

**Response Error - Email Failed (500):**
```json
{
    "success": false,
    "message": "User created but failed to send OTP email",
    "error": "Connection could not be established..."
}
```

---

### 2. Verify OTP
**POST** `/verify-otp`

Memverifikasi OTP yang dikirim via email.

**Request Body:**
```json
{
    "email": "john@example.com",
    "otp": "123456"
}
```

**Validation Rules:**
- `email`: required, email
- `otp`: required, string, size 6

**Response Success (200):**
```json
{
    "success": true,
    "message": "Email verified successfully"
}
```

**Response Error - Invalid OTP (400):**
```json
{
    "success": false,
    "message": "Invalid OTP code"
}
```

**Response Error - OTP Expired (400):**
```json
{
    "success": false,
    "message": "OTP code has expired"
}
```

**Response Error - User Not Found (404):**
```json
{
    "success": false,
    "message": "User not found"
}
```

---

### 3. Resend OTP
**POST** `/resend-otp`

Mengirim ulang OTP ke email.

**Request Body:**
```json
{
    "email": "john@example.com"
}
```

**Validation Rules:**
- `email`: required, email

**Response Success (200):**
```json
{
    "success": true,
    "message": "OTP code has been resent to your email"
}
```

**Response Error - User Not Found (404):**
```json
{
    "success": false,
    "message": "User not found"
}
```

**Response Error - Already Verified (400):**
```json
{
    "success": false,
    "message": "Email already verified"
}
```

**Response Error - Email Failed (500):**
```json
{
    "success": false,
    "message": "Failed to send OTP email",
    "error": "Connection could not be established..."
}
```

---

### 4. Login
**POST** `/login`

Login user dan mendapatkan access token.

**Request Body:**
```json
{
    "email": "john@example.com",
    "password": "password123"
}
```

**Validation Rules:**
- `email`: required, email
- `password`: required, string

**Response Success (200):**
```json
{
    "success": true,
    "message": "Login successful",
    "data": {
        "user": {
            "id": 1,
            "name": "John Doe",
            "username": "johndoe",
            "email": "john@example.com",
            "telp": "081234567890",
            "role": "peserta",
            "email_verified_at": "2025-10-28T12:00:00.000000Z"
        },
        "access_token": "1|abcdefghijklmnopqrstuvwxyz",
        "token_type": "Bearer"
    }
}
```

**Response Error - Invalid Credentials (401):**
```json
{
    "success": false,
    "message": "Invalid credentials"
}
```

**Response Error - Email Not Verified (403):**
```json
{
    "success": false,
    "message": "Please verify your email first"
}
```

---

### 5. Logout (Protected)
**POST** `/logout`

Logout user dan menghapus token saat ini.

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response Success (200):**
```json
{
    "success": true,
    "message": "Logout successful"
}
```

**Response Error - Unauthorized (401):**
```json
{
    "message": "Unauthenticated."
}
```

---

### 6. Get Current User (Protected)
**GET** `/me`

Mendapatkan informasi user yang sedang login.

**Headers:**
```
Authorization: Bearer {access_token}
```

**Response Success (200):**
```json
{
    "success": true,
    "data": {
        "user": {
            "id": 1,
            "name": "John Doe",
            "username": "johndoe",
            "email": "john@example.com",
            "telp": "081234567890",
            "role": "peserta",
            "email_verified_at": "2025-10-28T12:00:00.000000Z"
        }
    }
}
```

**Response Error - Unauthorized (401):**
```json
{
    "message": "Unauthenticated."
}
```

---

## Konfigurasi Email

Untuk menggunakan fitur OTP email, update file `.env`:

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

### Cara Mendapatkan App Password Gmail:
1. Buka Google Account Settings
2. Pergi ke Security
3. Aktifkan 2-Step Verification
4. Buat App Password untuk aplikasi
5. Gunakan password tersebut di MAIL_PASSWORD

---

## Testing Flow

1. **Register** → Kirim data registrasi
2. **Check Email** → Dapatkan OTP code (6 digit)
3. **Verify OTP** → Verifikasi dengan OTP code
4. **Login** → Login dengan email dan password
5. **Use Token** → Gunakan access token untuk endpoint yang protected

---

## Error Codes

- `200` - Success
- `201` - Created
- `400` - Bad Request
- `401` - Unauthorized
- `403` - Forbidden
- `404` - Not Found
- `422` - Validation Error
- `500` - Internal Server Error

---

## Notes

- OTP berlaku selama **10 menit**
- User harus verifikasi email sebelum bisa login
- Access token menggunakan Laravel Sanctum
- Token tidak memiliki expiration time (berlaku sampai logout)
- Semua endpoint yang protected memerlukan header `Authorization: Bearer {token}`
- Password minimal 8 karakter
- Role hanya menerima: `superadmin` atau `peserta`
- Email dan username harus unique

---

## Security Best Practices

- Jangan share OTP code dengan siapapun
- OTP hanya valid 10 menit
- Logout setelah selesai menggunakan aplikasi
- Gunakan HTTPS di production
- Simpan token dengan aman di client (localStorage/cookie dengan httpOnly)

---

## Common Errors & Solutions

| Error Code | Message | Solution |
|------------|---------|----------|
| 422 | Validation error | Cek field yang required dan formatnya |
| 401 | Invalid credentials | Cek email dan password |
| 403 | Please verify your email first | Verify OTP terlebih dahulu |
| 400 | Invalid OTP code | Cek kembali OTP atau request resend |
| 400 | OTP code has expired | Request resend OTP |
| 404 | User not found | Pastikan email sudah terdaftar |
| 401 | Unauthenticated | Token invalid/expired, login ulang |
