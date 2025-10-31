<?php

namespace Database\Factories;

use App\Models\ModulAcara;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends Factory<ModulAcara>
 */
class ModulAcaraFactory extends Factory
{
    protected $model = ModulAcara::class;

    public function definition(): array
    {
        $name = $this->faker->unique()->sentence(3);
        $slug = Str::slug($name . ' ' . $this->faker->unique()->bothify('evt-####'));
        $kode = strtoupper(Str::random(5)) . '-' . $this->faker->numberBetween(100, 999);

        $startReg = $this->faker->dateTimeBetween('-10 days', '+2 days');
        $endReg = (clone $startReg)->modify('+' . $this->faker->numberBetween(3, 10) . ' days');

        $startEvent = (clone $endReg)->modify('+' . $this->faker->numberBetween(1, 5) . ' days');
        $endEvent = (clone $startEvent)->modify('+' . $this->faker->numberBetween(2, 8) . ' hours');

        $kategori = $this->faker->randomElement(['public', 'private', 'invite-only']);
        $tipe = $this->faker->randomElement(['online', 'offline', 'hybrid']);
        $isOffline = in_array($tipe, ['offline', 'hybrid']);

        $user = User::inRandomOrder()->first() ?? User::factory()->create();

        return [
            'user_id' => $user->id,
            'mdl_kode' => $kode,
            'mdl_slug' => $slug,
            'mdl_nama' => $name,
            'mdl_deskripsi' => $this->faker->paragraphs(3, true),
            'mdl_kategori' => $kategori,
            'mdl_tipe' => $tipe,
            'mdl_lokasi' => $isOffline ? $this->faker->address() : null,
            'mdl_latitude' => $isOffline ? $this->faker->latitude(-11.0, 6.0) : null,
            'mdl_longitude' => $isOffline ? $this->faker->longitude(95.0, 141.0) : null,
            'mdl_radius' => $isOffline ? $this->faker->numberBetween(50, 500) : null,
            'mdl_pendaftaran_mulai' => $startReg,
            'mdl_pendaftaran_selesai' => $endReg,
            'mdl_maks_peserta_eksternal' => $kategori == 'public' ? $this->faker->numberBetween(50, 500) : null,
            'mdl_acara_mulai' => $startEvent,
            'mdl_acara_selesai' => $this->faker->boolean(90) ? $endEvent : null,
            'mdl_status' => $this->faker->randomElement(['draft', 'active', 'closed']),
            'mdl_file_acara' => $this->faker->boolean(30) ? $this->faker->filePath() : null,
            'mdl_file_rundown' => $this->faker->boolean(30) ? $this->faker->filePath() : null,
            'mdl_template_sertifikat' => $this->faker->boolean(30) ? $this->faker->filePath() : null,
            'mdl_sertifikat_aktif' => $this->faker->boolean(60),
            'mdl_doorprize_aktif' => $this->faker->boolean(30),
            'mdl_banner_acara' => $this->faker->boolean(40) ? $this->faker->imageUrl(1200, 630, 'modulAcara', true, 'banner') : null,
            'mdl_catatan' => $this->faker->optional()->sentence(12),
            'created_by' => $user->id,
            'updated_by' => $this->faker->boolean(70) ? $user->id : null,
        ];
    }
}
