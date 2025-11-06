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

        // Get all registered participants who haven't won doorprize yet AND have checked in with status 'Hadir'
        $participants = DB::table('pendaftaran_acara')
            ->join('presensi_acara', function($join) use ($eventId) {
                $join->on('pendaftaran_acara.modul_acara_id', '=', 'presensi_acara.modul_acara_id')
                     ->on('pendaftaran_acara.user_id', '=', 'presensi_acara.user_id');
            })
            ->where('pendaftaran_acara.modul_acara_id', $eventId)
            ->where('pendaftaran_acara.has_doorprize', false)
            ->where('presensi_acara.status', 'Hadir')
            ->pluck('pendaftaran_acara.user_id')
            ->toArray();

        if (empty($participants)) {
            return response()->json([
                'success' => false,
                'message' => 'No eligible participants for doorprize.'
            ], 400);
        }

        // Randomly select a winner
        $winnerId = $participants[array_rand($participants)];

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

        // Get all winners for this event
        $winners = DB::table('pendaftaran_acara')
            ->join('users', 'pendaftaran_acara.user_id', '=', 'users.id')
            ->where('pendaftaran_acara.modul_acara_id', $eventId)
            ->where('pendaftaran_acara.has_doorprize', true)
            ->select(
                'users.id',
                'users.name',
                'users.username',
                'users.email',
                'pendaftaran_acara.waktu_daftar',
                'pendaftaran_acara.metode_daftar'
            )
            ->orderBy('pendaftaran_acara.updated_at', 'desc') // Assuming updated_at is when they won
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
