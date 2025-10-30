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
    public function show($eventId)
    {
        $jumlahPendaftar = PendaftaranAcara::where('modul_acara_id', $eventId)->count();

        $jumlahHadir = PresensiAcara::where('modul_acara_id', $eventId)
            ->where('status', 'Hadir')
            ->count();

        // Ambil tipe event (online/offline/hybrid)
        $event = ModulAcara::findOrFail($eventId);

        $onlineCount = 0;
        $offlineCount = 0;

        if ($event->mdl_tipe === 'hybrid') {
            $onlineCount = PendaftaranAcara::where('modul_acara_id', $eventId)
                ->whereHas('event', fn($q) => $q->where('mdl_tipe', 'online'))
                ->count();

            $offlineCount = PendaftaranAcara::where('modul_acara_id', $eventId)
                ->whereHas('event', fn($q) => $q->where('mdl_tipe', 'offline'))
                ->count();
        } elseif ($event->mdl_tipe === 'online') {
            $onlineCount = $jumlahPendaftar;
        } elseif ($event->mdl_tipe === 'offline') {
            $offlineCount = $jumlahPendaftar;
        }

        // Jumlah peserta yang mendapat doorprize
        $doorprizeCount = PendaftaranAcara::where('modul_acara_id', $eventId)
            ->where('has_doorprize', true)
            ->count();

        return response()->json([
            'success' => true,
            'data' => [
                'jumlah_pendaftar' => $jumlahPendaftar,
                'jumlah_kehadiran' => $jumlahHadir,
                'online' => $onlineCount,
                'offline' => $offlineCount,
                'status_doorprize' => $doorprizeCount,
            ],
        ]);
    }
}
