<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use App\Models\PendaftaranAcara;
use App\Models\PresensiAcara;
use App\Models\Sertifikat;
use Illuminate\Http\Request;
use App\Helpers\SertifikatGenerator;
use Illuminate\Support\Facades\Log;

class PresensiController extends Controller
{

    public function store(Request $request)
    {
        $user = auth()->user();

        $request->validate([
            'kode' => 'required',
        ]);

        // Cari event berdasarkan kode QR
        $event = ModulAcara::where('mdl_kode_qr', $request->kode)->first();

        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        if (!$event->mdl_presensi_aktif) {
            return response()->json(['status' => false, 'message' => 'Presensi belum dibuka'], 400);
        }

        // Pastikan user terdaftar di event
        $pendaftaran = PendaftaranAcara::where('modul_acara_id', $event->id)
            ->where('user_id', $user->id)
            ->first();

        if (!$pendaftaran) {
            return response()->json(['status' => false, 'message' => 'Anda belum terdaftar di event ini'], 403);
        }

        // Validasi waktu presensi
        $now = now();
        if ($now->lt($event->mdl_acara_mulai) || ($event->mdl_acara_selesai && $now->gt($event->mdl_acara_selesai))) {
            return response()->json(['status' => false, 'message' => 'Presensi belum dibuka atau sudah ditutup'], 400);
        }

        // VALIDASI: Cegah double absensi di hari yang sama
        $tanggalHariIni = $now->toDateString();
        $sudahAbsenHariIni = PresensiAcara::where('modul_acara_id', $event->id)
            ->where('user_id', $user->id)
            ->whereDate('tanggal_absen', $tanggalHariIni)
            ->exists();

        if ($sudahAbsenHariIni) {
            return response()->json(['status' => false, 'message' => 'Anda sudah melakukan presensi hari ini'], 400);
        }

        // Simpan presensi baru
        PresensiAcara::create([
            'pendaftaran_acara_id' => $pendaftaran->id,
            'modul_acara_id' => $event->id,
            'user_id' => $user->id,
            'waktu_absen' => now(),
            'tanggal_absen' => $tanggalHariIni, // 🔹 Simpan tanggal absen
            'status' => 'Hadir',
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Presensi berhasil dicatat',
            // 'no_sertifikat' => $noSertifikat,
            // 'sertifikat_generated' => $sertifikatGenerated,
        ]);
    }


    /**
     * API 2 - Daftar presensi peserta (untuk panitia)
     */
    public function index($id)
    {
        $event = ModulAcara::find($id);

        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        $presensi = PresensiAcara::with('user:id,name,email')
            ->where('modul_acara_id', $id)
            ->get();

        return response()->json([
            'status' => true,
            'message' => 'Daftar presensi acara',
            'data' => [
                'event' => $event->mdl_nama,
                'peserta' => $presensi
            ]
        ]);
    }

    /**
     * API 3 - Status presensi user sendiri
     */
    public function me($id)
    {
        $user = auth()->user();

        $presensi = PresensiAcara::where('modul_acara_id', $id)
            ->where('user_id', $user->id)
            ->first();

        if (!$presensi) {
            return response()->json(['status' => true, 'message' => 'Belum melakukan presensi', 'data' => null]);
        }

        return response()->json([
            'status' => true,
            'message' => 'Status presensi Anda',
            'data' => [
                'status' => $presensi->status,
                'waktu_absen' => $presensi->waktu_absen
            ]
        ]);
    }

    /**
     * API 4 - Tampilkan QR Code Event (frontend generate visualnya)
     */
    public function showQr($id)
    {
        $event = ModulAcara::find($id);
        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'QR Code event ditemukan',
            'data' => [
                'event' => $event->mdl_nama,
                'qr_code' => $event->mdl_kode_qr,
                'modul_acara_id' => $event->id,
            ]
        ]);
    }

    /**
     * Hitung total hari periode event
     * Menghitung berapa hari event berlangsung (dari mdl_acara_mulai sampai mdl_acara_selesai)
     */
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

    /**
     * Hitung jarak antar koordinat (meter)
     */
    private function hitungJarak($lat1, $lon1, $lat2, $lon2)
    {
        if (!$lat1 || !$lon1 || !$lat2 || !$lon2) return 999999;
        $R = 6371000; // meter
        $dLat = deg2rad($lat2 - $lat1);
        $dLon = deg2rad($lon2 - $lon1);
        $a = sin($dLat / 2) ** 2 +
            cos(deg2rad($lat1)) * cos(deg2rad($lat2)) *
            sin($dLon / 2) ** 2;
        return (int) round($R * (2 * atan2(sqrt($a), sqrt(1 - $a))));
    }
}
