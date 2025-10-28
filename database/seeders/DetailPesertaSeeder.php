<?php

namespace Database\Seeders;

use App\Models\DetailPeserta;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DetailPesertaSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $pesertaUsers = User::where('role', 'peserta')->get();

        foreach ($pesertaUsers as $user) {
            DetailPeserta::create([
                'user_id' => $user->id,
                'foto' => 'https://via.placeholder.com/200x200.png?text=User+' . $user->id,
                'status_karyawan' => fake()->boolean(),
            ]);
        }

        if ($pesertaUsers->count() < 5) {
            DetailPeserta::factory(5 - $pesertaUsers->count())->create();
        }
    }
}
