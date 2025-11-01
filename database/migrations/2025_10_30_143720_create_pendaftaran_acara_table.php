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
        Schema::create('pendaftaran_acara', function (Blueprint $table) {
            $table->id();
            $table->foreignId('modul_acara_id')->constrained('modul_acara')->cascadeOnDelete();
            $table->foreignId('user_id')->constrained('users')->cascadeOnDelete();

            $table->enum('metode_daftar', ['self', 'invite'])->default('self');
            $table->timestamp('waktu_daftar')->useCurrent();
            $table->boolean('has_doorprize')->default(false);
            $table->string('no_sertifikat', 30)->nullable()->default(null);


            $table->timestamps();
            $table->unique(['modul_acara_id', 'user_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pendaftaran_acara');
    }
};
