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
    public static function generateNomorSertifikat($modulAcaraId)
    {
        $user = auth()->user();
        $event = ModulAcara::where('id', $modulAcaraId)->first();

        $totalHariEvent = $this->hitungTotalHariEvent($event);

        $jumlahHariHadir = PresensiAcara::where('modul_acara_id', $modulAcaraId)
            ->where('user_id', $user->id)
            ->distinct('tanggal_absen')
            ->count();

        $hadirSemua = ($jumlahHariHadir >= $totalHariEvent);

        if (!$hadirSemua) {
            return response()->json([
                'success' => false,
                'message' => 'Absen tidak lengkap.',
            ], 400);
        }

        $sertifikat = Sertifikat::where('user_id', $user->id)
            ->where('modul_acara_id', $modulAcaraId)
            ->first();

        if ($sertifikat) {
            return response()->json([
                'success' => true,
                'message' => 'Berhasil.',
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

                // Generate nomor sertifikat unik

                $masterNomor = MasterNomorSertifikat::where('modul_acara_id', $modulAcaraId)->first();

                $noSertifikat = replaceCertificateNumber($masterNomor->format_nomor, $masterNomor->nomor_sk);


                $fileSertifikat = SertifikatGenerator::generate(
                    templatePath: $event->mdl_template_sertifikat,
                    namaPeserta: $user->name,
                    noSertifikat: $noSertifikat,
                    namaAcara: $event->mdl_nama,
                    tanggalAcara: $tanggalAcara
                );
                $sertifikatGenerated = true;

                $masterNomor->update([
                    'nomor_sk' => $masterNomor->nomor_sk + 1,
                ]);

            }
        } catch (\Exception $e) {
            // Log error tapi tidak menggagalkan presensi
            Log::error('Gagal generate sertifikat: ' . $e->getMessage());
        }

        Sertifikat::create([
                'user_id' => $user->id,
                'modul_acara_id' => $event->id,
                'presensi_acara_id' => $presensi->id,
                'name_peserta' => $user->name,
                'kode_sertif' => $noSertifikat,
                'tanggal_sertif' => $event->mdl_acara_selesai ?? now(),
                'file_sertifikat' => $fileSertifikat,
            ]);
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

    private function replaceCertificateNumber($input, $newNumber)
    {
        // Ambil prefix (huruf + titik)
        preg_match('/^[A-Za-z\.]+/', $input, $prefixMatch);
        $prefix = $prefixMatch[0] ?? '';

        // Ambil suffix (mulai dari / pertama)
        $suffix = preg_replace('/^[A-Za-z\.]+[0-9]+/', '', $input);

        // Gabungkan dengan nomor baru
        return $prefix . $newNumber . $suffix;
    }
}
