<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ModulAcara;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use App\Helpers\StorageHelper;

class ModulAcaraController extends Controller
{
    public function index(Request $request)
    {
        $query = ModulAcara::query();

        // Filter pencarian berdasarkan nama acara
        if ($request->filled('search')) {
            $query->where('mdl_nama', 'like', '%' . $request->search . '%');
        }

        // Filter status acara
        if ($request->filled('status')) {
            $query->where('mdl_status', $request->status);
        }

        // Filter berdasarkan tanggal pendaftaran mulai
        if ($request->filled('tanggal_mulai')) {
            $query->whereDate('mdl_pendaftaran_mulai', '>=', $request->tanggal_mulai);
        }

        $events = $query->latest()->get();

        // Generate public URLs for uploaded files in each event
        foreach ($events as $event) {
            $event->mdl_file_acara_url = StorageHelper::getStorageUrl($event->mdl_file_acara);
            $event->mdl_file_rundown_url = StorageHelper::getStorageUrl($event->mdl_file_rundown);
            $event->mdl_template_sertifikat_url = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);
            $event->mdl_banner_acara_url = StorageHelper::getStorageUrl($event->mdl_banner_acara);

            // Hide internal path fields from response
            $event->makeHidden(['mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat', 'mdl_banner_acara']);
        }

