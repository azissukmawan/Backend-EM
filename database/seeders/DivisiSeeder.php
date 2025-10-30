<?php

namespace Database\Seeders;

use App\Models\Divisi;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DivisiSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $divisions = [
            [
                'nama' => 'Teknologi Informasi',
                'desc' => 'Bertanggung jawab atas pengembangan dan pemeliharaan sistem teknologi informasi'
            ],
            [
                'nama' => 'Sumber Daya Manusia',
                'desc' => 'Mengelola semua aspek yang berkaitan dengan kepegawaian dan pengembangan SDM'
            ],
            [
                'nama' => 'Keuangan',
                'desc' => 'Mengelola perencanaan, pengendalian, dan pelaporan keuangan perusahaan'
            ],
            [
                'nama' => 'Pemasaran',
                'desc' => 'Bertanggung jawab atas strategi pemasaran dan promosi produk/layanan'
            ],
            [
                'nama' => 'Operasional',
                'desc' => 'Mengelola kegiatan operasional harian dan proses bisnis perusahaan'
            ],
            [
                'nama' => 'Hubungan Masyarakat',
                'desc' => 'Mengelola komunikasi dan hubungan dengan stakeholder eksternal'
            ],
        ];

        foreach ($divisions as $division) {
            Divisi::create($division);
        }
    }
}
