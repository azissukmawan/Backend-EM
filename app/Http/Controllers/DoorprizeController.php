<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

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
        // Validate that the event exists and has doorprize active
        $event = ModulAcara::findOrFail($eventId);

        if (!$event->mdl_doorprize_aktif) {
            return response()->json([
                'success' => false,
                'message' => 'Doorprize is not active for this event.'
            ], 400);
        }

        // Get all registered participants who haven't won doorprize yet
        $participants = DB::table('pendaftaran_acara')
            ->where('modul_acara_id', $eventId)
            ->where('has_doorprize', false)
            ->pluck('user_id')
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
}