<?php

namespace Database\Seeders;

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
            'email' => 'superadmin@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password'),
        ]);

        User::create([
            'name' => 'Fakhri',
            'username' => 'fakhri',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password'),
        ]);

        User::create([
            'name' => 'Rizan',
            'username' => 'rizan',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password'),
        ]);

        User::create([
            'name' => 'Asep Kangkung',
            'username' => 'asep',
            'telp' => '081234567890',
            'role' => 'superadmin',
            'email' => 'superadmin@example.com',
            'email_verified_at' => now(),
            'password' => Hash::make('password'),
        ]);

        User::factory(10)->create();
    }
}
