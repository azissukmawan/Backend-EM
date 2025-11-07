<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use App\Models\Sertifikat;
use Illuminate\Http\Request;
use App\Models\PresensiAcara;
use App\Helpers\SertifikatGenerator;

class GenerateSertifikatController extends Controller
{
    //
    public static function generateNomorSertifikat($modulAcaraId, $userId)
    {
        $event = ModulAcara::where('id', $modulAcaraId)->first();

        $totalHariEvent = $this->hitungTotalHariEvent($event);

        $jumlahHariHadir = PresensiAcara::where('modul_acara_id', $modulAcaraId)
            ->where('user_id', $userId)
            ->distinct('tanggal_absen')
            ->count();

        $hadirSemua = ($jumlahHariHadir >= $totalHariEvent);

        if (!$hadirSemua) {
            return response()->json([
                'success' => false,
                'message' => 'Absen tidak lengkap.',
            ], 400);
        }

        $sertifikat = Sertifikat::where('user_id', $userId)
            ->where('modul_acara_id', $modulAcaraId)
            ->first();

        if ($sertifikat) {
            // Query
            return response()->json([
                'success' => false,
                'message' => 'Bers.',
                'data' => $sertifikat->file_sertifikat,
            ], 200);
        }

        try {
            if ($event->mdl_template_sertifikat) {
                // Format tanggal acara
                $tanggalAcara = '';
                if ($event->mdl_acara_selesai) {
                    try {
                        $tanggalAcara = \Carbon\Carbon::parse($event->mdl_acara_selesai)->format('d F Y');
                    } catch (\Exception $e) {
                        $tanggalAcara = $event->mdl_acara_selesai;
                    }
                }



                $fileSertifikat = SertifikatGenerator::generate(
                    templatePath: $event->mdl_template_sertifikat,
                    namaPeserta: $user->name,
                    noSertifikat: $noSertifikat,
                    namaAcara: $event->mdl_nama,
                    tanggalAcara: $tanggalAcara
                );
                $sertifikatGenerated = true;
            }
        } catch (\Exception $e) {
            // Log error tapi tidak menggagalkan presensi
            Log::error('Gagal generate sertifikat: ' . $e->getMessage());
        }
    }

    private function hitungTotalHariEvent($event)
    {
        if (!$event->mdl_acara_selesai) {
            // Jika tidak ada tanggal selesai, dianggap 1 hari
            return 1;
        }

        $mulai = \Carbon\Carbon::parse($event->mdl_acara_mulai)->startOfDay();
        $selesai = \Carbon\Carbon::parse($event->mdl_acara_selesai)->startOfDay();

        // Hitung selisih hari + 1 (karena hari pertama dan terakhir dihitung)
        return $mulai->diffInDays($selesai) + 1;
    }
}
