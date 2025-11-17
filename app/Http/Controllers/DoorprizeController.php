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
     * Draw a winner for doorprize from participants who attended a specific session and day.
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

        // Get sesi_acara from the event's mdl_sesi_acara
        $sesiAcara = $event->mdl_sesi_acara;

        // Get today's date
        $today = now()->format('Y-m-d');

        // Get all participants who attended the event TODAY with the current session
        // and haven't won doorprize yet
        $participantsData = DB::table('presensi_acara')
            ->join('pendaftaran_acara', function($join) {
                $join->on('presensi_acara.modul_acara_id', '=', 'pendaftaran_acara.modul_acara_id')
                     ->on('presensi_acara.user_id', '=', 'pendaftaran_acara.user_id');
            })
            ->where('presensi_acara.modul_acara_id', $eventId)
            ->where('presensi_acara.sesi_acara', $sesiAcara)
            ->whereDate('presensi_acara.tanggal_absen', $today)
            ->where('presensi_acara.status', 'Hadir')
            ->where('pendaftaran_acara.has_doorprize', false)
            ->select('presensi_acara.user_id', 'presensi_acara.tanggal_absen', 'presensi_acara.sesi_acara')
            ->get();

        if ($participantsData->isEmpty()) {
            return response()->json([
                'success' => false,
                'message' => "No eligible participants for doorprize in session {$sesiAcara} today ({$today}).",
                'debug_info' => [
                    'sesi_acara' => $sesiAcara,
                    'tanggal_absen' => $today,
                    'event_id' => $eventId
                ]
            ], 400);
        }

        // Randomly select a winner
        $winnerData = $participantsData->random();
        $winnerId = $winnerData->user_id;
        $tanggalAbsen = $winnerData->tanggal_absen;

        // Update the winner's has_doorprize to true
        DB::table('pendaftaran_acara')
            ->where('modul_acara_id', $eventId)
            ->where('user_id', $winnerId)
            ->update(['has_doorprize' => true]);

        // Get winner details
        $winner = User::find($winnerId);

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
                ],
                'session_info' => [
                    'tanggal_absen' => $tanggalAbsen,
                    'sesi_acara' => $sesiAcara,
                ],
                'total_eligible_participants' => $participantsData->count()
            ]
        ]);
    }

    /**
     * Get all winners for a specific event.
     * Optional: Filter by session and date.
     *
     * @param Request $request
     * @param int $eventId
     * @return \Illuminate\Http\JsonResponse
     */
    public function getWinners(Request $request, $eventId)
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

        // Get current session from event
        $sesiAcara = $event->mdl_sesi_acara;
        $today = now()->format('Y-m-d');

        // Build query for winners - join with specific presensi to avoid duplicates
        $query = DB::table('pendaftaran_acara')
            ->join('users', 'pendaftaran_acara.user_id', '=', 'users.id')
            ->join('presensi_acara', function($join) use ($sesiAcara, $today) {
                $join->on('pendaftaran_acara.modul_acara_id', '=', 'presensi_acara.modul_acara_id')
                     ->on('pendaftaran_acara.user_id', '=', 'presensi_acara.user_id')
                     ->where('presensi_acara.status', '=', 'Hadir')
                     ->where('presensi_acara.sesi_acara', '=', $sesiAcara)
                     ->whereDate('presensi_acara.tanggal_absen', '=', $today);
            })
            ->where('pendaftaran_acara.modul_acara_id', $eventId)
            ->where('pendaftaran_acara.has_doorprize', true);

        // Optional filters
        $filters = [];
        if ($request->has('tanggal_absen')) {
            $filters['tanggal_absen'] = $request->tanggal_absen;
            $query->whereDate('presensi_acara.tanggal_absen', $request->tanggal_absen);
        }
        if ($request->has('sesi_acara')) {
            $filters['sesi_acara'] = $request->sesi_acara;
            $query->where('presensi_acara.sesi_acara', $request->sesi_acara);
        }

        $winners = $query->select(
                'users.id',
                'users.name',
                'users.username',
                'users.email',
                'pendaftaran_acara.waktu_daftar',
                'pendaftaran_acara.metode_daftar',
                'presensi_acara.sesi_acara',
                'presensi_acara.tanggal_absen'
            )
            ->orderBy('pendaftaran_acara.updated_at', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'message' => 'Winners retrieved successfully.',
            'data' => [
                'event' => [
                    'id' => $event->id,
                    'name' => $event->mdl_nama,
                    'doorprize_active' => $event->mdl_doorprize_aktif,
                ],
                'filters' => $filters,
                'winners' => $winners,
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
