<?php

namespace Database\Seeders;

use App\Models\ModulAcara;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class ModulAcaraSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Pastikan ada minimal 3 user agar relasi valid
        if (User::count() < 3) {
            User::factory()->count(3 - User::count())->create();
        }

        // Buat beberapa event publik dan internal
        ModulAcara::factory()->count(10)->create();

        // Contoh acara spesifik untuk dev/testing
        $user = User::inRandomOrder()->first();
        ModulAcara::factory()->create([
            'mdl_kode' => 'EVT-DEV-001',
            'mdl_slug' => Str::slug('Acara Developer Benchmark ' . now()->timestamp),
            'mdl_nama' => 'Acara Developer Benchmark',
            'mdl_status' => 'active',
            'mdl_kategori' => 'public',
            'mdl_tipe' => 'hybrid',
            'created_by' => $user->id,
            'updated_by' => $user->id,
        ]);
    }
}
