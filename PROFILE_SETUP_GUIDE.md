# Setup Guide - Profile Management Feature

## Quick Start

### 1. Buat Symbolic Link untuk Storage
Jalankan command ini untuk membuat symbolic link agar file di `storage/app/public` bisa diakses dari browser:

```bash
php artisan storage:link
```

**Output yang diharapkan:**
```
The [public\storage] link has been connected to [storage\app\public].
```

### 2. Pastikan Directory Permissions
Pastikan folder storage memiliki permission yang benar:

**Windows:**
```powershell
# Biasanya tidak perlu setting permission di Windows
```

**Linux/Mac:**
```bash
chmod -R 775 storage
chmod -R 775 bootstrap/cache
```

### 3. Test Endpoint

#### A. Login Terlebih Dahulu
```bash
POST http://localhost:8000/api/login
Content-Type: application/json

{
    "username": "your_username",
    "password": "your_password"
}
```

**Response:**
```json
{
    "success": true,
    "message": "Login successful",
    "token": "15|xxxxxxxxxxxxxxx",
    "user": { ... }
}
```

#### B. Test Get Profile
```bash
GET http://localhost:8000/api/profile
Authorization: Bearer 15|xxxxxxxxxxxxxxx
Accept: application/json
```

### 4. Import Postman Collection
1. Buka Postman
2. Click **Import**
3. Pilih file `profile_api_postman_collection.json`
4. Set variable `base_url` ke `http://localhost:8000/api`
5. Login untuk mendapat token (token akan otomatis tersimpan)
6. Test semua endpoint

---

## 📝 Endpoint List

### Peserta Endpoints:
```
GET    /api/profile                 - Get profile peserta
POST   /api/profile/update          - Update profile (name, telp, foto)
POST   /api/profile/change-password - Change password
```

---

## Authentication

Semua endpoint memerlukan:
- **Header:** `Authorization: Bearer {token}`
- **Header:** `Accept: application/json`

---

## 📸 Upload Foto Profile

Untuk upload foto (hanya peserta):

### Menggunakan JSON (tanpa foto):
```bash
POST http://localhost:8000/api/profile/update
Authorization: Bearer {token}
Content-Type: application/json

{
    "name": "Nama Lengkap",
    "telp": "+62 xxx"
}
```

### Menggunakan Form Data (dengan foto):
```bash
POST http://localhost:8000/api/profile/update
Authorization: Bearer {token}
Content-Type: multipart/form-data

Form Data:
- name: Nama Lengkap (optional)
- telp: +62 xxx (optional)
- profile_photo: [file] (optional, max 2MB, jpeg/png/jpg/gif)
```

---

## 📂 Struktur Folder

```
storage/
├── app/
│   ├── public/
│   │   └── profile_photos/     ← Foto profile disimpan di sini
│   └── private/
└── logs/

public/
└── storage/                     ← Symbolic link ke storage/app/public
```

---

## ⚠️ Troubleshooting

### Error: "The file link already exists"
Jika sudah pernah jalankan `storage:link`:
```bash
# Hapus link yang ada
rm public/storage

# Buat link baru
php artisan storage:link
```

### Error: "Failed to open stream: Permission denied"
**Linux/Mac:**
```bash
sudo chmod -R 775 storage
sudo chown -R www-data:www-data storage
```

### Error: 401 Unauthorized
- Pastikan token valid
- Token didapat setelah login
- Format header: `Authorization: Bearer {token}`

### Error: 403 Forbidden
- Check role user
- Endpoint `/api/profile/*` hanya untuk role `peserta`
- Endpoint `/api/admin/profile/*` hanya untuk role `superadmin`

### Foto tidak muncul
1. Pastikan sudah jalankan `php artisan storage:link`
2. Check folder `storage/app/public/profile_photos` ada
3. Check permission folder
4. Check `APP_URL` di `.env` sudah benar

### Error: "Email cannot be updated"
- Email memang **TIDAK BISA** diupdate (by design)
- Email bersifat permanent untuk keamanan
- Hanya bisa update: name, telp, foto

## 📚 Dokumentasi Lengkap

Lihat dokumentasi detail di:
- `PROFILE_API_DOCUMENTATION.md` - API Documentation lengkap
