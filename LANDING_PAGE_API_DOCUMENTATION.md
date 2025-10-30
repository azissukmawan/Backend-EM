# 📱 Landing Page API Documentation

**AirNav Event Management - Public Event Endpoints**

Version: 1.0.0  
Last Updated: 30 Oktober 2025

---

## 📋 Daftar Isi

- [Overview](#overview)
- [Base URL](#base-url)
- [Endpoints](#endpoints)
  - [1. Get Active Events](#1-get-active-events)
  - [2. Get All Events](#2-get-all-events)
  - [3. Get Upcoming Events](#3-get-upcoming-events)
  - [4. Get Past Events](#4-get-past-events)
  - [5. Get Event Detail](#5-get-event-detail)
- [Response Structure](#response-structure)
- [Error Handling](#error-handling)
- [Filter Summary](#filter-summary)

---

## Overview

API ini menyediakan endpoint public untuk menampilkan daftar event di landing page. Semua endpoint **tidak memerlukan authentication** (public access).

### Fitur Utama:
- ✅ List event yang sedang aktif
- ✅ List semua event (aktif, upcoming, past)
- ✅ List event yang akan datang
- ✅ List event yang sudah selesai
- ✅ Detail event lengkap
- ✅ Filter otomatis berdasarkan status dan tanggal
- ✅ Support akses by ID atau slug

---

## Base URL

```
Development: http://localhost:8000/api
Production: https://your-domain.com/api
```

---

## Endpoints

### 1. Get Active Events

**Menampilkan event yang sedang berlangsung saat ini**

```http
GET /api/events
```

#### Filter Kondisi:
- `is_public = true` - Event yang dipublikasikan
- `mdl_status = 'active'` - Status event aktif
- `mdl_acara_mulai <= NOW()` - Acara sudah dimulai
- `mdl_acara_selesai >= NOW() OR mdl_acara_selesai IS NULL` - Acara belum selesai

#### Perbedaan dengan `/api/events/all`:
- `/api/events` = Event yang **lagi berlangsung SEKARANG** (sudah mulai & belum selesai)
- `/api/events/all` = **SEMUA** event public (upcoming, ongoing, past, semua status)

#### Response Success (200):

```json
{
  "success": true,
  "message": "Active events retrieved successfully",
  "data": {
    "events": [
      {
        "id": 1,
        "slug": "rapat-koordinator-bersama-jajaran-direktur",
        "nama": "Rapat Koordinator Bersama Jajaran Direktur",
        "tipe": "Offline",
        "lokasi": "Gedung AirNav Indonesia, Jakarta",
        "tanggal_mulai": "28 Oct 2025, 09:00",
        "tanggal_selesai": "30 Oct 2025, 17:00",
        "status_acara": "Sedang Berlangsung",
        "banner": "http://localhost:8000/storage/banners/event1.jpg",
        "deskripsi_singkat": "Rapat koordinasi untuk membahas strategi perusahaan tahun depan bersama seluruh jajaran direktur dan koordinator wilayah..."
      }
    ],
    "total": 3,
    "description": "Event yang sedang aktif/berlangsung saat ini"
  }
}
```

#### Use Case:
- Tampil di homepage sebagai "Event Sedang Berlangsung"
- Real-time event yang happening now

---

### 2. Get All Events

**Menampilkan SEMUA event public (tanpa filter status dan tanggal)**

```http
GET /api/events/all
```

#### Filter Kondisi:
- `is_public = true` - Event yang dipublikasikan
- **Tidak ada filter `mdl_status`** - Tampil semua status (draft, active, closed, archived)
- **Tidak ada filter tanggal** - Tampil semua event (past, ongoing, upcoming)

#### Perbedaan dengan endpoint lain:
- `/api/events` = Event **sedang berlangsung** (active + tanggal ongoing)
- `/api/events/upcoming` = Event **akan datang** (active + tanggal future)
- `/api/events/past` = Event **sudah selesai** (tanggal past)
- `/api/events/all` = **SEMUA** event public (semua status + semua tanggal)

#### Response Success (200):

```json
{
  "success": true,
  "message": "All events retrieved successfully",
  "data": {
    "events": [
      {
        "id": 1,
        "slug": "rapat-koordinator-2025",
        "nama": "Rapat Koordinator Bersama Jajaran Direktur",
        "tipe": "Offline",
        "lokasi": "Gedung AirNav Indonesia, Jakarta",
        "tanggal_mulai": "28 Oct 2025, 09:00",
        "tanggal_mulai_raw": "2025-10-28 09:00:00",
        "status_acara": "Sedang Berlangsung",
        "status_event": "active",
        "banner": "http://localhost:8000/storage/banners/event1.jpg",
        "deskripsi_singkat": "Rapat koordinasi untuk membahas..."
      },
      {
        "id": 2,
        "slug": "workshop-teknologi-navigasi-udara",
        "nama": "Workshop Teknologi Navigasi Udara 2025",
        "tipe": "Hybrid",
        "lokasi": "Jakarta Convention Center",
        "tanggal_mulai": "15 Nov 2025, 08:00",
        "tanggal_mulai_raw": "2025-11-15 08:00:00",
        "status_acara": "Akan Datang",
        "status_event": "draft",
        "banner": "http://localhost:8000/storage/banners/event2.jpg",
        "deskripsi_singkat": "Workshop tentang teknologi terkini..."
      },
      {
        "id": 3,
        "slug": "seminar-keselamatan-penerbangan",
        "nama": "Seminar Keselamatan Penerbangan",
        "tipe": "Online",
        "lokasi": "Zoom Meeting",
        "tanggal_mulai": "15 Oct 2025, 10:00",
        "tanggal_mulai_raw": "2025-10-15 10:00:00",
        "status_acara": "Selesai",
        "status_event": "archived",
        "banner": "http://localhost:8000/storage/banners/event3.jpg",
        "deskripsi_singkat": "Seminar tentang keselamatan..."
      }
    ],
    "total": 11,
    "description": "Semua event public (tanpa filter status)"
  }
}
```

#### Additional Fields:
- `status_acara`: Status berdasarkan tanggal (`"Sedang Berlangsung"`, `"Akan Datang"`, `"Selesai"`)
- `status_event`: Status dari database (`"draft"`, `"active"`, `"closed"`, `"archived"`)

#### Status Event (`status_event`):
- `draft` - Event masih draft, belum dipublikasikan
- `active` - Event aktif dan bisa dilihat/didaftar
- `closed` - Event sudah ditutup (tidak bisa daftar)
- `archived` - Event diarsipkan

#### Use Case:
- **Archive page** - Tampil semua event dari awal sampai akhir
- **Search/Filter page** - User bisa cari event apapun
- **Event gallery lengkap** - Lihat semua event yang pernah ada
- **Admin overview** - Monitoring semua event
- **Event history** - Lihat event tahun lalu, bulan lalu, dll

---

### 3. Get Upcoming Events

**Menampilkan event yang akan datang (belum dimulai)**

```http
GET /api/events/upcoming
```

#### Filter Kondisi:
- `is_public = true` - Event yang dipublikasikan
- `mdl_status = 'active'` - Status event aktif
- `acara_mulai > NOW()` - Event yang **belum dimulai**

#### Response Success (200):

```json
{
  "success": true,
  "message": "Upcoming events retrieved successfully",
  "data": {
    "events": [
      {
        "id": 2,
        "slug": "workshop-teknologi-navigasi-udara",
        "nama": "Workshop Teknologi Navigasi Udara 2025",
        "tipe": "Hybrid",
        "lokasi": "Jakarta Convention Center",
        "tanggal_mulai": "15 Nov 2025, 08:00",
        "tanggal_mulai_raw": "2025-11-15 08:00:00",
        "status_acara": "Akan Datang",
        "status_event": "active",
        "banner": "http://localhost:8000/storage/banners/event2.jpg",
        "deskripsi_singkat": "Workshop tentang teknologi terkini..."
      },
      {
        "id": 4,
        "slug": "pelatihan-ahli-k3",
        "nama": "Pelatihan Ahli K3 Penerbangan",
        "tipe": "Offline",
        "lokasi": "Training Center AirNav, Tangerang",
        "tanggal_mulai": "1 Dec 2025, 09:00",
        "tanggal_mulai_raw": "2025-12-01 09:00:00",
        "status_acara": "Akan Datang",
        "status_event": "active",
        "banner": "http://localhost:8000/storage/banners/event4.jpg",
        "deskripsi_singkat": "Pelatihan untuk ahli K3..."
      }
    ],
    "total": 5,
    "description": "Event yang akan datang"
  }
}
```

#### Status Event:
- Semua event di endpoint ini memiliki `status_event: "active"` (karena difilter)
- Semua event memiliki `status_acara: "Akan Datang"` (karena belum dimulai)

#### Use Case:
- Landing page section "Upcoming Events"
- Event calendar - upcoming only
- Registration reminder system
- "Save the date" feature

---

### 4. Get Past Events

**Menampilkan event yang sudah selesai**

```http
GET /api/events/past
```

#### Filter Kondisi:
- `is_public = true` - Event yang dipublikasikan
- **Tidak ada filter `mdl_status`** - Tampil semua status
- Event dengan kondisi salah satu:
  - `acara_selesai < NOW()` - Sudah melewati tanggal selesai, ATAU
  - `acara_selesai IS NULL` AND `acara_mulai < NOW() - 1 hari` - Event tanpa tanggal selesai yang sudah 1 hari lewat

#### Response Success (200):

```json
{
  "success": true,
  "message": "Past events retrieved successfully",
  "data": {
    "events": [
      {
        "id": 5,
        "slug": "seminar-keselamatan-penerbangan-2025",
        "nama": "Seminar Keselamatan Penerbangan 2025",
        "tipe": "Online",
        "lokasi": "Zoom Meeting",
        "tanggal_mulai": "15 Oct 2025, 10:00",
        "tanggal_selesai": "15 Oct 2025, 16:00",
        "hari_lalu": "15 hari yang lalu",
        "status_acara": "Selesai",
        "status_event": "archived",
        "banner": "http://localhost:8000/storage/banners/event5.jpg"
      },
      {
        "id": 8,
        "slug": "pelatihan-internal-staff",
        "nama": "Pelatihan Internal Staff AirNav",
        "tipe": "Offline",
        "lokasi": "Head Office Jakarta",
        "tanggal_mulai": "5 Oct 2025, 08:00",
        "tanggal_selesai": "5 Oct 2025, 17:00",
        "hari_lalu": "25 hari yang lalu",
        "status_acara": "Selesai",
        "status_event": "closed",
        "banner": "http://localhost:8000/storage/banners/event8.jpg"
      }
    ],
    "total": 8,
    "description": "Event yang sudah selesai"
  }
}
```

#### Additional Field:
- `hari_lalu`: String berapa hari yang lalu event selesai
- `status_event`: Status dari database (archived, closed, active, draft)

#### Status Event di Past Events:
- Bisa `"active"` - Event selesai tapi status masih aktif (untuk review/feedback)
- Bisa `"closed"` - Event selesai dan pendaftaran ditutup
- Bisa `"archived"` - Event diarsipkan
- Bisa `"draft"` - Event lama yang di-draft ulang

#### Use Case:
- Event history / archive page
- Past event gallery / documentation
- Recap section untuk review event
- Event portfolio

---

### 5. Get Event Detail

**Menampilkan detail lengkap event**

```http
GET /api/events/{identifier}
```

#### Path Parameters:
| Parameter | Type | Description |
|-----------|------|-------------|
| `identifier` | string/integer | Event ID atau Slug |

#### Examples:
- `GET /api/events/1` - Akses by ID
- `GET /api/events/rapat-koordinator-2025` - Akses by slug

#### Filter Kondisi:
- `id = {identifier}` **OR** `mdl_slug = {identifier}`
- `is_public = true` - Event yang dipublikasikan
- **Tidak ada filter `mdl_status`** - Bisa akses event dengan status apapun (draft, active, closed, archived)

#### Response Success (200):

```json
{
  "success": true,
  "message": "Event detail retrieved successfully",
  "data": {
    "event": {
      "id": 1,
      "kode": "EVT-2025-001",
      "slug": "rapat-koordinator-bersama-jajaran-direktur",
      "nama": "Rapat Koordinator Bersama Jajaran Direktur",
      "deskripsi": "Rapat koordinasi tahunan untuk membahas strategi perusahaan, evaluasi kinerja, dan rencana pengembangan infrastruktur navigasi udara Indonesia untuk tahun mendatang.",
      "tipe": "Offline",
      "status_acara": "Sedang Berlangsung",
      "status_event": "active",
      "lokasi": "Gedung AirNav Indonesia, Jakarta",
      "latitude": -6.2088,
      "longitude": 106.8456,
      "radius": 100,
      "pendaftaran": {
        "mulai": "01 Oct 2025, 08:00",
        "selesai": "27 Oct 2025, 23:59",
        "mulai_raw": "2025-10-01 08:00:00",
        "selesai_raw": "2025-10-27 23:59:59",
        "is_open": false
      },
      "acara": {
        "mulai": "28 Oct 2025, 09:00",
        "selesai": "30 Oct 2025, 17:00",
        "mulai_raw": "2025-10-28 09:00:00",
        "selesai_raw": "2025-10-30 17:00:00"
      },
      "kapasitas": {
        "offline": 200,
        "online": null
      },
      "sertifikat_aktif": true,
      "doorprize_aktif": true,
      "banner": "http://localhost:8000/storage/banners/event1.jpg",
      "catatan": "Peserta wajib membawa ID card dan datang tepat waktu. Dress code: Formal.",
      "created_at": "15 Sep 2025, 14:30"
    }
  }
}
```

#### Field Explanations:
- `status_acara`: Status berdasarkan tanggal (`"Sedang Berlangsung"`, `"Akan Datang"`, `"Selesai"`)
- `status_event`: Status dari database (`"draft"`, `"active"`, `"closed"`, `"archived"`)
- `pendaftaran.is_open`: Boolean apakah pendaftaran masih buka (berdasarkan tanggal)

#### Response Not Found (404):

```json
{
  "success": false,
  "message": "Event not found"
}
```

#### Use Case:
- Halaman detail event lengkap
- Event registration page (cek `pendaftaran.is_open`)
- Event information modal / popup
- Share event link via slug
- QR code scanner result page

---

## Response Structure

### Success Response Format:

```json
{
  "success": true,
  "message": "Success message here",
  "data": {
    // Data payload here
  }
}
```

### Error Response Format:

```json
{
  "success": false,
  "message": "Error message here",
  "error": "Detailed error message (only in development)"
}
```

---

## Error Handling

### Common HTTP Status Codes:

| Status Code | Description |
|-------------|-------------|
| 200 | Success |
| 404 | Event not found |
| 500 | Internal server error |

### Error Examples:

#### 404 - Event Not Found:
```json
{
  "success": false,
  "message": "Event not found"
}
```

#### 500 - Server Error:
```json
{
  "success": false,
  "message": "Failed to retrieve events",
  "error": "Database connection failed"
}
```

---

## Filter Summary

### Tabel Ringkasan Filter per Endpoint:

| Endpoint | is_public | mdl_status | Tanggal Filter | Deskripsi |
|----------|-----------|------------|----------------|-----------|
| `/api/events` | ✅ true | ✅ active | `mulai <= NOW <= selesai` | Event **sedang berlangsung** |
| `/api/events/all` | ✅ true | ❌ any | ❌ semua | **Semua** event public |
| `/api/events/upcoming` | ✅ true | ✅ active | `mulai > NOW` | Event **belum mulai** |
| `/api/events/past` | ✅ true | ❌ any | `selesai < NOW` | Event **sudah selesai** |
| `/api/events/{id}` | ✅ true | ❌ any | ❌ any | 1 event spesifik |

**Catatan Penting:**
- ✅ = Filter diterapkan
- ❌ = Filter TIDAK diterapkan (tampil semua)
- `/api/events` = Hanya event **active** yang **ongoing** (happening NOW)
- `/api/events/all` = **SEMUA** event public (draft, active, closed, archived) tanpa filter tanggal
- `/api/events/upcoming` = Hanya event **active** yang belum dimulai (future)
- `/api/events/past` = Event yang **sudah selesai**, apapun statusnya (active, closed, archived)

---

## Data Field Definitions

### Event List Fields:

| Field | Type | Description |
|-------|------|-------------|
| `id` | integer | ID unik event |
| `slug` | string | URL-friendly identifier |
| `nama` | string | Nama event |
| `tipe` | string | Tipe event: `Online`, `Offline`, `Hybrid` |
| `lokasi` | string | Lokasi event |
| `tanggal_mulai` | string | Tanggal mulai (formatted) |
| `tanggal_mulai_raw` | datetime | Tanggal mulai (raw) |
| `tanggal_selesai` | string/null | Tanggal selesai (formatted) |
| `status_acara` | string | Status berdasarkan tanggal: `Sedang Berlangsung`, `Akan Datang`, `Selesai` |
| `status_event` | string | Status dari database: `draft`, `active`, `closed`, `archived` |
| `banner` | string/null | URL banner image |
| `deskripsi_singkat` | string | Deskripsi max 150 karakter |
| `hari_lagi` | string | Countdown (upcoming only) |
| `hari_lalu` | string | Days ago (past only) |

**Perbedaan `status_acara` vs `status_event`:**
- `status_acara` = Dihitung dari tanggal (Akan Datang / Sedang Berlangsung / Selesai)
- `status_event` = Status dari database (`mdl_status` column: draft, active, closed, archived)

### Event Detail Additional Fields:

| Field | Type | Description |
|-------|------|-------------|
| `kode` | string | Kode event internal |
| `deskripsi` | string | Deskripsi lengkap |
| `latitude` | decimal | Koordinat latitude |
| `longitude` | decimal | Koordinat longitude |
| `radius` | integer | Radius absensi (meter) |
| `pendaftaran.mulai` | string | Tanggal buka pendaftaran |
| `pendaftaran.selesai` | string | Tanggal tutup pendaftaran |
| `pendaftaran.is_open` | boolean | Apakah pendaftaran masih buka |
| `acara.mulai` | string | Tanggal mulai acara |
| `acara.selesai` | string/null | Tanggal selesai acara |
| `kapasitas.offline` | integer/null | Kapasitas peserta offline |
| `kapasitas.online` | integer/null | Kapasitas peserta online |
| `sertifikat_aktif` | boolean | Apakah ada sertifikat |
| `doorprize_aktif` | boolean | Apakah ada doorprize |
| `catatan` | string/null | Catatan untuk peserta |

---

## Testing Examples

### Using cURL:

#### Get Active Events:
```bash
curl -X GET http://localhost:8000/api/events \
  -H "Accept: application/json"
```

#### Get Event Detail by ID:
```bash
curl -X GET http://localhost:8000/api/events/1 \
  -H "Accept: application/json"
```

#### Get Event Detail by Slug:
```bash
curl -X GET http://localhost:8000/api/events/rapat-koordinator-2025 \
  -H "Accept: application/json"
```

### Using Postman:

1. **Method:** `GET`
2. **URL:** `http://localhost:8000/api/events`
3. **Headers:**
   - `Accept: application/json`
4. **Click:** Send

---

## Notes

### Visibility Rules:
- Hanya event dengan `is_public = true` yang tampil di public API
- Event dengan `is_public = false` hanya bisa diakses via admin API

### Status Event:
- `draft` - Event belum dipublikasikan
- `active` - Event aktif dan bisa dilihat publik
- `closed` - Event ditutup (tidak bisa daftar)
- `archived` - Event diarsipkan

### Tipe Event:
- `online` - Event virtual/online
- `offline` - Event tatap muka
- `hybrid` - Kombinasi online dan offline

---

## Support

Untuk pertanyaan atau issue terkait API, silakan hubungi:
- **GitHub:** https://github.com/Event-Management-airnav/Backend-EM

---

**© 2025 AirNav Indonesia. All rights reserved.**
