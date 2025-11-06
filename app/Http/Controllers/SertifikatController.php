<?php

namespace App\Http\Controllers;

use App\Models\Sertifikat;
use App\Models\PresensiAcara;
use App\Models\ModulAcara;
use Illuminate\Http\Request;
use App\Helpers\StorageHelper;
use Illuminate\Support\Facades\Storage;

class SertifikatController extends Controller
{
    /**
     * Generate/regenerate sertifikat untuk user
     * Endpoint ini untuk generate ulang jika ada kebutuhan
     */
    public function generate(Request $request)
    {
        $request->validate([
            'id_acara' => 'required|exists:modul_acara,id',
        ]);

        $user = $request->user();

        $presensi = PresensiAcara::with(['event', 'pendaftaranAcara'])
            ->where('modul_acara_id', $request->id_acara)
            ->where('user_id', $user->id)
            ->where('status', 'Hadir')
            ->first();

        if (!$presensi) {
            return response()->json([
                'status' => false,
                'message' => 'Peserta belum dinyatakan hadir dalam acara ini.'
            ], 403);
        }

        $event = $presensi->event;
        $pendaftaran = $presensi->pendaftaranAcara;
        $kodeSertif = $pendaftaran?->no_sertifikat;

        // Cek apakah sudah ada sertifikat
        $sertifikat = Sertifikat::where('user_id', $user->id)
            ->where('modul_acara_id', $request->id_acara)
            ->first();

        $fileUrl = null;
        if ($sertifikat && $sertifikat->file_sertifikat) {
            $fileUrl = StorageHelper::getStorageUrl($sertifikat->file_sertifikat);
        }

        $templateSertifikat = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);

        return response()->json([
            'status' => true,
            'message' => 'Sukses mendapatkan data sertifikat',
            'data' => [
                'id_acara' => $event->id,
                'nama_acara' => $event->mdl_nama,
                'tanggal_acara' => $event->mdl_acara_selesai,
                'nama_peserta' => $user->name,
                'no_sertifikat' => $kodeSertif,
                'base_template_sertifikat' => $templateSertifikat,
                'file_sertifikat_url' => $fileUrl,
                'is_generated' => $fileUrl ? true : false,
            ]
        ], 200);
    }

    /**
     * Download sertifikat yang sudah di-generate
     */
    public function download(Request $request, $idAcara)
    {
        $user = $request->user();

        // Validasi event ada
        $event = ModulAcara::find($idAcara);
        if (!$event) {
            return response()->json([
                'status' => false,
                'message' => 'Event tidak ditemukan'
            ], 404);
        }

        // Cek sertifikat user untuk event ini
        $sertifikat = Sertifikat::where('user_id', $user->id)
            ->where('modul_acara_id', $idAcara)
            ->first();

        if (!$sertifikat) {
            return response()->json([
                'status' => false,
                'message' => 'Anda belum memiliki sertifikat untuk acara ini.'
            ], 404);
        }

        // Cek apakah file sertifikat sudah di-generate
        if (!$sertifikat->file_sertifikat) {
            return response()->json([
                'status' => false,
                'message' => 'Sertifikat belum di-generate. Silakan hubungi admin.'
            ], 404);
        }

        // Generate URL download dari S3
        $fileUrl = StorageHelper::getStorageUrl($sertifikat->file_sertifikat);

        return response()->json([
            'status' => true,
            'message' => 'Sertifikat berhasil diambil',
            'data' => [
                'id_sertifikat' => $sertifikat->id,
                'nama_peserta' => $sertifikat->name_peserta,
                'no_sertifikat' => $sertifikat->kode_sertif,
                'tanggal_sertifikat' => $sertifikat->tanggal_sertif,
                'nama_acara' => $event->mdl_nama,
                'file_url' => $fileUrl,
                'download_url' => $fileUrl, // Same as file_url, for clarity
            ]
        ], 200);
    }

    /**
     * List semua sertifikat milik user
     */
    public function mySertifikat(Request $request)
    {
        $user = $request->user();

        $sertifikat = Sertifikat::with('event:id,mdl_nama,mdl_acara_mulai,mdl_acara_selesai')
            ->where('user_id', $user->id)
            ->orderBy('tanggal_sertif', 'desc')
            ->get();

        // Generate URL untuk setiap file sertifikat
        $sertifikat->transform(function ($item) {
            if ($item->file_sertifikat) {
                $item->file_url = StorageHelper::getStorageUrl($item->file_sertifikat);
            } else {
                $item->file_url = null;
            }
            return $item;
        });

        return response()->json([
            'status' => true,
            'message' => 'Daftar sertifikat Anda',
            'data' => $sertifikat
        ], 200);
    }
}
