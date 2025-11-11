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
            ->where('sesi_acara', $event->mdl_sesi_acara)
            ->whereDate('tanggal_absen', $tanggalHariIni)
            ->first();

        if ($sudahAbsenHariIni) {
            return response()->json(['status' => false, 'message' => "Anda sudah melakukan presensi sesi ke-{$sudahAbsenHariIni->sesi_acara}."], 400);
        }

        // Simpan presensi baru
        $presensi = PresensiAcara::create([
            'pendaftaran_acara_id' => $pendaftaran->id,
            'modul_acara_id' => $event->id,
            'user_id' => $user->id,
            'waktu_absen' => now(),
            'sesi_acara' => $event->mdl_sesi_acara,
            'tanggal_absen' => $tanggalHariIni, // 🔹 Simpan tanggal absen
            'status' => 'Hadir',
        ]);

        return response()->json([
            'status' => true,
            'message' => "Presensi berhasil dicatat, sesi ke-{$presensi->sesi_acara}.",
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
     * Admin dapat menandai/ubah presensi peserta secara manual
     * Endpoint: POST /api/admin/events/{eventId}/participants/{userId}/attendance
     */
    public function storeByAdmin(Request $request, $eventId, $userId)
    {
        $admin = $request->user();

        if (!$admin || !$admin->detailAdmin) {
            return response()->json(['status' => false, 'message' => 'Forbidden'], 403);
        }

        $event = ModulAcara::find($eventId);
        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        $validated = $request->validate([
            'session' => ['required', 'integer', 'min:1'],
            'status' => ['sometimes', 'in:Hadir,Belum Hadir'],
            'date' => ['sometimes', 'date'],
        ]);

        $pendaftaran = PendaftaranAcara::where('modul_acara_id', $event->id)
            ->where('user_id', $userId)
            ->first();

        if (!$pendaftaran) {
            return response()->json(['status' => false, 'message' => 'Peserta tidak terdaftar pada event ini'], 404);
        }

        $sudahAbsenHariIni = PresensiAcara::where('modul_acara_id', $event->id)
            ->where('user_id', $userId)
            ->where('sesi_acara', $validated['session'])
            ->whereDate('tanggal_absen', $validated['date'])
            ->first();

        if ($sudahAbsenHariIni) {
            return response()->json(['status' => false, 'message' => "Peserta sudah melakukan presensi sesi ke-{$sudahAbsenHariIni->sesi_acara}."], 400);
        }

        // $maxSessions = (int) ($event->mdl_sesi_acara ?? 0);
        // if ($maxSessions > 0 && $validated['session'] > $maxSessions) {
        //     return response()->json([
        //         'status' => false,
        //         'message' => "Nilai sesi di luar rentang event (maksimal {$maxSessions}).",
        //     ], 422);
        // }

        [$attendanceDate, $attendanceDay] = $this->resolveAttendanceDate($event, $validated['day'] ?? null, $validated['date'] ?? null);

        if (!$attendanceDate) {
            return response()->json([
                'status' => false,
                'message' => 'Tanggal presensi tidak valid atau di luar rentang event.',
            ], 422);
        }

        $status = $validated['status'] ?? 'Hadir';

        // $waktuAbsen = isset($validated[''])
        //     ? \Carbon\Carbon::parse("{$attendanceDate} {$validated['time']}")
        //     : \Carbon\Carbon::now();

        // $existing = PresensiAcara::where('modul_acara_id', $event->id)
        //     ->where('user_id', $userId)
        //     ->where('sesi_acara', $validated['session'])
        //     ->whereDate('tanggal_absen', $attendanceDate)
        //     ->first();

        // if ($existing) {
        //     $existing->update([
        //         'status' => $status,
        //         'waktu_absen' => $waktuAbsen,
        //         'tanggal_absen' => $attendanceDate,
        //     ]);

        //     return response()->json([
        //         'status' => true,
        //         'message' => 'Presensi peserta diperbarui.',
        //         'data' => [
        //             'attendance_id' => $existing->id,
        //             'user_id' => $userId,
        //             'event_id' => $event->id,
        //             'session' => (int) $validated['session'],
        //             'day' => $attendanceDay,
        //             'date' => $attendanceDate,
        //             'status' => $status,
        //         ],
        //     ]);
        // }

        $presensi = PresensiAcara::create([
            'pendaftaran_acara_id' => $pendaftaran->id,
            'modul_acara_id' => $event->id,
            'user_id' => $userId,
            'waktu_absen' => now(),
            'sesi_acara' => $validated['session'],
            'tanggal_absen' => $validated['date'],
            'status' => $status,
        ]);

        return response()->json([
            'status' => true,
            'message' => "Presensi peserta berhasil dicatat untuk sesi {$presensi->sesi_acara}.",
            'data' => [
                'attendance_id' => $presensi->id,
                'user_id' => $userId,
                'event_id' => $event->id,
                'session' => $presensi->sesi_acara,
                'date' => $presensi->tanggal_absen,
                'status' => $presensi->status,
            ],
        ]);
    }

    private function resolveAttendanceDate($event, ?int $day, ?string $dateInput): array
    {
        if ($day !== null) {
            if (!$event->mdl_acara_mulai) {
                return [null, null];
            }

            $startDate = \Carbon\Carbon::parse($event->mdl_acara_mulai)->startOfDay();
            $endDate = $event->mdl_acara_selesai
                ? \Carbon\Carbon::parse($event->mdl_acara_selesai)->startOfDay()
                : $startDate;

            if ($endDate->lt($startDate)) {
                $endDate = $startDate->copy();
            }

            $dayCount = $startDate->diffInDays($endDate) + 1;
            if ($day < 1 || $day > $dayCount) {
                return [null, null];
            }

            $date = $startDate->copy()->addDays($day - 1)->toDateString();
            return [$date, $day];
        }

        if ($dateInput) {
            $date = \Carbon\Carbon::parse($dateInput)->toDateString();
            $dayNumber = null;

            if ($event->mdl_acara_mulai) {
                $startDate = \Carbon\Carbon::parse($event->mdl_acara_mulai)->startOfDay();
                $dayNumber = \Carbon\Carbon::parse($date)->diffInDays($startDate) + 1;
            }

            return [$date, $dayNumber];
        }

        $date = \Carbon\Carbon::now()->toDateString();
        $dayNumber = null;

        if ($event->mdl_acara_mulai) {
            $startDate = \Carbon\Carbon::parse($event->mdl_acara_mulai)->startOfDay();
            $dayNumber = \Carbon\Carbon::parse($date)->diffInDays($startDate) + 1;
        }

        return [$date, $dayNumber];
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
