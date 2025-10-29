# Dokumentasi Alur Sistem Backend - Event Management

> **Status:** 🚧 Dalam Pengembangan (v1.0.0)  
> **Fitur Saat Ini:** Authentication & User Management  
> **Fitur Selanjutnya:** Event Management, Ticketing, Dashboard Admin, dan lainnya

## 📋 Daftar Isi
1. [Pengenalan Sistem](#pengenalan-sistem)
2. [Cara Kerja Pendaftaran & Login](#cara-kerja-pendaftaran--login)
3. [Struktur Database](#struktur-database)
4. [Daftar Fitur API](#daftar-fitur-api)
5. [Keamanan Sistem](#keamanan-sistem)
6. [Roadmap Pengembangan](#roadmap-pengembangan)

---

## 💡 Pengenalan Sistem

### Apa itu Sistem Backend?

Backend adalah "otak" dari aplikasi yang bekerja di balik layar. Ketika Anda:
- Mendaftar akun baru
- Login ke aplikasi
- Melihat profil Anda

Semua proses tersebut dikelola oleh backend.

### Teknologi yang Digunakan

```
┌─────────────────────────────────────────┐
│    Aplikasi yang Anda Lihat             │
│    (HP/Website)                         │
└──────────────┬──────────────────────────┘
               │ 
               │ Kirim & Terima Data
               │ 
┌──────────────▼──────────────────────────┐
│         BACKEND SISTEM                  │
│  (Mengolah Data & Logika Bisnis)        │
│  ┌─────────────────────────────────┐   │
│  │  Menerima Permintaan            │   │
│  │  (Register, Login, dll)         │   │
│  └──────────┬──────────────────────┘   │
│             │                           │
│  ┌──────────▼──────────────────────┐   │
│  │  Cek Keamanan & Validasi        │   │
│  │  (Password benar? Email valid?) │   │
│  └──────────┬──────────────────────┘   │
│             │                           │
│  ┌──────────▼──────────────────────┐   │
│  │  Proses Data                    │   │
│  │  (Buat akun, cek login, dll)    │   │
│  └──────────┬──────────────────────┘   │
│             │                           │
│  ┌──────────▼──────────────────────┐   │
│  │  Kirim Email                    │   │
│  │  (Kode OTP verifikasi)          │   │
│  └─────────────────────────────────┘   │
└─────────────┼──────────────────────────┘
              │
┌─────────────▼──────────────────────────┐
│       Database (Penyimpanan Data)       │
│  - Data Pengguna                        │
│  - Kode OTP                             │
│  - Token Login                          │
│  - dll                                  │
└─────────────────────────────────────────┘
```

**Penjelasan Sederhana:**
1. **Aplikasi** = Yang Anda lihat dan sentuh
2. **Backend** = Otak yang memproses semua permintaan
3. **Database** = Tempat menyimpan semua data

---

## 🔐 Cara Kerja Pendaftaran & Login

### 1. Alur Pendaftaran Akun Baru

**Langkah-langkah yang terjadi:**

```
Anda mengisi form pendaftaran
         ↓
Sistem cek: Apakah email sudah terdaftar?
         ↓
    ┌────┴────┐
    │         │
   YA        TIDAK
    │         │
    │         ↓
    │    Buat akun baru
    │         ↓
    │    Buat kode OTP (6 angka random)
    │         ↓
    │    Kirim kode OTP ke email Anda
    │         ↓
    │    Berhasil! Cek email Anda
    │
    ↓
Gagal! Email sudah digunakan
```

**Penjelasan Detail:**

**Step 1:** Anda mengisi form
```
Nama Lengkap    : Budi Santoso
Username        : budisantoso
Email           : budi@gmail.com
No. Telepon     : 081234567890
Password        : rahasia123
Konfirmasi Pass : rahasia123
Peran          : peserta
```

**Step 2:** Sistem melakukan pengecekan
- ✅ Apakah semua kolom sudah diisi?
- ✅ Apakah format email benar? (ada @gmail.com)
- ✅ Apakah password minimal 8 karakter?
- ✅ Apakah password dan konfirmasi sama?
- ✅ Apakah email belum terdaftar?
- ✅ Apakah username belum dipakai?

**Step 3:** Jika semua OK, sistem akan:
1. Simpan data Anda ke database
2. Password Anda di-enkripsi (diamankan)
3. Buat kode OTP random (contoh: **587234**)
4. Kirim kode OTP ke email Anda
5. Kode OTP berlaku 10 menit saja

**Step 4:** Anda mendapat response
```json
✅ Response Berhasil (201 Created):
{
    "success": true,
    "message": "User registered successfully. Please check your email for OTP code.",
    "data": {
        "user": {
            "id": 1,
            "name": "Budi Santoso",
            "username": "budisantoso",
            "email": "budi@gmail.com",
            "telp": "081234567890",
            "role": "peserta"
        }
    }
}
```

**Jika Ada Error:**
```json
❌ Email sudah terdaftar (422 Validation Error):
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "email": ["The email has already been taken."]
    }
}

❌ Username sudah dipakai (422 Validation Error):
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "username": ["The username has already been taken."]
    }
}

❌ Password terlalu pendek (422 Validation Error):
{
    "success": false,
    "message": "Validation error",
    "errors": {
        "password": ["The password field must be at least 8 characters."]
    }
}
```

---

### 2. Alur Verifikasi Email (Input Kode OTP)

**Langkah-langkah yang terjadi:**

```
Anda buka email dan lihat kode OTP
         ↓
Anda masukkan kode OTP di aplikasi
         ↓
Sistem cek: Apakah kode OTP benar?
         ↓
    ┌────┴────┐
    │         │
   YA        TIDAK
    │         │
    │         ↓
    │    Gagal! Kode salah atau kadaluarsa
    │
    ↓
Sistem cek: Apakah kode belum expired?
         ↓
    ┌────┴────┐
    │         │
   YA        TIDAK
    │         │
    │         ↓
    │    Gagal! Kode sudah kadaluarsa (lebih dari 10 menit)
    │
    ↓
Tandai email sebagai terverifikasi
         ↓
✅ Berhasil! Sekarang Anda bisa login
```

**Penjelasan Detail:**

**Anda menerima email seperti ini:**
```
━━━━━━━━━━━━━━━━━━━━━━━━
📧 Verifikasi Email

Halo Budi Santoso,

Kode OTP Anda:
   ┌─────────┐
   │ 587234  │
   └─────────┘

Kode berlaku 10 menit
━━━━━━━━━━━━━━━━━━━━━━━━
```

**Yang terjadi di sistem:**
1. Sistem cari: Apakah ada kode **587234** untuk email **budi@gmail.com**?
2. Jika ada, cek: Apakah kodenya masih berlaku? (belum 10 menit)
3. Jika masih berlaku, tandai email sebagai **VERIFIED** ✅
4. Sekarang Anda bisa login!

**Response yang Anda terima:**

```json
✅ Berhasil (200 OK):
{
    "success": true,
    "message": "Email verified successfully"
}

❌ Kode OTP Salah (400 Bad Request):
{
    "success": false,
    "message": "Invalid OTP code"
}

❌ Kode OTP Kadaluarsa (400 Bad Request):
{
    "success": false,
    "message": "OTP code has expired"
}

❌ Email Tidak Ditemukan (404 Not Found):
{
    "success": false,
    "message": "User not found"
}
```

---

### 3. Alur Login ke Aplikasi

**Langkah-langkah yang terjadi:**

```
Anda input email & password
         ↓
Sistem cari: Apakah email terdaftar?
         ↓
    ┌────┴────┐
    │         │
  TIDAK       YA
    │         │
    │         ↓
    │    Cek: Apakah password benar?
    │         ↓
    │    ┌────┴────┐
    │    │         │
    │  SALAH      BENAR
    │    │         │
    │    │         ↓
    │    │    Cek: Apakah email sudah diverifikasi?
    │    │         ↓
    │    │    ┌────┴────┐
    │    │    │         │
    │    │  BELUM      SUDAH
    │    │    │         │
    │    │    │         ↓
    │    │    │    Buat Token Login
    │    │    │         ↓
    │    │    │    ✅ Login Berhasil!
    │    │    │
    │    │    ↓
    │    │    ❌ Verifikasi email dulu!
    │    │
    │    ↓
    │    ❌ Password salah!
    │
    ↓
❌ Email tidak terdaftar!
```

**Penjelasan Detail:**

**Anda input:**
```
Email    : budi@gmail.com
Password : rahasia123
```

**Sistem melakukan:**

1. **Cek Email**
   - Cari di database: Apakah ada email **budi@gmail.com**?
   - Jika tidak ada → ❌ "Email atau password salah"

2. **Cek Password**
   - Bandingkan password yang Anda ketik dengan yang di database
   - Password di database sudah di-enkripsi (diamankan)
   - Jika tidak sama → ❌ "Email atau password salah"

3. **Cek Verifikasi Email**
   - Apakah Anda sudah verifikasi email dengan OTP?
   - Jika belum → ❌ "Silakan verifikasi email Anda terlebih dahulu"

4. **Jika Semua OK:**
   - Buat **Token Login** (seperti kunci digital)
   - Token ini akan dipakai untuk akses selanjutnya
   - ✅ Login berhasil!

**Response yang Anda terima:**

```json
✅ Login Berhasil (200 OK):
{
    "success": true,
    "message": "Login successful",
    "data": {
        "user": {
            "id": 1,
            "name": "Budi Santoso",
            "username": "budisantoso",
            "email": "budi@gmail.com",
            "telp": "081234567890",
            "role": "peserta",
            "email_verified_at": "2025-10-28T12:00:00.000000Z"
        },
        "access_token": "1|kunci_rahasia_budi_untuk_akses_aplikasi",
        "token_type": "Bearer"
    }
}

❌ Email/Password Salah (401 Unauthorized):
{
    "success": false,
    "message": "Invalid credentials"
}

❌ Email Belum Diverifikasi (403 Forbidden):
{
    "success": false,
    "message": "Please verify your email first"
}
```

**Token ini seperti:**
- Kartu akses hotel → Buka pintu kamar
- Kunci mobil → Nyalakan mesin
- Token login → Akses fitur aplikasi

---

### 4. Alur Menggunakan Fitur (Setelah Login)

**Langkah-langkah yang terjadi:**

```
Anda minta data profil
(dengan menyertakan Token Login)
         ↓
Sistem cek: Apakah Token valid?
         ↓
    ┌────┴────┐
    │         │
  TIDAK       YA
    │         │
    │         ↓
    │    Ambil data profil Anda
    │         ↓
    │    Kirim data ke aplikasi
    │         ↓
    │    ✅ Tampilkan profil
    │
    ↓
❌ Silakan login dulu!
```

**Penjelasan Detail:**

Setiap kali Anda mau akses fitur yang butuh login, sistem akan:

1. **Cek Token**
   - Apakah Anda sudah login? (punya token?)
   - Apakah token masih valid?

2. **Jika Valid**
   - Sistem tahu siapa Anda dari token
   - Ambil data sesuai permintaan
   - Kirim data ke aplikasi Anda

3. **Jika Tidak Valid**
   - Suruh login lagi
   - Token mungkin sudah logout atau invalid

---

### 5. Alur Logout

**Langkah-langkah yang terjadi:**

```
Anda klik tombol Logout
         ↓
Sistem hapus Token Login Anda
         ↓
✅ Logout berhasil!
         ↓
Token tidak bisa dipakai lagi
```

**Penjelasan:**
- Token login Anda akan dihapus dari sistem
- Seperti mengembalikan kunci hotel saat check-out
- Untuk akses lagi, harus login ulang

**Response:**
```json
✅ Logout Berhasil (200 OK):
{
    "success": true,
    "message": "Logout successful"
}

❌ Token Tidak Valid (401 Unauthorized):
{
    "message": "Unauthenticated."
}
```

---

### 6. Alur Kirim Ulang Kode OTP

**Kapan digunakan?**
- Kode OTP sudah kadaluarsa (lebih dari 10 menit)
- Email OTP tidak masuk
- Kode OTP hilang/terlupa

**Langkah-langkah:**

```
Anda klik "Kirim Ulang OTP"
         ↓
Input email Anda
         ↓
Sistem cek: Apakah email terdaftar?
         ↓
    ┌────┴────┐
    │         │
  TIDAK       YA
    │         │
    │         ↓
    │    Cek: Apakah email sudah diverifikasi?
    │         ↓
    │    ┌────┴────┐
    │    │         │
    │  SUDAH      BELUM
    │    │         │
    │    │         ↓
    │    │    Buat kode OTP baru
    │    │         ↓
    │    │    Kirim ke email Anda
    │    │         ↓
    │    │    ✅ OTP baru terkirim!
    │    │
    │    ↓
    │    ❌ Email sudah terverifikasi!
    │
    ↓
❌ Email tidak terdaftar!
```

**Response yang Anda terima:**

```json
✅ OTP Terkirim Ulang (200 OK):
{
    "success": true,
    "message": "OTP code has been resent to your email"
}

❌ Email Sudah Diverifikasi (400 Bad Request):
{
    "success": false,
    "message": "Email already verified"
}

❌ Email Tidak Terdaftar (404 Not Found):
{
    "success": false,
    "message": "User not found"
}

❌ Gagal Kirim Email (500 Internal Server Error):
{
    "success": false,
    "message": "Failed to send OTP email",
    "error": "Connection could not be established..."
}
```

---

## 🗄️ Struktur Database

### Apa itu Database?

Database adalah **lemari penyimpanan digital** tempat semua data aplikasi disimpan. Seperti:
- Lemari arsip → Menyimpan dokumen
- Database → Menyimpan data digital

### Tabel-Tabel dalam Database

Bayangkan database seperti lemari dengan banyak laci. Setiap laci = 1 tabel.

#### 1. Tabel `users` (Data Pengguna)

**Isi tabel ini:**
```
┌──────────────────────────────────────────────────┐
│ TABEL USERS - Daftar Semua Pengguna             │
├────┬─────────────┬──────────────┬────────────────┤
│ ID │ Nama        │ Email        │ Role           │
├────┼─────────────┼──────────────┼────────────────┤
│ 1  │ Budi        │ budi@...     │ peserta        │
│ 2  │ Admin Satu  │ admin1@...   │ superadmin     │
│ 3  │ Ani         │ ani@...      │ peserta        │
└────┴─────────────┴──────────────┴────────────────┘
```

**Data yang disimpan:**
- ID → Nomor unik setiap pengguna
- Nama → Nama lengkap
- Username → Nama untuk login (unik)
- Email → Email pengguna (unik)
- No. Telepon → Kontak
- Role → Peran (peserta atau superadmin)
- Password → Rahasia (ter-enkripsi)
- Email Verified → Sudah verifikasi atau belum?
- Tanggal Daftar → Kapan akun dibuat

#### 2. Tabel `otps` (Kode Verifikasi)

**Isi tabel ini:**
```
┌────────────────────────────────────────────────────┐
│ TABEL OTPs - Daftar Kode Verifikasi               │
├────┬─────────┬────────┬──────────────┬────────────┤
│ ID │ User ID │ Kode   │ Kadaluarsa   │ Status     │
├────┼─────────┼────────┼──────────────┼────────────┤
│ 1  │ 1       │ 587234 │ 21:30:00     │ Terpakai   │
│ 2  │ 3       │ 123456 │ 22:15:00     │ Belum      │
└────┴─────────┴────────┴──────────────┴────────────┘
```

**Data yang disimpan:**
- ID → Nomor unik kode OTP
- User ID → Untuk pengguna mana kode ini?
- Kode → Kode 6 angka (contoh: 587234)
- Kadaluarsa → Kapan kode tidak berlaku lagi
- Verified At → Kapan kode dipakai
- Tanggal Dibuat → Kapan kode dibuat

#### 3. Tabel `personal_access_tokens` (Token Login)

**Isi tabel ini:**
```
┌──────────────────────────────────────────────────┐
│ TABEL TOKENS - Daftar Kunci Akses Login         │
├────┬─────────┬──────────────────┬───────────────┤
│ ID │ User ID │ Token (Kunci)    │ Terakhir Akses│
├────┼─────────┼──────────────────┼───────────────┤
│ 1  │ 1       │ kunci_budi_xxx   │ 5 menit lalu  │
│ 2  │ 2       │ kunci_admin_yyy  │ 1 jam lalu    │
└────┴─────────┴──────────────────┴───────────────┘
```

**Data yang disimpan:**
- ID → Nomor unik token
- User ID → Token milik siapa?
- Token → Kunci akses (ter-enkripsi)
- Nama → Nama device/session
- Terakhir Digunakan → Kapan terakhir akses
- Tanggal Dibuat → Kapan token dibuat

#### 4. Tabel `detail_peserta` (Detail Peserta)

**Untuk menyimpan informasi tambahan khusus peserta.**

#### 5. Tabel `detail_admin` (Detail Admin)

**Untuk menyimpan informasi tambahan khusus admin.**

### Hubungan Antar Tabel

**Analogi Sederhana:**

Bayangkan seperti KTP dan SIM:
- **KTP** (users) → Data utama Anda
- **SIM** (detail_peserta/admin) → Data tambahan sesuai kebutuhan
- **Kode OTP** (otps) → Kode verifikasi sementara
- **Token Login** (tokens) → Kartu akses sementara

```
PENGGUNA (users)
    │
    ├─── Punya banyak KODE OTP (otps)
    │    Contoh: Budi punya 3 kode OTP (yang lama & baru)
    │
    ├─── Punya banyak TOKEN LOGIN (tokens)
    │    Contoh: Budi login di HP & Laptop = 2 token
    │
    └─── Punya 1 DETAIL TAMBAHAN
         ├─ Jika Peserta → detail_peserta
         └─ Jika Admin → detail_admin
```

---

## 🔌 Daftar Fitur API

### Apa itu API?

**API** = Cara aplikasi berkomunikasi dengan backend.

**Analogi:**
- API seperti **menu restoran**
- Anda pesan menu tertentu → Restoran kasih makanan
- Anda panggil API tertentu → Backend kasih data

### Fitur yang Bisa Diakses Tanpa Login

| Fitur | Cara Pakai | Fungsi |
|-------|------------|--------|
| **Daftar Akun** | `/api/register` | Buat akun baru |
| **Verifikasi Email** | `/api/verify-otp` | Input kode OTP |
| **Kirim Ulang OTP** | `/api/resend-otp` | Minta kode OTP baru |
| **Login** | `/api/login` | Masuk ke aplikasi |

### Fitur yang Harus Login Dulu

| Fitur | Cara Pakai | Fungsi |
|-------|------------|--------|
| **Logout** | `/api/logout` | Keluar dari aplikasi |
| **Lihat Profil** | `/api/me` | Lihat data profil Anda |

**Catatan:** 
- ✅ = Bisa diakses siapa saja
- 🔒 = Harus login dulu (pakai token)

---

## 🛡️ Keamanan Sistem

### 1. Password Anda Aman!

**Yang terjadi dengan password Anda:**

```
Password Anda ketik: "rahasia123"
         ↓
Sistem TIDAK simpan "rahasia123"
         ↓
Sistem ubah jadi kode acak:
"$2y$10$abcd1234efgh5678ijkl9012..."
         ↓
Kode acak ini yang disimpan di database
```

**Kenapa aman?**
- Tidak ada yang bisa baca password asli Anda
- Admin pun tidak tahu password Anda
- Kalaupun database bocor, password tetap aman

**Saat login:**
```
Anda ketik: "rahasia123"
         ↓
Sistem ubah jadi kode acak
         ↓
Bandingkan dengan kode acak di database
         ↓
Sama? → Login berhasil!
Beda? → Password salah!
```

### 2. Verifikasi Email Wajib!

**Kenapa harus verifikasi email?**
- ✅ Memastikan email Anda benar
- ✅ Mencegah spam/akun palsu
- ✅ Bisa reset password kalau lupa

**Tanpa verifikasi:**
- ❌ Tidak bisa login
- ❌ Tidak bisa akses fitur

### 3. Kode OTP Aman

**Keamanan kode OTP:**
- Kode random 6 digit → Sulit ditebak
- Berlaku 10 menit saja → Cepat kadaluarsa
- Hanya bisa dipakai 1 kali → Tidak bisa dipakai lagi
- Dikirim ke email Anda → Hanya Anda yang tahu

**Contoh:**
```
Kode: 587234
Dibuat: 21:00
Kadaluarsa: 21:10 (10 menit kemudian)

Pukul 21:15 → Kode sudah tidak berlaku ❌
Harus minta kode baru
```

### 4. Token Login Aman

**Apa itu token?**
Token seperti **tiket masuk konser**:
- Beli tiket (login) → Dapat tiket (token)
- Masuk konser → Tunjukkan tiket (pakai token)
- Keluar konser (logout) → Tiket disobek (token dihapus)

**Keamanan token:**
- Token unik untuk setiap user
- Token ter-enkripsi
- Token bisa login di banyak device
- Logout → Token langsung invalid

### 5. Validasi Input Ketat

**Sistem selalu cek semua input Anda:**

| Input | Pengecekan |
|-------|------------|
| **Email** | Harus format email benar (@gmail.com) |
| **Email** | Tidak boleh sudah terdaftar |
| **Username** | Tidak boleh sudah dipakai |
| **Password** | Minimal 8 karakter |
| **Password** | Harus sama dengan konfirmasi |
| **No. Telepon** | Maksimal 20 karakter |
| **Role** | Hanya bisa "peserta" atau "superadmin" |

**Jika ada yang salah:**
```
❌ Pendaftaran Gagal!

Kesalahan:
- Email sudah terdaftar
- Password hanya 5 karakter (min. 8)
```

---

## 📊 Kode Status Response

### Apa itu kode status?

Seperti **lampu traffic light**:
- 🟢 Hijau (200) → Jalan, berhasil!
- 🟡 Kuning (400) → Hati-hati, ada masalah
- 🔴 Merah (500) → Stop, error server

### Daftar Kode Status

| Kode | Arti | Contoh Kasus |
|------|------|--------------|
| **200** | ✅ Berhasil | Login berhasil, data profil terkirim |
| **201** | ✅ Dibuat | Akun baru berhasil dibuat |
| **400** | ❌ Input Salah | Kode OTP salah/kadaluarsa |
| **401** | ❌ Tidak Berhak | Password salah, token invalid |
| **403** | ❌ Dilarang | Email belum diverifikasi |
| **404** | ❌ Tidak Ditemukan | Email tidak terdaftar |
| **422** | ❌ Validasi Gagal | Email sudah dipakai, password kurang panjang |
| **500** | ❌ Error Server | Gagal kirim email, database error |

### Format Response

**Jika Berhasil:**
```json
{
  "success": true,
  "message": "Login berhasil!",
  "data": {
    "nama": "Budi Santoso",
    "email": "budi@gmail.com"
  }
}
```

**Jika Gagal:**
```json
{
  "success": false,
  "message": "Login gagal",
  "errors": {
    "email": "Email atau password salah"
  }
}
```

---

## 🚀 Persiapan Deploy (Untuk Tim Teknis)

### Development (Lingkungan Testing)
- ✅ Setup database lokal
- ✅ Jalankan migrations
- ✅ Konfigurasi email (mode log)
- ✅ Test semua endpoint
- ✅ Buat dokumentasi API

### Production (Lingkungan Live)
- ⬜ Setup database production
- ⬜ Konfigurasi SMTP email real (Gmail/SendGrid)
- ⬜ Set mode production
- ⬜ Matikan debug mode
- ⬜ Setup HTTPS/SSL
- ⬜ Konfigurasi CORS
- ⬜ Setup backup otomatis
- ⬜ Optimasi performa (cache, queue)
- ⬜ Security audit

---

## 📞 Informasi Kontak

**Tim Pengembang:** Backend Team  
**Repository:** Event-Management-airnav/Backend-EM  
**Branch:** login-register-otp  

**Dokumentasi Terkait:**
- `/API_DOCUMENTATION.md` → Dokumentasi teknis API
- `/TESTING_GUIDE.md` → Panduan testing
- `/SETUP_AUTH_API.md` → Panduan setup

---

## 📝 Rangkuman Singkat

### Yang Sudah Dibuat:

1. ✅ **Sistem Pendaftaran**
   - Form pendaftaran lengkap
   - Validasi email & username unique
   - Enkripsi password otomatis

2. ✅ **Sistem Verifikasi Email**
   - Kirim kode OTP 6 digit
   - Berlaku 10 menit
   - Bisa kirim ulang

3. ✅ **Sistem Login & Logout**
   - Login dengan email & password
   - Dapat token untuk akses fitur
   - Logout hapus token

4. ✅ **Keamanan Tingkat Tinggi**
   - Password ter-enkripsi
   - Token ter-enkripsi
   - Validasi input ketat
   - Email verification wajib

5. ✅ **Database Terstruktur**
   - Tabel users, otps, tokens
   - Relasi antar tabel jelas
   - Data aman tersimpan

### Cara Kerja Singkat:

```
1. Daftar → Dapat OTP → Verifikasi → Akun Aktif
2. Login → Dapat Token → Bisa Akses Fitur
3. Logout → Token Dihapus → Harus Login Lagi
```

---

**Terakhir Update:** 28 Oktober 2025  
**Versi:** 1.0.0

---

## ❓ Pertanyaan Umum (FAQ)

**Q: Berapa lama kode OTP berlaku?**  
A: 10 menit saja. Setelah itu harus minta kode baru.

**Q: Apakah password saya aman?**  
A: Sangat aman! Password dienkripsi dan tidak ada yang bisa melihatnya.

**Q: Bisa login di banyak device?**  
A: Bisa! Setiap device punya token sendiri.

**Q: Lupa password gimana?**  
A: Fitur reset password akan dibuat nanti (coming soon).

**Q: Kode OTP tidak masuk ke email?**  
A: Cek folder spam/junk, atau klik "Kirim Ulang OTP".

**Q: Perbedaan peserta dan superadmin?**  
A: Peserta = pengguna biasa, Superadmin = pengelola sistem (akses lebih banyak).

---

## 🎯 Kesimpulan

Sistem backend ini dirancang dengan prinsip:
- 🔐 **Keamanan Tinggi** → Data Anda aman
- 🚀 **Cepat & Efisien** → Response cepat
- ✅ **User Friendly** → Mudah digunakan
- 📱 **Siap untuk Mobile/Web** → Bisa dipakai dimana saja

Semua proses otomatis dan transparan. Anda hanya perlu:
1. Daftar
2. Verifikasi email
3. Login
4. Nikmati fitur aplikasi!

---

## 🗺️ Roadmap Pengembangan

### ✅ Fase 1: Authentication & User Management (SELESAI)
**Status:** Completed v1.0.0

Fitur yang sudah dibuat:
- ✅ **Registrasi** - Register dengan validasi lengkap
- ✅ **Login** - Login dengan Laravel Sanctum
- ✅ **OTP Email Verification** - Verifikasi email dengan kode OTP
- ✅ Logout
- ✅ Get Current User
- ✅ Resend OTP
- ✅ Role Management (peserta/superadmin)

**API Endpoints:**
```
POST   /api/register            - Registrasi user baru
POST   /api/verify-otp          - Verifikasi OTP
POST   /api/login               - Login user
POST   /api/logout              - Logout user
GET    /api/me                  - Get user info
POST   /api/resend-otp          - Kirim ulang OTP
```

---

### 🚧 Fase 2: Presensi Management (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ Check-in Presensi (QR Code / Manual)
- ⬜ Check-out Presensi
- ⬜ Riwayat Presensi
- ⬜ Validasi Kehadiran
- ⬜ Export Data Presensi
- ⬜ Statistik Kehadiran

**API Endpoints (Rencana):**
```
POST   /api/attendance/checkin      - Check-in presensi
POST   /api/attendance/checkout     - Check-out presensi
GET    /api/attendance/history      - Riwayat presensi user
GET    /api/attendance/users        - List presensi semua user (admin)
GET    /api/attendance/export       - Export data presensi
GET    /api/attendance/stats        - Statistik kehadiran
```

**Penjelasan:**
Sistem presensi untuk mencatat kehadiran peserta di acara. User bisa check-in saat datang dan check-out saat pulang, dengan validasi waktu dan lokasi.

---

### 🚧 Fase 3: Resource Management (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ Upload File Resource (PDF, PPT, DOC, dll)
- ⬜ Download Resource
- ⬜ Kategori Resource
- ⬜ List Resource by Event
- ⬜ Resource Access Control (public/private)
- ⬜ Resource Version Control

**API Endpoints (Rencana):**
```
POST   /api/resources/upload        - Upload resource file
GET    /api/resources               - List semua resource
GET    /api/resources/{id}          - Detail resource
GET    /api/resources/{id}/download - Download file resource
DELETE /api/resources/{id}          - Hapus resource (admin)
GET    /api/resources/category/{cat} - Filter by kategori
```

**Penjelasan:**
Fitur untuk upload dan download materi acara seperti slide presentasi, modul, sertifikat, dan file lainnya. Peserta bisa download resource yang disediakan panitia.

---

### 🚧 Fase 4: Rundown Acara (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ CRUD Rundown (Create, Read, Update, Delete)
- ⬜ Jadwal Acara per Sesi
- ⬜ Timeline Kegiatan
- ⬜ Pembicara/Speaker Management
- ⬜ Lokasi/Ruangan per Sesi
- ⬜ Status Sesi (Upcoming, Ongoing, Completed)
- ⬜ Notifikasi Reminder Sesi

**API Endpoints (Rencana):**
```
POST   /api/rundown                 - Buat rundown baru (admin)
GET    /api/rundown                 - List semua rundown
GET    /api/rundown/{id}            - Detail rundown
PUT    /api/rundown/{id}            - Update rundown (admin)
DELETE /api/rundown/{id}            - Hapus rundown (admin)
GET    /api/rundown/today           - Rundown hari ini
GET    /api/rundown/current         - Sesi yang sedang berlangsung
```

**Penjelasan:**
Jadwal lengkap acara dari awal sampai akhir. Peserta bisa lihat jam berapa sesi dimulai, siapa pembicaranya, dan di ruangan mana. Membantu peserta mengatur waktu mereka.

---

### 🚧 Fase 5: Announcement Management (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ CRUD Announcement/Pengumuman
- ⬜ Broadcast Announcement ke Semua User
- ⬜ Announcement Priority (High, Medium, Low)
- ⬜ Scheduled Announcement
- ⬜ Announcement History
- ⬜ Mark as Read/Unread

**API Endpoints (Rencana):**
```
POST   /api/announcements           - Buat pengumuman (admin)
GET    /api/announcements           - List semua pengumuman
GET    /api/announcements/{id}      - Detail pengumuman
PUT    /api/announcements/{id}      - Update pengumuman (admin)
DELETE /api/announcements/{id}      - Hapus pengumuman (admin)
POST   /api/announcements/{id}/read - Mark pengumuman sudah dibaca
GET    /api/announcements/unread    - Pengumuman yang belum dibaca
```

**Penjelasan:**
Sistem pengumuman untuk informasi penting dari panitia ke peserta. Misalnya: perubahan jadwal, pembatalan sesi, info darurat, dll. Peserta akan dapat notifikasi real-time.

---

### 🚧 Fase 6: Notification System (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ Push Notification (Real-time)
- ⬜ Email Notification
- ⬜ In-App Notification
- ⬜ Notification History
- ⬜ Notification Settings (ON/OFF per kategori)
- ⬜ Mark Notification as Read
- ⬜ Auto Notification Triggers

**API Endpoints (Rencana):**
```
GET    /api/notifications           - List notifikasi user
GET    /api/notifications/unread    - Notifikasi belum dibaca
POST   /api/notifications/{id}/read - Mark sudah dibaca
DELETE /api/notifications/{id}      - Hapus notifikasi
PUT    /api/notifications/settings  - Update preferensi notifikasi
POST   /api/notifications/send      - Kirim notifikasi (admin)
```

**Penjelasan:**
Sistem notifikasi otomatis untuk berbagai event seperti: pengingat sesi akan dimulai, ada pengumuman baru, doorprize menang, dll. User bisa atur mau dapat notifikasi apa saja.

---

### 🚧 Fase 7: Doorprize System (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ Random Winner Generator
- ⬜ Counter/Timer Doorprize
- ⬜ Multiple Prize Management
- ⬜ Winner History
- ⬜ Doorprize Rules & Criteria
- ⬜ Exclude Previous Winners
- ⬜ Export Daftar Pemenang

**API Endpoints (Rencana):**
```
POST   /api/doorprize/draw          - Random pilih pemenang (admin)
GET    /api/doorprize/winners       - List semua pemenang
GET    /api/doorprize/prizes        - List hadiah doorprize
POST   /api/doorprize/prizes        - Tambah hadiah baru (admin)
GET    /api/doorprize/eligible      - List peserta yang eligible
GET    /api/doorprize/my-wins       - Hadiah yang saya menangkan
POST   /api/doorprize/claim/{id}    - Klaim hadiah
```

**Penjelasan:**
Sistem undian doorprize otomatis dengan random counter. Admin bisa set berapa hadiah, siapa saja yang eligible (misal harus sudah check-in), dan sistem akan pilih pemenang secara random dan fair.

---

### 🚧 Fase 8: Dashboard & Analytics (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ Dashboard Overview (Admin)
- ⬜ Dashboard Peserta
- ⬜ Statistik Real-time
- ⬜ Grafik Kehadiran
- ⬜ Grafik Registrasi
- ⬜ User Activity Logs
- ⬜ Export Reports (PDF/Excel)

**API Endpoints (Rencana):**
```
GET    /api/dashboard/admin         - Dashboard admin
GET    /api/dashboard/peserta       - Dashboard peserta
GET    /api/dashboard/stats         - Statistik keseluruhan
GET    /api/dashboard/attendance    - Grafik kehadiran
GET    /api/dashboard/registration  - Grafik registrasi
GET    /api/dashboard/export        - Export report
```

**Penjelasan:**
Dashboard untuk monitoring acara secara real-time. Admin bisa lihat berapa peserta yang sudah daftar, berapa yang hadir, sesi apa yang paling ramai, dll. Peserta bisa lihat aktivitas mereka sendiri.

---

### 🚧 Fase 9: Sertifikat Digital (COMING SOON)
**Status:** Planned

Fitur yang akan dibuat:
- ⬜ Generate Sertifikat Otomatis
- ⬜ Template Sertifikat Custom
- ⬜ Download Sertifikat (PDF)
- ⬜ Validasi Sertifikat (QR Code)
- ⬜ Kirim Sertifikat via Email
- ⬜ Sertifikat Archive
- ⬜ Kriteria Dapat Sertifikat (misal: minimal kehadiran 80%)

**API Endpoints (Rencana):**
```
POST   /api/certificates/generate   - Generate sertifikat (admin/auto)
GET    /api/certificates            - List sertifikat user
GET    /api/certificates/{id}       - Detail sertifikat
GET    /api/certificates/{id}/download - Download PDF sertifikat
GET    /api/certificates/verify/{code} - Validasi sertifikat
POST   /api/certificates/send-email    - Kirim via email
```

**Penjelasan:**
Sistem sertifikat digital untuk peserta yang memenuhi syarat (misal: kehadiran minimal 80%). Sertifikat auto-generate dengan nama peserta, ada QR code untuk validasi keaslian, dan bisa langsung download PDF.

---

### 📊 Progress Tracker

```
┌─────────────────────────────────────────┐
│ OVERALL PROGRESS                        │
├─────────────────────────────────────────┤
│ ███░░░░░░░░░░░░░░░░░░░░░░░░░░░ 11%     │
└─────────────────────────────────────────┘

Fase 1: Authentication       ████████████████████████████ 100% ✅
Fase 2: Presensi             ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 3: Resource Management  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 4: Rundown Acara        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 5: Announcement         ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 6: Notification         ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 7: Doorprize            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 8: Dashboard            ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
Fase 9: Sertifikat           ░░░░░░░░░░░░░░░░░░░░░░░░░░░░   0%
```

---

### 🎯 Target Timeline

| Fase | Fitur | Target | Status |
|------|-------|--------|--------|
| **Fase 1** | Authentication, Login, OTP | ✅ **Oktober 2025** | **SELESAI** |
| **Fase 2** | Presensi Management | 🎯 November 2025 | Planning |
| **Fase 3** | Resource Management | 🎯 November 2025 | Planning |
| **Fase 4** | Rundown Acara | 🎯 Desember 2025 | Planning |
| **Fase 5** | Announcement Management | 🎯 Desember 2025 | Planning |
| **Fase 6** | Notification System | 🎯 Januari 2026 | Planning |
| **Fase 7** | Doorprize System | 🎯 Januari 2026 | Planning |
| **Fase 8** | Dashboard & Analytics | 🎯 Februari 2026 | Planning |
| **Fase 9** | Sertifikat Digital | 🎯 Februari 2026 | Planning |

> **Catatan:** Timeline bisa berubah sesuai kebutuhan dan prioritas project.

---

## 📝 Changelog

### Version 1.0.0 (29 Oktober 2025) - CURRENT
**✅ Fitur yang Sudah Selesai:**
- ✅ **Registrasi User** - Daftar akun baru dengan validasi lengkap
- ✅ **Login User** - Login menggunakan Laravel Sanctum token
- ✅ **OTP Email Verification** - Verifikasi email dengan kode OTP 6 digit
- ✅ Logout dengan revoke token
- ✅ Get current user info
- ✅ Resend OTP jika kode expired
- ✅ Role Management (peserta/superadmin)

**📚 Dokumentasi:**
- ✅ API Documentation (Technical)
- ✅ Backend Flow Documentation (User-friendly)
- ✅ Setup & Installation Guide
- ✅ Testing Guide dengan Postman
- ✅ Postman Collection

**🔐 Security:**
- ✅ Password Encryption (Bcrypt)
- ✅ Token-based Authentication (Sanctum)
- ✅ Input Validation & Sanitization
- ✅ Email Verification Mandatory
- ✅ OTP Expiration (10 menit)

---

### Version 1.1.0 - NEXT RELEASE (Coming Soon)
**🚧 Fitur yang Akan Dibuat:**
- ⬜ Presensi Management (Check-in/Check-out)
- ⬜ Resource Management (Upload/Download)
- ⬜ Rundown Acara

**Target Release:** November 2025

---

### Version 1.2.0 - FUTURE RELEASE
**🚧 Fitur yang Akan Dibuat:**
- ⬜ Announcement Management
- ⬜ Notification System
- ⬜ Doorprize System
- ⬜ Dashboard & Analytics
- ⬜ Sertifikat Digital

**Target Release:** Q4 2025 - Q1 2026

---

## 🔄 Update & Maintenance

### Cara Update Dokumentasi

Dokumentasi ini akan terus diupdate seiring penambahan fitur baru:

1. **Setiap fitur baru** → Update dokumentasi
2. **Setiap perubahan API** → Update API docs
3. **Setiap bug fix** → Update changelog
4. **Setiap release** → Update version number

### Kontribusi

Jika menemukan:
- Bug atau error
- Typo dalam dokumentasi
- Saran improvement
- Request fitur baru

Silakan hubungi tim development atau buat issue di repository.

---

```
┌─────────┐
│ Client  │
└────┬────┘
     │
     │ POST /api/register
     │ {name, username, email, telp, password, role}
     │
┌────▼────────────────────────────────────┐
│  Validasi Request                       │
│  - Required fields check                │
│  - Email format validation              │
│  - Email & username unique check        │
│  - Password confirmation match          │
│  - Role validation (superadmin/peserta) │
└────┬────────────────────────────────────┘
     │
     │ ✅ Valid
     │
┌────▼────────────────────────────────────┐
│  Create User                            │
│  - Hash password dengan bcrypt          │
│  - Save to database                     │
│  - email_verified_at = NULL             │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Generate OTP                           │
│  - Random 6 digit number                │
│  - Save to otps table                   │
│  - Set expires_at = now + 10 minutes    │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Send Email                             │
│  - Use OtpMail class                    │
│  - Template: emails/otp.blade.php       │
│  - Include OTP code & user name         │
└────┬────────────────────────────────────┘
     │
     │ Response 201 Created
     │ {success, message, user data}
     │
┌────▼────┐
│ Client  │
└─────────┘
```

### 2. Email Verification Flow

```
┌─────────┐
│ Client  │
└────┬────┘
     │
     │ User receives OTP via email
     │
     │ POST /api/verify-otp
     │ {email, otp}
     │
┌────▼────────────────────────────────────┐
│  Validasi Request                       │
│  - Email format check                   │
│  - OTP length = 6 digits                │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Find User by Email                     │
└────┬────────────────────────────────────┘
     │
     │ ❌ Not Found → 404 Error
     │
     │ ✅ Found
     │
┌────▼────────────────────────────────────┐
│  Find OTP Record                        │
│  - Match user_id & code                 │
│  - verified_at IS NULL                  │
└────┬────────────────────────────────────┘
     │
     │ ❌ Not Found → 400 "Invalid OTP"
     │
     │ ✅ Found
     │
┌────▼────────────────────────────────────┐
│  Check OTP Expiration                   │
│  - Compare expires_at with now()        │
└────┬────────────────────────────────────┘
     │
     │ ❌ Expired → 400 "OTP expired"
     │
     │ ✅ Valid
     │
┌────▼────────────────────────────────────┐
│  Update Records                         │
│  - Set otp.verified_at = now()          │
│  - Set user.email_verified_at = now()   │
└────┬────────────────────────────────────┘
     │
     │ Response 200 OK
     │ {success, message}
     │
┌────▼────┐
│ Client  │
└─────────┘
```

### 3. Login Flow

```
┌─────────┐
│ Client  │
└────┬────┘
     │
     │ POST /api/login
     │ {email, password}
     │
┌────▼────────────────────────────────────┐
│  Validasi Request                       │
│  - Email & password required            │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Find User by Email                     │
└────┬────────────────────────────────────┘
     │
     │ ❌ Not Found → 401 "Invalid credentials"
     │
     │ ✅ Found
     │
┌────▼────────────────────────────────────┐
│  Verify Password                        │
│  - Hash::check(password, user.password) │
└────┬────────────────────────────────────┘
     │
     │ ❌ Wrong → 401 "Invalid credentials"
     │
     │ ✅ Match
     │
┌────▼────────────────────────────────────┐
│  Check Email Verification               │
│  - email_verified_at IS NOT NULL        │
└────┬────────────────────────────────────┘
     │
     │ ❌ NULL → 403 "Please verify email first"
     │
     │ ✅ Verified
     │
┌────▼────────────────────────────────────┐
│  Generate Access Token                  │
│  - Laravel Sanctum                      │
│  - createToken('auth_token')            │
│  - Save to personal_access_tokens table │
└────┬────────────────────────────────────┘
     │
     │ Response 200 OK
     │ {success, user data, access_token, token_type}
     │
┌────▼────┐
│ Client  │
│ Store   │
│ Token   │
└─────────┘
```

### 4. Protected Endpoint Flow

```
┌─────────┐
│ Client  │
└────┬────┘
     │
     │ GET/POST /api/protected-endpoint
     │ Header: Authorization: Bearer {token}
     │
┌────▼────────────────────────────────────┐
│  Middleware: auth:sanctum               │
│  - Extract token from header            │
│  - Find token in personal_access_tokens │
└────┬────────────────────────────────────┘
     │
     │ ❌ Invalid/Missing → 401 "Unauthenticated"
     │
     │ ✅ Valid Token
     │
┌────▼────────────────────────────────────┐
│  Load Authenticated User                │
│  - Get user from token relationship     │
│  - Inject to Request                    │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Execute Controller Method              │
│  - Access via $request->user()          │
│  - Process business logic               │
└────┬────────────────────────────────────┘
     │
     │ Response with data
     │
┌────▼────┐
│ Client  │
└─────────┘
```

### 5. Logout Flow

```
┌─────────┐
│ Client  │
└────┬────┘
     │
     │ POST /api/logout
     │ Header: Authorization: Bearer {token}
     │
┌────▼────────────────────────────────────┐
│  Middleware: auth:sanctum               │
│  - Validate token                       │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Delete Current Token                   │
│  - $request->user()                     │
│  -   ->currentAccessToken()             │
│  -   ->delete()                         │
└────┬────────────────────────────────────┘
     │
     │ Response 200 OK
     │ {success, message}
     │
┌────▼────┐
│ Client  │
│ Clear   │
│ Token   │
└─────────┘
```

### 6. Resend OTP Flow

```
┌─────────┐
│ Client  │
└────┬────┘
     │
     │ POST /api/resend-otp
     │ {email}
     │
┌────▼────────────────────────────────────┐
│  Find User by Email                     │
└────┬────────────────────────────────────┘
     │
     │ ❌ Not Found → 404 "User not found"
     │
     │ ✅ Found
     │
┌────▼────────────────────────────────────┐
│  Check Email Verification Status        │
│  - email_verified_at IS NULL            │
└────┬────────────────────────────────────┘
     │
     │ ❌ Already Verified → 400 "Email already verified"
     │
     │ ✅ Not Verified
     │
┌────▼────────────────────────────────────┐
│  Generate New OTP                       │
│  - Random 6 digit number                │
│  - Save to otps table                   │
│  - Set expires_at = now + 10 minutes    │
└────┬────────────────────────────────────┘
     │
┌────▼────────────────────────────────────┐
│  Send Email                             │
│  - New OTP code                         │
└────┬────────────────────────────────────┘
     │
     │ Response 200 OK
     │ {success, message}
     │
┌────▼────┐
│ Client  │
└─────────┘
```

---

## 🗄️ Database Schema

### Entity Relationship Diagram

```
┌─────────────────────────┐
│        users            │
├─────────────────────────┤
│ id (PK)                 │
│ name                    │
│ username (unique)       │
│ email (unique)          │
│ telp                    │
│ role (enum)             │
│ password (hashed)       │
│ email_verified_at       │
│ created_at              │
│ updated_at              │
└───────┬─────────────────┘
        │
        │ 1:N
        │
┌───────▼─────────────────┐
│        otps             │
├─────────────────────────┤
│ id (PK)                 │
│ user_id (FK)            │
│ code (6 digits)         │
│ expires_at              │
│ verified_at (nullable)  │
│ created_at              │
│ updated_at              │
└─────────────────────────┘

┌─────────────────────────┐
│        users            │
└───────┬─────────────────┘
        │
        │ 1:1
        │
┌───────▼─────────────────┐
│   detail_peserta        │
├─────────────────────────┤
│ id (PK)                 │
│ user_id (FK)            │
│ ... (peserta details)   │
└─────────────────────────┘

┌─────────────────────────┐
│        users            │
└───────┬─────────────────┘
        │
        │ 1:1
        │
┌───────▼─────────────────┐
│   detail_admin          │
├─────────────────────────┤
│ id (PK)                 │
│ user_id (FK)            │
│ divisi_id (FK)          │
│ ... (admin details)     │
└─────────────────────────┘

┌─────────────────────────┐
│        users            │
└───────┬─────────────────┘
        │
        │ 1:N
        │
┌───────▼─────────────────────────┐
│ personal_access_tokens          │
├─────────────────────────────────┤
│ id (PK)                         │
│ tokenable_id (user_id)          │
│ tokenable_type                  │
│ name                            │
│ token (hashed)                  │
│ abilities                       │
│ last_used_at                    │
│ expires_at                      │
│ created_at                      │
│ updated_at                      │
└─────────────────────────────────┘
```

---

## 🔌 API Endpoints

### Public Endpoints (No Authentication Required)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/register` | Registrasi user baru |
| POST | `/api/verify-otp` | Verifikasi OTP email |
| POST | `/api/resend-otp` | Kirim ulang OTP |
| POST | `/api/login` | Login dan dapat token |

### Protected Endpoints (Require Authentication)

| Method | Endpoint | Description | Middleware |
|--------|----------|-------------|------------|
| POST | `/api/logout` | Logout dan hapus token | auth:sanctum |
| GET | `/api/me` | Get current user info | auth:sanctum |
| GET | `/api/user` | Get current user (alias) | auth:sanctum |

---

## 🛡️ Security & Authorization

### Security Measures

1. **Password Hashing**
   - Menggunakan bcrypt (Laravel default)
   - Password tidak pernah disimpan plain text
   - Minimum 8 karakter

2. **Email Verification**
   - Mandatory sebelum bisa login
   - OTP 6 digit random
   - Expired setelah 10 menit
   - OTP hanya bisa digunakan 1 kali

3. **Token-Based Authentication**
   - Laravel Sanctum
   - Token disimpan hashed di database
   - Token per-session (bisa multiple devices)
   - Token tidak expired (sampai logout)

4. **Input Validation**
   - Semua input divalidasi
   - Email & username unique constraint
   - Role validation (enum)
   - Request validation di controller

5. **CORS Protection**
   - Configured di config/cors.php
   - Restrict access dari domain tertentu

### Validation Rules

```php
Registration:
├── name: required, string, max:255
├── username: required, string, max:255, unique
├── email: required, email, max:255, unique
├── telp: required, string, max:20
├── password: required, string, min:8, confirmed
└── role: required, in:superadmin,peserta

Login:
├── email: required, email
└── password: required, string

Verify OTP:
├── email: required, email
└── otp: required, string, size:6

Resend OTP:
└── email: required, email
```

### Future Authorization (Role-Based)

```
Planned Implementation:
├── Middleware CheckRole
├── Middleware CheckAdmin
├── Middleware CheckPeserta
└── Policy-based authorization
```

---

## 📊 Success Metrics

### API Response Standards

**Success Response (2xx):**
```json
{
    "success": true,
    "message": "Operation successful",
    "data": { ... }
}
```

**Error Response (4xx/5xx):**
```json
{
    "success": false,
    "message": "Error description",
    "errors": { ... } // optional, untuk validation errors
}
```

### HTTP Status Codes

| Code | Meaning | Usage |
|------|---------|-------|
| 200 | OK | Successful request |
| 201 | Created | Resource created (register) |
| 400 | Bad Request | Invalid OTP, expired, etc |
| 401 | Unauthorized | Invalid credentials, no token |
| 403 | Forbidden | Email not verified |
| 404 | Not Found | User not found |
| 422 | Validation Error | Input validation failed |
| 500 | Server Error | Email send failed, etc |

---

## 🚀 Deployment Checklist

### Development
- ✅ Setup local database
- ✅ Run migrations
- ✅ Configure mail driver (log)
- ✅ Test all endpoints
- ✅ Generate API documentation

### Staging/Production
- ⬜ Setup production database
- ⬜ Configure SMTP email (Gmail/SendGrid)
- ⬜ Set APP_ENV=production
- ⬜ Set APP_DEBUG=false
- ⬜ Configure CORS allowed origins
- ⬜ Setup HTTPS/SSL
- ⬜ Configure proper error logging
- ⬜ Setup backup strategy
- ⬜ Performance optimization (caching, queue)
- ⬜ Security audit

---

## 📞 Contact & Support

**Developer:** Backend Team  
**Repository:** Event-Management-airnav/Backend-EM  
**Branch:** login-register-otp  
**Documentation:** `/API_DOCUMENTATION.md`  
**Testing Guide:** `/TESTING_GUIDE.md`  
**Setup Guide:** `/SETUP_AUTH_API.md`

---

**Last Updated:** October 28, 2025  
**Version:** 1.0.0
