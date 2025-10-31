<?php

namespace Database\Seeders;

use App\Models\DetailPeserta;
use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User::create([
            'name' => 'Abdul Azis Sukmawan',
            'username' => 'azis',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin1@gmail.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password'),
        ]);

        User::create([
            'name' => 'Yohanes Tedy',
            'username' => 'tedy',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin2@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('passwordAdmin'),
        ]);

        User::create([
            'name' => 'Fakhri',
            'username' => 'fakhri',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin3@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('passwordAdmin'),
        ]);

        User::create([
            'name' => 'Rizan',
            'username' => 'rizan',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin4@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('passwordAdmin'),
        ]);

        User::create([
            'name' => 'Asep Kangkung',
            'username' => 'asep',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin5@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('passwordAdmin'),
        ]);


        // Seeder Peserta Eksternal
        $pesertainternal = User::create([
            'name' => 'Budi Karyawan Airnav',
            'username' => 'pesertainternal',
            'telp' => '081234567890',
            'role' => 'peserta',
            'email' => 'peserta1@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('passwordPeserta'),
        ]);

        DetailPeserta::create([

            'user_id' => $pesertainternal->id,
            'foto' => null,
            'status_karyawan' => true,
        ]);

        // Seeder Peserta Eksternal
        $pesertaeksternal = User::create([
            'name' => 'Andi Peserta Eksternal',
            'username' => 'pesertaeksternal',
            'telp' => '081234567890',
            'role' => 'peserta',
            'email' => 'peserta2@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('passwordPeserta'),
        ]);

        DetailPeserta::create([

            'user_id' => $pesertaeksternal->id,
            'foto' => null,
            'status_karyawan' => false,
        ]);

        User::factory(10)->create();
    }
}
