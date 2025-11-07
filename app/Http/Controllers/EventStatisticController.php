<?php

namespace App\Http\Controllers;

use App\Models\PendaftaranAcara;
use App\Models\PresensiAcara;
use App\Models\ModulAcara;
use Illuminate\Http\Request;

class EventStatisticController extends Controller
{
    /**
     * Statistik peserta per event
     */
    public function show(Request $request, $eventId)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $jumlahPendaftar = PendaftaranAcara::where('modul_acara_id', $eventId)->count();

        $jumlahHadir = PresensiAcara::where('modul_acara_id', $eventId)
            ->where('status', 'Hadir')
            ->count();

        $doorprizeCount = PendaftaranAcara::where('modul_acara_id', $eventId)
            ->where('has_doorprize', true)
            ->count();

        // Ambil tipe event
        $event = ModulAcara::findOrFail($eventId);

        // Default nilai 0
        $onlineCount = 0;
        $offlineCount = 0;

        // Logika sesuai tipe event
        switch ($event->mdl_tipe) {
            case 'online':
                $onlineCount = $jumlahPendaftar;
                break;

            case 'offline':
                $offlineCount = $jumlahPendaftar;
                break;

            case 'hybrid':
                // Hybrid -> ambil dari tipe_kehadiran yang dipilih peserta
                $onlineCount = PendaftaranAcara::where('modul_acara_id', $eventId)
                    ->where('tipe_kehadiran', 'online')
                    ->count();
                $offlineCount = PendaftaranAcara::where('modul_acara_id', $eventId)
                    ->where('tipe_kehadiran', 'offline')
                    ->count();
                break;
        }

        return response()->json([
            'success' => true,
            'data' => [
                'jumlah_pendaftar'  => $jumlahPendaftar,
                'jumlah_kehadiran'  => $jumlahHadir,
                'jumlah_doorprize'  => $doorprizeCount,
                'online'             => $onlineCount,
                'offline'            => $offlineCount,
            ],
        ]);
    }
}
