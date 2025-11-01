<?php

namespace App\Http\Controllers;

use App\Models\Sertifikat;
use App\Models\PresensiAcara;
use Illuminate\Http\Request;

class SertifikatController extends Controller
{
    public function generate(Request $request)
    {
        $request->validate([
            'id_acara' => 'required|exists:modul_acara,id',
        ]);

        $user = $request->user();

        $presensi = PresensiAcara::with('modulAcara')
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
        $tanggalAcara = $presensi->modulAcara->mdl_acara_selesai;
        

        $sertifikat = Sertifikat::create([
            'name_peserta' => $user->name,
            'kode_sertif' => $kodeSertif,
            'tanggal_sertif' => $tanggalAcara,
        ]);

        return response()->json($sertifikat, 200);
    }
}
