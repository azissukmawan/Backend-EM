<?php

namespace Database\Seeders;

use App\Models\ModulAcara;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class PendaftaranAcaraSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $events = ModulAcara::query()->get();
        if ($events->isEmpty()) {
            $this->command?->warn('Tidak ada event pada modul_acara. Lewati PendaftaranAcaraSeeder.');
            return;
        }

        $pesertaUsers = User::query()->where('role', 'peserta')->get();
        if ($pesertaUsers->isEmpty()) {
            $this->command?->warn('Tidak ada user dengan role peserta. Lewati PendaftaranAcaraSeeder.');
            return;
        }

        foreach ($events as $event) {
            $targetCount = rand(15, 40);
            $count = min($targetCount, $pesertaUsers->count());

            if ($count === 0) {
                continue;
            }

            $selected = $pesertaUsers->shuffle()->take($count);

            $rows = [];
            foreach ($selected as $user) {
                $rows[] = [
                    'modul_acara_id' => $event->id,
                    'user_id' => $user->id,
                    'metode_daftar' => rand(0, 1) ? 'self' : 'invite',
                    'waktu_daftar' => $this->randomWaktuDaftar($event),
                    'has_doorprize' => false,
                    // 'no_sertifikat' => null, // keep default
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
            }

            // insertOrIgnore untuk menghindari unique constraint violation (modul_acara_id, user_id)
            DB::table('pendaftaran_acara')->insertOrIgnore($rows);
        }
    }

    private function randomWaktuDaftar(ModulAcara $event)
    {
        $start = $event->mdl_pendaftaran_mulai ? Carbon::parse($event->mdl_pendaftaran_mulai) : now()->subDays(10);
        $end = $event->mdl_pendaftaran_selesai ? Carbon::parse($event->mdl_pendaftaran_selesai) : now();
        if ($end->lessThan($start)) {
            [$start, $end] = [$end, $start];
        }
        $diff = $end->diffInSeconds($start) ?: 1;
        return $start->copy()->addSeconds(rand(0, $diff));
    }
}
