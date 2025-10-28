<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Divisi>
 */
class DivisiFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $divisions = [
            'Teknologi Informasi' => 'Bertanggung jawab atas pengembangan dan pemeliharaan sistem teknologi informasi',
            'Sumber Daya Manusia' => 'Mengelola semua aspek yang berkaitan dengan kepegawaian dan pengembangan SDM',
            'Keuangan' => 'Mengelola perencanaan, pengendalian, dan pelaporan keuangan perusahaan',
            'Pemasaran' => 'Bertanggung jawab atas strategi pemasaran dan promosi produk/layanan',
            'Operasional' => 'Mengelola kegiatan operasional harian dan proses bisnis perusahaan',
            'Hubungan Masyarakat' => 'Mengelola komunikasi dan hubungan dengan stakeholder eksternal',
        ];

        $division = fake()->randomElement(array_keys($divisions));

        return [
            'nama' => $division,
            'desc' => $divisions[$division],
        ];
    }
}
