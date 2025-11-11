<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class DoorprizeController extends Controller
{
    /**
     * Draw a winner for doorprize from registered participants of an event.
     *
     * @param Request $request
     * @param int $eventId
     * @return \Illuminate\Http\JsonResponse
     */
    /**
     * Draw a winner for doorprize from registered participants of an event, otomatis per hari & sesi aktif.
     *
     * @param Request $request
     * @param int $eventId
     * @return \Illuminate\Http\JsonResponse
     */
    public function drawWinner(Request $request, $eventId)
    {
        // Check if user is superadmin
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        // Validate that the event exists and has doorprize active
        $event = ModulAcara::findOrFail($eventId);

        if (!$event->mdl_doorprize_aktif) {
            return response()->json([
                'success' => false,
                'message' => 'Doorprize is not active for this event.'
            ], 400);
        }


        // Ambil mapping tanggal_absen ke hari_ke dan sesi dari presensi event ini
        $presensi = \App\Models\PresensiAcara::where('modul_acara_id', $eventId)->get();
        $allDates = [];
        foreach ($presensi as $p) {
            if ($p->tanggal_absen) {
                $dateStr = is_object($p->tanggal_absen) ? $p->tanggal_absen->format('Y-m-d') : (string) $p->tanggal_absen;
                $allDates[] = $dateStr;
            }
        }
        $uniqueDates = array_values(array_unique($allDates));
        sort($uniqueDates);
        $dateToDay = [];
        foreach ($uniqueDates as $idx => $date) {
            $dateToDay[$date] = $idx + 1;
        }
        // Ambil hari terakhir (atau logika lain sesuai kebutuhan)
        $targetDate = end($uniqueDates);
        $hariKe = $targetDate && isset($dateToDay[$targetDate]) ? $dateToDay[$targetDate] : null;
        // Ambil sesi aktif dari modul acara
        $event = \App\Models\ModulAcara::findOrFail($eventId);
        $targetSesi = $event->mdl_sesi_acara;
        if (!$targetDate || !$targetSesi) {
            return response()->json([
                'success' => false,
                'message' => 'Hari atau sesi tidak ditemukan pada event ini.'
            ], 400);
        }


        // Cari peserta eligible dari presensi_acara (belum pernah menang doorprize di sesi & hari ini)
        $eligible = \App\Models\PresensiAcara::where('modul_acara_id', $eventId)
            ->where('status', 'Hadir')
            ->whereDate('tanggal_absen', $targetDate)
            ->where('sesi_acara', $targetSesi)
            ->where(function($q) {
                $q->whereNull('has_doorprize')->orWhere('has_doorprize', 0);
            })
            ->get();

        if ($eligible->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => 'No eligible participants for doorprize pada Hari-' . $hariKe . ', Sesi-' . $targetSesi . '.'
            ], 400);
        }

        // Randomly select a winner
        $winnerPresensi = $eligible->random();
        $winnerId = $winnerPresensi->user_id;

        // Update has_doorprize di presensi_acara (bukan di pendaftaran_acara)
        $winnerPresensi->has_doorprize = 1;
        $winnerPresensi->save();

        // Get winner details
        $winner = \App\Models\User::find($winnerId);

        return response()->json([
            'success' => true,
            'message' => 'Winner drawn successfully.',
            'data' => [
                'winner' => [
                    'id' => $winner->id,
                    'name' => $winner->name,
                    'email' => $winner->email,
                    'username' => $winner->username,
                ],
                'event' => [
                    'id' => $event->id,
                    'name' => $event->mdl_nama,
                ]
            ]
        ]);
    }

    /**
     * Get all winners for a specific event.
     *
     * @param int $eventId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getWinners($eventId)
    {
        // Check if user is superadmin
        if (!Auth::check() || Auth::user()->role !== 'superadmin') {
            return response()->json([
                'success' => false,
                'message' => 'Forbidden: Only superadmin can perform this action.'
            ], 403);
        }

        // Validate that the event exists
        $event = ModulAcara::findOrFail($eventId);

        // Ambil semua pemenang dari presensi_acara (has_doorprize = 1)
        $winners = \App\Models\PresensiAcara::where('modul_acara_id', $eventId)
            ->where('has_doorprize', 1)
            ->with('user')
            ->get();

        // Kelompokkan per hari dan sesi
        $grouped = [];
        foreach ($winners as $winner) {
            $tanggal = is_object($winner->tanggal_absen) ? $winner->tanggal_absen->format('Y-m-d') : (string) $winner->tanggal_absen;
            $sesi = $winner->sesi_acara;
            $grouped[$tanggal]['Sesi-' . $sesi][] = [
                'id' => $winner->user->id ?? null,
                'name' => $winner->user->name ?? null,
                'username' => $winner->user->username ?? null,
                'email' => $winner->user->email ?? null,
                'tanggal_absen' => $tanggal,
                'sesi_acara' => $sesi,
            ];
        }

        return response()->json([
            'success' => true,
            'message' => 'Winners retrieved successfully.',
            'data' => [
                'event' => [
                    'id' => $event->id,
                    'name' => $event->mdl_nama,
                    'doorprize_active' => $event->mdl_doorprize_aktif,
                ],
                'winners_per_hari_sesi' => $grouped,
                'total_winners' => $winners->count()
            ]
        ]);
    }

    public function deleteWinner(Request $request, $eventId, $userId)
    {
        // Check if user is superadmin
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        // Validate that the event exists
        $event = ModulAcara::findOrFail($eventId);

        // Check if the user is actually a winner for this event
        $winnerExists = DB::table('pendaftaran_acara')
            ->where('modul_acara_id', $eventId)
            ->where('user_id', $userId)
            ->where('has_doorprize', true)
            ->exists();

        if (!$winnerExists) {
            return response()->json([
                'success' => false,
                'message' => 'User is not a winner for this event.'
            ], 400);
        }

        // Get winner details before deletion
        $winner = User::find($userId);

        // Reset has_doorprize to 0 (false)
        DB::table('pendaftaran_acara')
            ->where('modul_acara_id', $eventId)
            ->where('user_id', $userId)
            ->update(['has_doorprize' => false]);

        return response()->json([
            'success' => true,
            'message' => 'Winner removed successfully.',
            'data' => [
                'removed_winner' => [
                    'id' => $winner->id,
                    'name' => $winner->name,
                ],
                'event' => [
                    'id' => $event->id,
                    'name' => $event->mdl_nama,
                ]
            ]
        ]);
    }
}
