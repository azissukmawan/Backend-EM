# Dashboard Profile API Documentation

## Overview
API endpoints untuk Dashboard Profile yang menampilkan list event kegiatan dan detail event untuk user yang sudah login. Semua endpoint di bawah prefix `/profile` dan memerlukan autentikasi menggunakan Sanctum token.

---

## Endpoints

### 1. Get Dashboard Event List (with Pagination)

Menampilkan daftar event dengan pagination, 6 event per halaman.

**Endpoint:** `GET /api/profile/dashboard`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**Query Parameters:**
| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| page | integer | No | 1 | Nomor halaman |
| per_page | integer | No | 6 | Jumlah item per halaman |
| status | string | No | - | Filter status: draft, active, closed, archived |
| tipe | string | No | - | Filter tipe: online, offline, hybrid |
| kategori | string | No | - | Filter kategori: public, private, invite-only |
| search | string | No | - | Cari berdasarkan nama event |
| sort_by | string | No | mdl_acara_mulai | Kolom sorting: mdl_acara_mulai, mdl_pendaftaran_mulai, created_at, mdl_nama |
| sort_order | string | No | desc | Urutan: asc, desc |

**Success Response (200 OK):**
```json
{
    "success": true,
    "message": "Dashboard events retrieved successfully",
    "data": {
        "events": [
            {
                "id": 1,
                "kode": "EVT-001",
                "slug": "rapat-koordinator-bersama-jajaran-direktur",
                "nama": "Rapat Koordinator Bersama Jajaran Direktur",
                "deskripsi": "AirNav Event Management is a smart and integrated system designed to ensure scheduling efficiency...",
                "tipe": "offline",
                "status": "active",
                "kategori": "public",
                "lokasi": "Airnav, Tangerang",
                "tanggal_mulai": "11 Oktober 2026 - 20 Oktober 2026",
                "tanggal_selesai": "20 Oktober 2026, 12:00 WIB",
                "pendaftaran_selesai": "25 November 2025, 09:00 WIB",
                "banner": "http://localhost:8000/storage/banners/event1.jpg",
                "event_time_status": "upcoming",
                "registration_status": "open"
            },
            {
                "id": 2,
                "kode": "EVT-002",
                "slug": "smart-precision-event-management",
                "nama": "Smart & Precision Event Management System",
                "deskripsi": "Smart system untuk manajemen event yang terintegrasi...",
                "tipe": "hybrid",
                "status": "active",
                "kategori": "public",
                "lokasi": "Airnav, Tangerang",
                "tanggal_mulai": "25 Oktober 2026, 09:00 WIB",
                "tanggal_selesai": "25 Oktober 2026, 12:00 WIB",
                "pendaftaran_selesai": "20 Oktober 2025, 17:00 WIB",
                "banner": "http://localhost:8000/storage/banners/event2.jpg",
                "event_time_status": "upcoming",
                "registration_status": "closed"
            }
        ],
        "pagination": {
            "total": 15,
            "per_page": 6,
            "current_page": 1,
            "last_page": 3,
            "from": 1,
            "to": 6
        }
    }
}
```

**Event Time Status:**
- `upcoming`: Event belum dimulai
- `ongoing`: Event sedang berlangsung
- `completed`: Event sudah selesai

**Registration Status:**
- `upcoming`: Pendaftaran belum dibuka
- `open`: Pendaftaran sedang dibuka
- `closed`: Pendaftaran sudah ditutup

**Error Responses:**

*Unauthorized (401):*
```json
{
    "message": "Unauthenticated."
}
```

*Server Error (500):*
```json
{
    "success": false,
    "message": "Failed to retrieve dashboard events",
    "error": "Error message here"
}
```

---

### 2. Get Event Detail

Menampilkan detail lengkap dari sebuah event.

**Endpoint:** `GET /api/profile/dashboard/events/{identifier}`

**Headers:**
```
Authorization: Bearer {token}
Accept: application/json
```

**URL Parameters:**
| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| identifier | string/integer | Yes | ID atau slug event |

**Success Response (200 OK):**
```json
{
    "success": true,
    "message": "Event detail retrieved successfully",
    "data": {
        "id": 1,
        "kode": "EVT-001",
        "slug": "smart-precision-event-management",
        "nama": "Smart & Precision Event Management System",
        "deskripsi": "AirNav Event Management is a smart and integrated system designed to ensure scheduling efficiency, participant management, and professionalism in every event. With advanced technology and an intuitive interface, it simplifies scheduling, participant management, and progress monitoring.",
        "tipe": "offline",
        "status": "active",
        "kategori": "public",
        "lokasi": {
            "alamat": "Airnav, Tangerang",
            "latitude": -6.175110,
            "longitude": 106.865036,
            "radius": 100
        },
        "pendaftaran": {
            "mulai": "11 Oktober 2026, 08:00 WIB",
            "selesai": "20 Oktober 2026, 23:59 WIB",
            "maks_peserta_eksternal": 100,
            "status": "open"
        },
        "acara": {
            "tanggal_mulai": "25 Oktober 2026",
            "tanggal_selesai": "25 Oktober 2026",
            "jam_mulai": "09:00",
            "jam_selesai": "12:00",
            "durasi": "180 menit"
        },
        "fitur": {
            "sertifikat_aktif": true,
            "doorprize_aktif": false
        },
        "media": {
            "banner": "http://localhost:8000/storage/banners/event1.jpg",
            "file_acara": "http://localhost:8000/storage/files/materi.pdf",
            "file_rundown": "http://localhost:8000/storage/files/rundown.pdf",
            "template_sertifikat": "http://localhost:8000/storage/templates/certificate.pdf"
        },
        "catatan": "Dress Code: Baju warna putih, Celana/Rok berwarna Hitam",
        "event_time_status": "upcoming",
        "organizer": {
            "id": 1,
            "name": "Admin AirNav",
            "email": "admin@airnav.com"
        },
        "created_at": "20 Oktober 2025, 10:30 WIB",
        "updated_at": "20 Oktober 2025, 15:45 WIB"
    }
}
```

