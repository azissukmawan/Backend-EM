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

            $table->integer('nomor_sk');
            $table->year('tahun');
            $table->date('tanggal_pengesahan')->nullable();
            $table->string('format_nomor');
            $table->string('prefix_format_nomor');
            $table->string('suffix_format_nomor');

            $table->string('template_sertifikat')->nullable();

            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('updated_by')->nullable();

            $table->timestamps();

            $table->foreign('created_by')->references('id')->on('users');
            $table->foreign('updated_by')->references('id')->on('users');
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
