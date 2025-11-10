<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\ModulAcara;
use App\Models\Sertifikat;
use Illuminate\Http\Request;
use App\Models\PresensiAcara;
use App\Helpers\StorageHelper;
use App\Models\PendaftaranAcara;
use Illuminate\Support\Facades\DB;
use App\Helpers\SertifikatGenerator;
use App\Models\MasterNomorSertifikat;

class GenerateSertifikatController extends Controller
{
    //
    public function generateNomorSertifikat($modulAcaraId)
    {
        $user  = auth()->user();
        $event = ModulAcara::find($modulAcaraId);

        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        // Pastikan user terdaftar di event
        $pendaftaran = PendaftaranAcara::where('modul_acara_id', $event->id)
            ->where('user_id', $user->id)
            ->first();

        if (!$pendaftaran) {
            return response()->json(['status' => false, 'message' => 'Anda belum terdaftar di event ini'], 403);
        }

        // $totalHariEvent = $this->hitungTotalHariEvent($event);

        // $jumlahHariHadir = PresensiAcara::where('modul_acara_id', $modulAcaraId)->where('user_id', $user->id)
        //     ->distinct()
        //     ->count('tanggal_absen');

        // if ($jumlahHariHadir < $totalHariEvent) {
        //     return response()->json(['status' => false, 'message' => 'Absen tidak lengkap.'], 400);
        // }

        // kalau sudah punya sertifikat, langsung balikin
        $existing = Sertifikat::where('user_id', $user->id)->where('modul_acara_id', $modulAcaraId)->first();

        if ($existing) {
            return response()->json([
                'status'  => true,
                'message' => 'Sertifikat sudah digenerate.',
                'data'    => StorageHelper::getStorageUrl($existing->file_sertifikat),
            ], 200);
        }

        $masterNomor = MasterNomorSertifikat::where('modul_acara_id', $modulAcaraId)->first();

        // jika nomor sk belum di generate admin
        if (!$masterNomor) {
            return response()->json(['status' => false, 'message' => 'Sertifikat belum terbit'], 400);
        }

        try {
            $filePath = DB::transaction(function () use ($modulAcaraId, $user, $event) {
                // Kunci row agar tidak tabrakan antar peserta
                $master = MasterNomorSertifikat::where('modul_acara_id', $modulAcaraId)
                    ->lockForUpdate()
                    ->first();

                $noSertifikat = "{$master->prefix_format_nomor}{$master->nomor_sk}{$master->suffix_format_nomor}";
                $tanggalSertifikat = Carbon::parse($master->tanggal_pengesahan)->format('d F Y');

                // generate file sertif
                $fileSertifikat = SertifikatGenerator::generate(
                    templatePath: $master->template_sertifikat,
                    namaPeserta: $user->name,
                    noSertifikat: $noSertifikat,
                    namaAcara: $event->mdl_nama,
                    tanggalSertifikat: $tanggalSertifikat
                );

                // Simpan sertifikat baru
                Sertifikat::create([
                    'user_id'         => $user->id,
                    'modul_acara_id'  => $event->id,
                    'name_peserta'    => $user->name,
                    'kode_sertif'     => $noSertifikat,
                    'tanggal_sertif'  => $master->tanggal_pengesahan,
                    'file_sertifikat' => $fileSertifikat,
                ]);

                // naikkan nomor_sk untuk next peserta (masih dalam lock)
                $master->increment('nomor_sk');

                return $fileSertifikat;
            });

            return response()->json([
                'status'  => true,
                'message' => 'Sertifikat Berhasil Di Generate',
                'data'    => StorageHelper::getStorageUrl($filePath),
            ], 201);
        } catch (\Throwable $e) {
            return response()->json([
                'status'  => false,
                'message' => 'Terjadi kesalahan saat generate sertifikat.',
                // 'error'   => $e->getMessage(),
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