        return response()->json([
            'status' => true,
            'message' => 'Daftar acara berhasil diambil',
            'data' => $events
        ]);
    }

    public function show($id)
    {
        $event = ModulAcara::find($id);

        if (!$event) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }

        // Generate public URLs for uploaded files
        $event->mdl_file_acara_url = StorageHelper::getStorageUrl($event->mdl_file_acara);
        $event->mdl_file_rundown_url = StorageHelper::getStorageUrl($event->mdl_file_rundown);
        $event->mdl_template_sertifikat_url = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);
        $event->mdl_banner_acara_url = StorageHelper::getStorageUrl($event->mdl_banner_acara);

        // Hide internal path fields from response
        $event->makeHidden(['mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat', 'mdl_banner_acara']);

        return response()->json([
            'status' => true,
            'message' => 'Detail acara berhasil diambil',
            'data' => $event
        ]);
    }

    /**
     * Ambil informasi QR untuk event tertentu (khusus admin/superadmin)
     * Response: mdl_kode_qr, mdl_presensi_aktif, id
     */
    public function qr($id, Request $request)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $event = ModulAcara::find($id);
        if (!$event) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }
        return response()->json([
            'status' => true,
            'message' => 'QR acara berhasil diambil',
            'data' => [
                'id' => $event->id,
                'mdl_kode_qr' => $event->mdl_kode_qr,
                'mdl_presensi_aktif' => (bool) $event->mdl_presensi_aktif,
            ]
        ]);
    }

    /**
     * Set status presensi aktif/nonaktif untuk event (toggle via payload)
     * Body: { "aktif": true|false }
     */
    public function setPresensiAktif($id, Request $request)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $validated = $request->validate([
            'aktif' => 'required|boolean',
        ]);
        $event = ModulAcara::find($id);
        if (!$event) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }
        $event->mdl_presensi_aktif = $validated['aktif'];
        $event->updated_by = $request->user()->id;
        $event->save();
        return response()->json([
            'status' => true,
            'message' => 'Status presensi berhasil diperbarui',
            'data' => [
                'id' => $event->id,
                'mdl_presensi_aktif' => (bool) $event->mdl_presensi_aktif,
            ]
        ]);
    }

    // Fungsi CREATE acara
    public function store(Request $request)
    {
        // Proteksi di level controller (cek role superadmin)
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $validated = $request->validate([
            'mdl_nama' => 'required|string|max:150',
            'mdl_kode' => 'required|string|max:30|unique:modul_acara,mdl_kode',
            'mdl_slug' => 'required|string|max:180|unique:modul_acara,mdl_slug',
            'mdl_deskripsi' => 'required|string',
            'mdl_tipe' => 'required|in:online,offline,hybrid',
            'mdl_kategori' => 'required|in:public,private,invite-only',
            'mdl_lokasi' => 'nullable|string|max:255',
            'mdl_latitude' => 'nullable|numeric',
            'mdl_longitude' => 'nullable|numeric',
            'mdl_radius' => 'nullable|integer',
            'mdl_pendaftaran_mulai' => 'required|date',
            'mdl_pendaftaran_selesai' => 'required|date|after_or_equal:mdl_pendaftaran_mulai',
            'mdl_maks_peserta_eksternal' => 'nullable|integer',
            'mdl_acara_mulai' => 'required|date',
            'mdl_acara_selesai' => 'nullable|date|after_or_equal:mdl_acara_mulai',
            'mdl_status' => 'nullable|in:draft,active,closed,archived',
            // File uploads
            'mdl_file_acara' => 'nullable|file|mimes:pdf,ppt,pptx,doc,docx|max:10240',
            'mdl_file_rundown' => 'nullable|file|mimes:pdf,xlsx,xls,doc,docx|max:10240',
            'mdl_template_sertifikat' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
            'mdl_banner_acara' => 'nullable|file|mimes:jpg,jpeg,png|max:5120',
            // Text field
            'mdl_catatan' => 'nullable|string',
            // Admin tidak boleh mengirim/menentukan QR secara manual
            'mdl_kode_qr' => 'prohibited',
            'mdl_link_wa' => 'nullable|string|max:255',
            'mdl_doorprize_aktif' => 'nullable|boolean',
        ]);

        // Handle file uploads
        if ($request->hasFile('mdl_file_acara')) {
            $validated['mdl_file_acara'] = $request->file('mdl_file_acara')->store('modul-acara/files', 's3');
        }

        if ($request->hasFile('mdl_file_rundown')) {
            $validated['mdl_file_rundown'] = $request->file('mdl_file_rundown')->store('modul-acara/rundown', 's3');
        }

        if ($request->hasFile('mdl_template_sertifikat')) {
            $validated['mdl_template_sertifikat'] = $this->handleTemplateSertifikat($request->file('mdl_template_sertifikat'));
        }

        if ($request->hasFile('mdl_banner_acara')) {
            $validated['mdl_banner_acara'] = $request->file('mdl_banner_acara')->store('modul-acara/banner', 's3');
        }

        $validated['user_id'] = $request->user()->id;
        $validated['created_by'] = $request->user()->id;
        $acara = ModulAcara::create($validated);

        // Generate QR unik dan simpan ke database
        $qrCode = $this->generateUniqueQrCode();
        $acara->mdl_kode_qr = $qrCode;
        $acara->save();

        // Generate public URLs for uploaded files
        $acara->mdl_file_acara_url = StorageHelper::getStorageUrl($acara->mdl_file_acara);
        $acara->mdl_file_rundown_url = StorageHelper::getStorageUrl($acara->mdl_file_rundown);
        $acara->mdl_template_sertifikat_url = StorageHelper::getStorageUrl($acara->mdl_template_sertifikat);
        $acara->mdl_banner_acara_url = StorageHelper::getStorageUrl($acara->mdl_banner_acara);

        // Hide internal path fields from response
        $acara->makeHidden(['mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat', 'mdl_banner_acara']);

        return response()->json([
            'status' => true,
            'message' => 'Acara berhasil dibuat',
            'data' => $acara
        ], 201);
    }

    //Fungsi UPDATE acara
    public function update(Request $request, $id)
    {
        // --- Cek hak akses ---
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        // --- Ambil data acara ---
        $acara = ModulAcara::find($id);
        if (!$acara) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }

        // --- Validasi input ---
        $validated = $request->validate([
            'mdl_nama' => 'sometimes|string|max:150',
            'mdl_kode' => 'sometimes|string|max:30|unique:modul_acara,mdl_kode,' . $id,
            'mdl_slug' => 'sometimes|string|max:180|unique:modul_acara,mdl_slug,' . $id,
            'mdl_deskripsi' => 'sometimes|string',
            'mdl_tipe' => 'sometimes|in:online,offline,hybrid',
            'mdl_kategori' => 'sometimes|in:public,private,invite-only',
            'mdl_lokasi' => 'nullable|string|max:255',
            'mdl_latitude' => 'nullable|numeric',
            'mdl_longitude' => 'nullable|numeric',
            'mdl_radius' => 'nullable|integer',
            'mdl_pendaftaran_mulai' => 'sometimes|date',
            'mdl_pendaftaran_selesai' => 'sometimes|date|after_or_equal:mdl_pendaftaran_mulai',
            'mdl_maks_peserta_eksternal' => 'nullable|integer',
            'mdl_acara_mulai' => 'sometimes|date',
            'mdl_acara_selesai' => 'nullable|date|after_or_equal:mdl_acara_mulai',
            'mdl_status' => 'nullable|in:draft,active,closed,archived',

            // File uploads
            'mdl_file_acara' => 'nullable|file|mimes:pdf,ppt,pptx,doc,docx|max:10240',
            'mdl_file_rundown' => 'nullable|file|mimes:pdf,xlsx,xls,doc,docx|max:10240',
            'mdl_template_sertifikat' => 'nullable|file|mimes:jpg,jpeg,png|max:2048',
            'mdl_banner_acara' => 'nullable|file|mimes:jpg,jpeg,png|max:5120',

            // Text fields
            'mdl_catatan' => 'nullable|string',
            'mdl_link_wa' => 'nullable|string',

            // QR tidak boleh diubah
            'mdl_kode_qr' => 'prohibited',
            'mdl_doorprize_aktif' => 'nullable|boolean',
        ]);

        // --- Upload file baru dan hapus file lama ---
        $fileMap = [
            'mdl_file_acara' => 'modul-acara/files',
            'mdl_file_rundown' => 'modul-acara/rundown',
            'mdl_template_sertifikat' => 'modul-acara/sertifikat',
            'mdl_banner_acara' => 'modul-acara/banner',
        ];

        foreach ($fileMap as $field => $folder) {
            if ($request->hasFile($field)) {
                // Hapus file lama di S3 kalau ada
                if (!empty($acara->$field)) {
                    Storage::disk('s3')->delete($acara->$field);
                }

                // Upload file baru dengan special handling untuk template sertifikat
                if ($field === 'mdl_template_sertifikat') {
                    $path = $this->handleTemplateSertifikat($request->file($field));
                } else {
                    $path = $request->file($field)->store($folder, 's3');
                }
                $validated[$field] = $path;
            }
        }

        // Tambahkan info siapa yang update
        $validated['updated_by'] = $request->user()->id;

        // --- Update database ---
        $acara->update($validated);

        // --- Generate URL publik dari S3 (gunakan helper bawaan kamu) ---
        $acara->mdl_file_acara_url = $acara->mdl_file_acara ? StorageHelper::getStorageUrl($acara->mdl_file_acara) : null;
        $acara->mdl_file_rundown_url = $acara->mdl_file_rundown ? StorageHelper::getStorageUrl($acara->mdl_file_rundown) : null;
        $acara->mdl_template_sertifikat_url = $acara->mdl_template_sertifikat ? StorageHelper::getStorageUrl($acara->mdl_template_sertifikat) : null;
        $acara->mdl_banner_acara_url = $acara->mdl_banner_acara ? StorageHelper::getStorageUrl($acara->mdl_banner_acara) : null;

        // --- Sembunyikan path internal sebelum kirim response ---
        $acara->makeHidden(['mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat', 'mdl_banner_acara']);

        return response()->json([
            'status' => true,
            'message' => 'Acara berhasil diupdate',
            'data' => $acara
        ]);
    }


    // Fungsi DELETE acara
    public function destroy(Request $request, $id)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $acara = ModulAcara::find($id);
        if (!$acara) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }

        // Hapus semua file dari S3 sebelum menghapus record
        if ($acara->mdl_file_acara) {
            Storage::disk('s3')->delete($acara->mdl_file_acara);
        }
        if ($acara->mdl_file_rundown) {
            Storage::disk('s3')->delete($acara->mdl_file_rundown);
        }
        if ($acara->mdl_template_sertifikat) {
            Storage::disk('s3')->delete($acara->mdl_template_sertifikat);
        }
        if ($acara->mdl_banner_acara) {
            Storage::disk('s3')->delete($acara->mdl_banner_acara);
        }

        $acara->forceDelete();
        return response()->json([
            'status' => true,
            'message' => 'Acara berhasil dihapus permanen'
        ]);
    }

    // public function index()
    // {
    //     $events = ModulAcara::latest()->paginate(10);
    //     return response()->json([
    //         'status' => true,
    //         'message' => 'Daftar acara berhasil diambil',
    //         'data' => $events
    //     ]);
    // }

    // public function show($id)
    // {
    //     $event = ModulAcara::find($id);

    //     if (!$event) {
    //         return response()->json([
    //             'status' => false,
    //             'message' => 'Acara tidak ditemukan'
    //         ], 404);
    //     }

    //     return response()->json([
    //         'status' => true,
    //         'message' => 'Detail acara berhasil diambil',
    //         'data' => $event
    //     ]);
    // }

    // Generate QR unik (string) yang belum dipakai event lain
    protected function generateUniqueQrCode(): string
    {
        do {
            $candidate = 'EVTQR-' . Str::upper(Str::random(8)) . '-' . time();
        } while (ModulAcara::where('mdl_kode_qr', $candidate)->exists());
        return $candidate;
    }

    /**
     * Handle upload template sertifikat
     * Hanya menerima JPG/PNG, reject PDF
     *
     * @param \Illuminate\Http\UploadedFile $file
     * @return string Path file di S3
     * @throws \Exception
     */
    protected function handleTemplateSertifikat($file): string
    {
        // Validasi: Hanya terima JPG/PNG
        $allowedMimes = ['image/jpeg', 'image/jpg', 'image/png'];
        $fileMime = $file->getMimeType();

        if (!in_array($fileMime, $allowedMimes)) {
            throw new \Exception('Template sertifikat harus berformat JPG atau PNG. Format PDF tidak didukung. Silakan convert PDF Anda ke JPG/PNG terlebih dahulu.');
        }

        // Validasi ukuran file (max 5MB)
        if ($file->getSize() > 2 * 1024 * 1024) {
            throw new \Exception('Ukuran file template sertifikat maksimal 2 MB.');
        }

        // Upload langsung ke S3
        return $file->store('modul-acara/sertifikat', 's3');
    }
}
