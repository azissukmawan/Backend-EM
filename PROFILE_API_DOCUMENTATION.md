# Profile API Documentation

## Deskripsi
API untuk mengelola profile user (peserta dan admin) dengan proteksi authentication menggunakan Laravel Sanctum.

**Base URL**: `/api`

---

## Authentication
Semua endpoint profile memerlukan authentication token. Token didapat setelah login.

**Header yang diperlukan:**
```
Authorization: Bearer {token}
Accept: application/json
```

---

## Endpoint Profile Peserta

### 1. Get Profile Peserta
Mendapatkan informasi profile user yang sedang login (role: peserta).

**Endpoint:** `GET /api/profile`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Response Success (200):**
```json
{
    "success": true,
    "message": "Profile retrieved successfully",
    "data": {
        "id": 16,
        "name": "Akbar Maulana",
        "username": "amawannn",
        "email": "amawannn@gmail.com",
        "telp": "+62 895-1720-0895",
        "role": "peserta",
        "email_verified_at": "2025-10-30T03:10:28.000000Z",
        "profile_photo": "http://localhost:8000/storage/profile_photos/xxx.jpg",
        "status_karyawan": 1
    }
}
```

**Response Error (403) - Bukan Peserta:**
```json
{
    "success": false,
    "message": "Access denied. This endpoint is only for peserta."
}
```

**Response Error (401) - Tidak Login:**
```json
{
    "message": "Unauthenticated."
}
```

---

### 2. Update Profile Peserta
Mengupdate informasi profile peserta (nama, telp, foto).

**⚠️ Note:** Email **TIDAK BISA** diupdate (permanent untuk keamanan).

**Endpoint:** `POST /api/profile/update`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
Content-Type: application/json (tanpa foto)
Content-Type: multipart/form-data (dengan foto)
```

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| name | string | No | Nama lengkap user |
| telp | string | No | Nomor WhatsApp (max: 20 karakter, unique) |
| profile_photo | file | No | Foto profile (jpeg, png, jpg, gif, max: 2MB) |

**Example Request (JSON - tanpa foto):**
```json
{
    "name": "Akbar Maulana Updated",
    "telp": "+62 895-1720-0896"
}
```

**Example Request (Form Data - dengan foto):**
```
POST /api/profile/update
Content-Type: multipart/form-data

name: Akbar Maulana Updated
telp: +62 895-1720-0896
profile_photo: [file]
```

**Response Success (200):**
```json
{
    "success": true,
    "message": "Profile updated successfully",
    "data": {
        "id": 16,
        "name": "Akbar Maulana Updated",
        "username": "amawannn",
        "email": "amawannn@gmail.com",
        "telp": "+62 895-1720-0896",
        "role": "peserta",
        "email_verified_at": "2025-10-30T03:10:28.000000Z",
        "profile_photo": "http://localhost:8000/storage/profile_photos/new_photo.jpg",
        "status_karyawan": 1
    }
}
```

**Response Error (400) - Trying to update email:**
```json
{
    "success": false,
    "message": "Email cannot be updated.",
    "note": "Email is permanent and cannot be changed for security reasons"
}
```

**Response Error (422) - Validation Error:**
```json
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "telp": ["The telp has already been taken."],
        "profile_photo": ["The profile photo must be an image."]
    }
}
```

---

### 3. Change Password (Peserta)
Mengubah password user yang sedang login.

**Endpoint:** `POST /api/profile/change-password`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
Content-Type: application/json
```

**Request Body:**
```json
{
    "current_password": "password123",
    "new_password": "newpassword123",
    "new_password_confirmation": "newpassword123"
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| current_password | string | Yes | Password saat ini |
| new_password | string | Yes | Password baru (min: 8 karakter) |
| new_password_confirmation | string | Yes | Konfirmasi password baru |

**Response Success (200):**
```json
{
    "success": true,
    "message": "Password changed successfully"
}
```

**Response Error (401) - Wrong Password:**
```json
{
    "success": false,
    "message": "Current password is incorrect"
}
```

**Response Error (422) - Validation Error:**
```json
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "new_password": ["The new password must be at least 8 characters."],
        "new_password_confirmation": ["The new password confirmation does not match."]
    }
}
```

## Error Responses

### 401 Unauthorized
Token tidak valid atau user belum login.
```json
{
    "message": "Unauthenticated."
}
```

### 403 Forbidden
User tidak memiliki akses ke endpoint tersebut (role tidak sesuai).
```json
{
    "success": false,
    "message": "Access denied. This endpoint is only for peserta/admin."
}
```

### 422 Unprocessable Entity
Validation error pada request data.
```json
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "field_name": ["Error message"]
    }
}
```

### 500 Internal Server Error
Terjadi error pada server.
```json
{
    "success": false,
    "message": "Failed to retrieve/update profile",
    "error": "Error details"
}
```

---

## Testing dengan Postman/Thunder Client

### 1. Login terlebih dahulu
```
POST /api/login
Content-Type: application/json

{
    "username": "amawannn",
    "password": "password123"
}
```

### 2. Simpan token dari response
```json
{
    "success": true,
    "token": "15|xxxxxxxxxxxxx",
    "user": { ... }
}
```

### 3. Test endpoint profile
Gunakan token di header:
```
Authorization: Bearer 15|xxxxxxxxxxxxx
```

---

## Catatan Penting

### Field yang Bisa Diupdate:

**Peserta:**
- ✅ `name` - Nama lengkap
- ✅ `telp` - Nomor WhatsApp (unique)
- ✅ `profile_photo` - Foto profile (upload file)
- ❌ `email` - **TIDAK BISA** (permanent)

### Profile Photo:
- Foto profile disimpan di `storage/app/public/profile_photos`
- Hanya peserta yang memiliki foto profile (di tabel `detail_peserta`)
- Admin tidak memiliki foto profile
- Format: jpeg, png, jpg, gif
- Max size: 2MB
- Old photo otomatis dihapus saat upload baru

### Email:
- Email **PERMANENT** dan **TIDAK BISA** diubah
- `email_verified_at` **TIDAK AKAN PERNAH** hilang saat update profile
- Untuk keamanan dan konsistensi data

### Storage:
Pastikan sudah jalankan:
```bash
php artisan storage:link
```
