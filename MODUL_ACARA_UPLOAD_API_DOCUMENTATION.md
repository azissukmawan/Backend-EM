# API Documentation - Modul Acara (File Upload)

## Enhancement untuk Upload File pada Modul Acara

### Deskripsi
Enhancement ini menambahkan fitur upload file untuk endpoint create dan update modul acara. File akan disimpan di object storage (AWS S3) sesuai konfigurasi environment.

---

## Endpoints

### 1. Create Modul Acara (dengan Upload File)

**Endpoint:** `POST /api/modul-acara`

**Authentication:** Required (Sanctum Bearer Token)

**Authorization:** Superadmin only

**Content-Type:** `multipart/form-data`

#### Request Body (Form Data)

**Field yang Wajib:**
- `mdl_nama` (string, max: 150) - Nama acara
- `mdl_kode` (string, max: 30, unique) - Kode acara
- `mdl_slug` (string, max: 180, unique) - Slug acara
- `mdl_deskripsi` (text) - Deskripsi acara
- `mdl_tipe` (enum: online, offline, hybrid) - Tipe acara
- `mdl_kategori` (enum: public, private, invite-only) - Kategori acara
- `mdl_pendaftaran_mulai` (date) - Tanggal mulai pendaftaran
- `mdl_pendaftaran_selesai` (date) - Tanggal selesai pendaftaran
- `mdl_acara_mulai` (date) - Tanggal mulai acara

**Field yang Opsional:**
- `mdl_lokasi` (string, max: 255) - Lokasi acara
- `mdl_latitude` (numeric) - Latitude lokasi
- `mdl_longitude` (numeric) - Longitude lokasi
- `mdl_radius` (integer) - Radius geofencing (dalam meter)
- `mdl_maks_peserta_eksternal` (integer) - Maksimal peserta eksternal
- `mdl_acara_selesai` (date) - Tanggal selesai acara
- `mdl_status` (enum: draft, active, closed, archived) - Status acara

**Field File Upload (Opsional):**
- `mdl_file_acara` (file)
  - Format: PDF, PPT, PPTX, DOC, DOCX
  - Max size: 10MB (10240 KB)
  - Disimpan di: `modul-acara/files/`

- `mdl_file_rundown` (file)
  - Format: PDF, XLSX, XLS, DOC, DOCX
  - Max size: 10MB (10240 KB)
  - Disimpan di: `modul-acara/rundown/`

- `mdl_template_sertifikat` (file)
  - Format: JPG, JPEG, PNG
  - Max size: 5MB (5120 KB)
  - Disimpan di: `modul-acara/sertifikat/`

- `mdl_banner_acara` (file)
  - Format: JPG, JPEG, PNG
  - Max size: 5MB (5120 KB)
  - Rekomendasi dimensi: 1091 x 791 pixel (sesuai gambar)
  - Disimpan di: `modul-acara/banner/`

**Field Text (Opsional):**
- `mdl_catatan` (text) - Catatan atau informasi tambahan untuk acara

#### Response Success (201 Created)

```json
{
    "status": true,
    "message": "Acara berhasil dibuat",
    "data": {
        "id": 1,
        "user_id": 1,
        "mdl_kode": "EVT001",
        "mdl_slug": "workshop-2025",
        "mdl_nama": "Workshop Laravel 2025",
        "mdl_deskripsi": "Workshop tentang Laravel terbaru",
        "mdl_tipe": "hybrid",
        "mdl_kategori": "public",
        "mdl_lokasi": "Jakarta",
        "mdl_catatan": "Harap membawa laptop",
        "mdl_file_acara_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/files/xyz123.pdf",
        "mdl_file_rundown_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/rundown/abc456.xlsx",
        "mdl_template_sertifikat_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/sertifikat/def789.jpg",
        "mdl_banner_acara_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/banner/ghi012.png",
        "created_at": "2025-10-31T10:00:00.000000Z",
        "updated_at": "2025-10-31T10:00:00.000000Z"
    }
}
```

**Note:** Field internal path (`mdl_file_acara`, `mdl_file_rundown`, `mdl_template_sertifikat`, `mdl_banner_acara`) tidak ditampilkan di response untuk menghindari duplikasi. Gunakan field URL (`*_url`) untuk akses file.

#### Response Error (403 Forbidden)

```json
{
    "message": "Forbidden"
}
```

#### Response Error (422 Unprocessable Entity)

