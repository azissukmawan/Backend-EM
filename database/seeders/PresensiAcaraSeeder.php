<?php

namespace Database\Seeders;

use App\Models\ModulAcara;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class PresensiAcaraSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $events = ModulAcara::all();
        foreach ($events as $event) {
            // Tandai sebagian peserta terdaftar sebagai hadir
            $registered = DB::table('pendaftaran_acara')
                ->where('modul_acara_id', $event->id)
                ->pluck('user_id');

            if ($registered->isEmpty()) continue;

            // 50-70% hadir
            $take = max(1, (int) round($registered->count() * rand(50, 70) / 100));
            $attendees = $registered->shuffle()->take($take);

            $rows = [];
            foreach ($attendees as $userId) {
                $rows[] = [
                    'modul_acara_id' => $event->id,
                    'user_id' => $userId,
                    'waktu_absen' => $this->randomWaktuAbsen($event),
                    'status' => 'Hadir',
                    'latitude' => null,
                    'longitude' => null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            DB::table('presensi_acara')->insertOrIgnore($rows);
        }
    }

    private function randomWaktuAbsen(ModulAcara $event)
    {
        $start = $event->mdl_acara_mulai ? Carbon::parse($event->mdl_acara_mulai) : now()->subDays(1);
        $end = $event->mdl_acara_selesai ? Carbon::parse($event->mdl_acara_selesai) : now();
        if ($end->lessThan($start)) {
            [$start, $end] = [$end, $start];
        }
        $diff = $end->diffInSeconds($start) ?: 1;
        return $start->copy()->addSeconds(rand(0, $diff));
    }
}