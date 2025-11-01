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

        $presensi = PresensiAcara::with('event')
            ->where('modul_acara_id', $request->id_acara)
            ->where('user_id', $user->id)
            ->where('status', 'Hadir')
            ->first();

        if (!$presensi) {
            return response()->json([
                'message' => 'Peserta belum dinyatakan hadir dalam acara ini.'
            ], 403);
        }

        $kodeSertif = $presensi->pendaftaranAcara?->no_sertifikat;
        $tanggalAcara = $presensi->event->mdl_acara_selesai;
        $templateSertifikat = StorageHelper::getStorageUrl($presensi->event->mdl_template_sertifikat);

        $sertifikat = Sertifikat::create([
            'name_peserta' => $user->name,
            'nama_acara' => $presensi->event->mdl_nama,
            'kode_sertif' => $kodeSertif,
            'tanggal_sertif' => $tanggalAcara,
            'base_template_sertifikat' => $templateSertifikat,
        ]);

        return response()->json($sertifikat, 200);
    }
}