```json
{
    "message": "The given data was invalid.",
    "errors": {
        "mdl_file_acara": [
            "The mdl file acara must be a file of type: pdf, ppt, pptx, doc, docx."
        ],
        "mdl_banner_acara": [
            "The mdl banner acara must not be greater than 5120 kilobytes."
        ]
    }
}
```

---

### 2. Update Modul Acara (dengan Upload File)

**Endpoint:** `PUT/PATCH /api/modul-acara/{id}`

**Authentication:** Required (Sanctum Bearer Token)

**Authorization:** Superadmin only

**Content-Type:** `multipart/form-data`

**Note:** Untuk HTTP method PUT/PATCH dengan form-data, gunakan `_method=PUT` atau `_method=PATCH` di form data.

#### Request Body (Form Data)

Semua field bersifat opsional (`sometimes` validation), tetapi minimal harus ada 1 field yang diubah.

**Field yang dapat diupdate:**
- Sama seperti endpoint create, tetapi semua field bersifat opsional
- Field yang tidak disertakan tidak akan diubah

**File Upload Behavior:**
- Jika file baru diupload, file lama akan **otomatis dihapus** dari S3
- Jika tidak ada file baru, file lama tetap tersimpan
- Path file akan diupdate di database

#### Response Success (200 OK)

```json
{
    "status": true,
    "message": "Acara berhasil diupdate",
    "data": {
        "id": 1,
        "user_id": 1,
        "mdl_kode": "EVT001",
        "mdl_slug": "workshop-2025",
        "mdl_nama": "Workshop Laravel 2025 - Updated",
        "mdl_catatan": "Harap membawa laptop dan charger",
        "mdl_file_acara_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/files/xyz123.pdf",
        "mdl_file_rundown_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/rundown/abc456.xlsx",
        "mdl_template_sertifikat_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/sertifikat/def789.jpg",
        "mdl_banner_acara_url": "https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/banner/new-banner-xyz.png",
        "updated_at": "2025-10-31T11:00:00.000000Z"
    }
}
```

**Note:** Field internal path tidak ditampilkan di response. Hanya URL public yang ditampilkan.

#### Response Error (404 Not Found)

```json
{
    "status": false,
    "message": "Acara tidak ditemukan"
}
```

---

### 3. Delete Modul Acara (Enhancement)

**Endpoint:** `DELETE /api/modul-acara/{id}`

**Authentication:** Required (Sanctum Bearer Token)

**Authorization:** Superadmin only

**Enhancement:** Saat menghapus acara, semua file terkait akan **otomatis dihapus** dari S3.

#### Response Success (200 OK)

```json
{
    "status": true,
    "message": "Acara berhasil dihapus permanen"
}
```

---

## Contoh Penggunaan dengan cURL

### Create dengan File Upload

```bash
curl -X POST http://localhost:8000/api/modul-acara \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "mdl_nama=Workshop Laravel 2025" \
  -F "mdl_kode=EVT001" \
  -F "mdl_slug=workshop-2025" \
  -F "mdl_deskripsi=Workshop tentang Laravel terbaru" \
  -F "mdl_tipe=hybrid" \
  -F "mdl_kategori=public" \
  -F "mdl_pendaftaran_mulai=2025-11-01" \
  -F "mdl_pendaftaran_selesai=2025-11-15" \
  -F "mdl_acara_mulai=2025-12-01" \
  -F "mdl_file_acara=@/path/to/modul.pdf" \
  -F "mdl_file_rundown=@/path/to/rundown.xlsx" \
  -F "mdl_template_sertifikat=@/path/to/template.jpg" \
  -F "mdl_banner_acara=@/path/to/banner.png" \
  -F "mdl_catatan=Harap membawa laptop"
```

### Update dengan File Upload

```bash
curl -X POST http://localhost:8000/api/modul-acara/1 \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "_method=PUT" \
  -F "mdl_nama=Workshop Laravel 2025 - Updated" \
  -F "mdl_banner_acara=@/path/to/new-banner.png" \
  -F "mdl_catatan=Harap membawa laptop dan charger"
```

---

## Contoh Penggunaan dengan Postman

### Setup Request

1. **Method:** POST (untuk create) atau POST dengan `_method=PUT` (untuk update)
2. **URL:** `http://localhost:8000/api/modul-acara` atau `http://localhost:8000/api/modul-acara/{id}`
3. **Headers:**
   - `Authorization: Bearer YOUR_TOKEN_HERE`
   - `Accept: application/json`
