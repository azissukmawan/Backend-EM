<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use App\Models\Sertifikat;
use Illuminate\Http\Request;
use App\Models\PresensiAcara;
use App\Helpers\StorageHelper;
use App\Helpers\SertifikatGenerator;
use App\Models\MasterNomorSertifikat;

class GenerateSertifikatController extends Controller
{
    //
    public function generateNomorSertifikat($modulAcaraId)
    {
        $user = auth()->user();
        $event = ModulAcara::where('id', $modulAcaraId)->first();
        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        $totalHariEvent = $this->hitungTotalHariEvent($event);

        $jumlahHariHadir = PresensiAcara::where('modul_acara_id', $modulAcaraId)
            ->where('user_id', $user->id)
            ->distinct('tanggal_absen')
            ->count();

        $hadirSemua = ($jumlahHariHadir >= $totalHariEvent);

        if (!$hadirSemua) {
            return response()->json(['status' => false, 'message' => 'Absen tidak lengkap.',], 400);
        }

        // Cek Apakah Nomor Sertifikat Sudah Terbit Atau Belum
        $masterNomorSertifikat = MasterNomorSertifikat::where('modul_acara_id', $modulAcaraId)->first();

        if (!$masterNomorSertifikat) {
            return response()->json(['status' => false, 'message' => 'Sertifikat belum terbit'], 400);
        }

        $sertifikat = Sertifikat::where('user_id', $user->id)
            ->where('modul_acara_id', $modulAcaraId)
            ->first();

        if ($sertifikat) {
            return response()->json([
                'status' => true,
                'message' => 'Sertifikat sudah di generate.',
                'data' => StorageHelper::getStorageUrl($sertifikat->file_sertifikat),
            ], 200);
        }

        try {

            $noSertifikat = "{$masterNomorSertifikat->prefix_format_nomor}{$masterNomorSertifikat->nomor_sk}{$masterNomorSertifikat->suffix_format_nomor}";

            $tanggalSertifikat = \Carbon\Carbon::parse($masterNomorSertifikat->tanggal_pengesahan)->format('d F Y');


            $fileSertifikat = SertifikatGenerator::generate(
                templatePath: $masterNomorSertifikat->template_sertifikat,
                namaPeserta: $user->name,
                noSertifikat: $noSertifikat,
                namaAcara: $event->mdl_nama,
                tanggalSertifikat: $tanggalSertifikat
            );

            $masterNomorSertifikat->update([
                'nomor_sk' => $masterNomorSertifikat->nomor_sk + 1,
            ]);

            $sertifikat = Sertifikat::create([
                'user_id' => $user->id,
                'modul_acara_id' => $event->id,
                'name_peserta' => $user->name,
                'kode_sertif' => $noSertifikat,
                'tanggal_sertif' => $masterNomorSertifikat->tanggal_pengesahan,
                'file_sertifikat' => $fileSertifikat,
            ]);

            return response()->json([
                'status' => true,
                'message' => 'Sertifikat Berhasil Di Generate',
                'data' => StorageHelper::getStorageUrl($sertifikat->file_sertifikat),
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => false,
                'message' => 'Terjadi kesalahan saat generate sertifikat.',
                'error' => $e->getMessage(), // opsional, bisa dihapus kalau mau disembunyikan
            ], 500);
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
