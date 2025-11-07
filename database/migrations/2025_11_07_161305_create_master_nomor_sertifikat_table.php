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
        Schema::create('master_nomor_sertifikat', function (Blueprint $table) {
            $table->id();
            $table->foreignId('modul_acara_id')->constrained('modul_acara')->cascadeOnDelete();

            $table->integer('nomor_sk')->unique();
            $table->string('format_nomor');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('master_nomor_sertifikat');
    }
};
