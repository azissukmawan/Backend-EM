<?php

namespace App\Http\Controllers;

use App\Models\Sertifikat;
use App\Models\PresensiAcara;
use Illuminate\Http\Request;
use App\Helpers\StorageHelper;

class SertifikatController extends Controller
{
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
            ]
        ], 200);
    }
}