4. **Body:** Form-data
   - Tambahkan field text sesuai kebutuhan
   - Untuk file, pilih tipe "File" dan upload file

---

## Konfigurasi Environment

Pastikan variabel environment berikut sudah dikonfigurasi di file `.env`:

```env
FILESYSTEM_DISK=s3

AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_DEFAULT_REGION=your_region
AWS_BUCKET=your_bucket_name
AWS_URL=https://your-bucket.s3.amazonaws.com
AWS_ENDPOINT=https://s3.amazonaws.com
AWS_USE_PATH_STYLE_ENDPOINT=false
```

---

## Struktur Penyimpanan di S3

```
your-bucket/
├── modul-acara/
│   ├── files/           # Modul Acara (PDF/PPT/DOC)
│   ├── rundown/         # Susunan Acara (PDF/Excel/DOC)
│   ├── sertifikat/      # Template Sertifikat (JPG/PNG)
│   └── banner/          # Banner Acara (JPG/PNG)
```

---

## Validasi File

### Modul Acara (mdl_file_acara)
- ✅ Format: PDF, PPT, PPTX, DOC, DOCX
- ✅ Ukuran maksimal: 10MB

### Susunan Acara (mdl_file_rundown)
- ✅ Format: PDF, XLSX, XLS, DOC, DOCX
- ✅ Ukuran maksimal: 10MB

### Template Sertifikat (mdl_template_sertifikat)
- ✅ Format: JPG, JPEG, PNG
- ✅ Ukuran maksimal: 5MB

### Banner Acara (mdl_banner_acara)
- ✅ Format: JPG, JPEG, PNG
- ✅ Ukuran maksimal: 5MB
- 💡 Rekomendasi dimensi: 1091 x 791 pixel

---

## Public URL untuk File

Setiap response API akan menyertakan URL public untuk file yang diupload dengan format:

```
{field_name}_url = AWS_URL + '/' + AWS_BUCKET + '/' + {field_value}
```

**Contoh:**
- Path di database: `modul-acara/files/xyz123.pdf`
- Public URL: `https://your-bucket.s3.amazonaws.com/your-bucket/modul-acara/files/xyz123.pdf`

**Field URL yang ditambahkan:**
- `mdl_file_acara_url` - URL untuk download modul acara
- `mdl_file_rundown_url` - URL untuk download rundown acara
- `mdl_template_sertifikat_url` - URL untuk preview/download template sertifikat
- `mdl_banner_acara_url` - URL untuk display banner acara

URL ini dapat langsung digunakan di frontend untuk:
- Display image (`<img>` tag)
- Download link (`<a>` tag dengan download attribute)
- Preview file (open in new tab)

**Notes:**
- Jika file tidak ada, value URL akan `null`
- URL dibuat secara dinamis berdasarkan konfigurasi environment
- Pastikan S3 bucket sudah dikonfigurasi dengan public access untuk file yang perlu diakses public
- **Field internal path disembunyikan dari response** untuk menghindari duplikasi dan kebingungan
- Gunakan field `*_url` untuk akses file, bukan field path internal

---

## Notes

1. **Keamanan:** Hanya superadmin yang dapat mengakses endpoint ini
2. **Storage:** File disimpan di object storage (AWS S3/compatible)
3. **Auto Delete:** File lama otomatis dihapus saat:
   - Upload file baru pada update
   - Hapus record acara
4. **Validation:** Semua file upload divalidasi tipe MIME dan ukuran
5. **Optional:** Semua field file bersifat opsional, acara dapat dibuat tanpa file
6. **Form Data:** Gunakan `multipart/form-data` untuk upload file
7. **Public URLs:** Response menyertakan URL lengkap untuk akses langsung ke file
8. **Dynamic URLs:** URL dibuat berdasarkan `AWS_URL` dan `AWS_BUCKET` di environment

---

## Kolom Database

Field baru yang ditambahkan di tabel `modul_acara`:

```sql
mdl_file_acara VARCHAR(255) NULL
mdl_file_rundown VARCHAR(255) NULL
mdl_template_sertifikat VARCHAR(255) NULL
mdl_banner_acara VARCHAR(255) NULL
mdl_catatan TEXT NULL
```

Semua field sudah tersedia di migration dan model `ModulAcara`.
