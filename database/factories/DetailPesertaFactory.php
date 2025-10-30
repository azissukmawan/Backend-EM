<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\DetailPeserta>
 */
class DetailPesertaFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_id' => User::factory(),
            'foto' => fake()->imageUrl(200, 200, 'people', true, 'Faker'),
            'status_karyawan' => fake()->boolean(),
        ];
    }
}
