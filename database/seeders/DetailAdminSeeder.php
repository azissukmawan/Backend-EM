<?php

namespace Database\Seeders;

use App\Models\DetailAdmin;
use App\Models\User;
use App\Models\Divisi;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DetailAdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $superAdmins = User::where('role', 'superadmin')->get();
        $divisiIds = Divisi::pluck('id')->toArray();

        foreach ($superAdmins as $admin) {
            DetailAdmin::create([
                'user_id' => $admin->id,
                'divisi_id' => $divisiIds[array_rand($divisiIds)], // Random divisi
            ]);
        }
    }
}
