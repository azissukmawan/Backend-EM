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

        $kodeAcara = $presensi->modulAcara->mdl_kode;

        if (!$kodeAcara) {
            return response()->json([
                'message' => 'Kode acara tidak ditemukan.'
            ], 404);
        }

        $sertifikat = Sertifikat::create([
            'name_peserta' => $user->name,
            'kode_acara' => $kodeAcara,
        ]);

        return response()->json($sertifikat, 201);
    }
}