**Error Responses:**

*Not Found (404):*
```json
{
    "success": false,
    "message": "Event not found"
}
```

*Forbidden (403) - Jika peserta mencoba akses event yang tidak active:*
```json
{
    "success": false,
    "message": "Event is not available"
}
```

*Unauthorized (401):*
```json
{
    "message": "Unauthenticated."
}
```

*Server Error (500):*
```json
{
    "success": false,
    "message": "Failed to retrieve event detail",
    "error": "Error message here"
}
```

---

## Example Usage

### 1. Get Dashboard with Default Pagination

**Request:**
```bash
curl -X GET "http://localhost:8000/api/profile/dashboard" \
  -H "Authorization: Bearer {your-token}" \
  -H "Accept: application/json"
```

### 2. Get Dashboard Page 2

**Request:**
```bash
curl -X GET "http://localhost:8000/api/profile/dashboard?page=2" \
  -H "Authorization: Bearer {your-token}" \
  -H "Accept: application/json"
```

### 3. Get Dashboard with Filters

**Request:**
```bash
curl -X GET "http://localhost:8000/api/profile/dashboard?status=active&tipe=offline&search=koordinator" \
  -H "Authorization: Bearer {your-token}" \
  -H "Accept: application/json"
```

### 4. Get Event Detail by ID

**Request:**
```bash
curl -X GET "http://localhost:8000/api/profile/dashboard/events/1" \
  -H "Authorization: Bearer {your-token}" \
  -H "Accept: application/json"
```

### 5. Get Event Detail by Slug

**Request:**
```bash
curl -X GET "http://localhost:8000/api/profile/dashboard/events/smart-precision-event-management" \
  -H "Authorization: Bearer {your-token}" \
  -H "Accept: application/json"
```

---

## Notes

1. **Authentication Required**: Semua endpoint memerlukan token autentikasi Sanctum
2. **Pagination**: Default 6 item per halaman sesuai dengan UI requirement
3. **Role Based Access**:
   - **Peserta**: Hanya bisa melihat event dengan status `active`
   - **Admin**: Bisa melihat semua event dengan status apapun
4. **Identifier Flexibility**: Event detail bisa diakses menggunakan ID (integer) atau slug (string)
5. **Date Format**: Semua tanggal ditampilkan dalam format Indonesia dengan timezone WIB
6. **Media URLs**: Semua file/media dikembalikan sebagai full URL menggunakan `asset()` helper
7. **Dynamic Status**: Status event (upcoming/ongoing/completed) dan status pendaftaran dihitung secara real-time berdasarkan waktu server

---

## Filter Options

### Status Filter
- `draft`: Event masih draft
- `active`: Event aktif dan bisa dilihat peserta
- `closed`: Event ditutup
- `archived`: Event diarsipkan

### Tipe Filter
- `online`: Event dilaksanakan secara online
- `offline`: Event dilaksanakan secara offline/tatap muka
- `hybrid`: Event kombinasi online dan offline

### Kategori Filter
- `public`: Event terbuka untuk umum
- `private`: Event private
- `invite-only`: Event khusus undangan

---

## UI Mapping

Berdasarkan gambar UI yang diberikan:

### Dashboard List View
- Menampilkan cards dengan:
  - Banner event (`mdl_banner_acara`)
  - Nama event (`mdl_nama`)
  - Status badge (Offline/Online/Hybrid dari `mdl_tipe`)
  - Tanggal event (`mdl_acara_mulai`)
  - Lokasi (`mdl_lokasi`)
  - Button "Detail Acara"

### Detail Event View
- Header dengan banner dan informasi utama
- Section "Tentang" dengan deskripsi event
- Section "Informasi Acara" dengan:
  - Alamat lokasi
  - Tanggal pendaftaran
  - Jam acara
  - Tanggal acara
- Section "Informasi Tambahan" dengan:
  - Dress code atau catatan khusus
- Button "Daftar Sekarang" (untuk fitur registrasi di masa depan)

---

## Testing

Untuk testing endpoint ini, pastikan:
1. Anda sudah login dan memiliki token Sanctum
2. Database sudah di-seed dengan data event
3. Storage link sudah dibuat: `php artisan storage:link`
4. File banner dan dokumen event sudah ada di storage

---
