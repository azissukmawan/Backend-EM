<?php

namespace Database\Factories;

use App\Models\User;
use App\Models\Divisi;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\DetailAdmin>
 */
class DetailAdminFactory extends Factory
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
            'divisi_id' => Divisi::factory(),
        ];
    }
}
