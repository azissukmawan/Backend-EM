<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('presensi_acara', function (Blueprint $table) {
            $table->id();
            $table->foreignId('modul_acara_id')->constrained('modul_acara')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();

            $table->timestamp('waktu_absen')->useCurrent();
            $table->enum('status', ['Hadir', 'Belum Hadir'])->default('Belum Hadir');
            $table->decimal('latitude', 10, 7)->nullable();
            $table->decimal('longitude', 10, 7)->nullable();

            $table->timestamps();
            $table->unique(['modul_acara_id', 'user_id']); // hanya bisa absen sekali per event
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('presensi_acara');
    }
};
