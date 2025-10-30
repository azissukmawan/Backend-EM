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
        Schema::create('modul_acara', function (Blueprint $table) {

            $table->bigIncrements('id');
            $table->unsignedBigInteger('user_id');

            // Identitas & publikasi
            $table->string('mdl_kode', 30)->unique();                 // kode event internal
            $table->string('mdl_slug', 180)->unique();                // untuk URL publik
            $table->string('mdl_nama', 150);
            $table->text('mdl_deskripsi');
            $table->boolean('is_public')->default(true);  // tampil di publik?

            // Tipe pelaksanaan
            $table->enum('mdl_tipe', ['online', 'offline', 'hybrid']);

            // Lokasi & absensi
            $table->string('mdl_lokasi', 255)->nullable();
            $table->decimal('mdl_latitude', 10, 7)->nullable();
            $table->decimal('mdl_longitude', 10, 7)->nullable();
            $table->unsignedInteger('mdl_radius')->nullable();

            // Pendaftaran
            $table->dateTime('mdl_pendaftaran_mulai');
            $table->dateTime('mdl_pendaftaran_selesai');
            $table->unsignedInteger('mdl_maks_peserta_eksternal')->nullable();


            // Jadwal utama event
            $table->dateTime('mdl_acara_mulai');
            $table->dateTime('mdl_acara_selesai')->nullable();

            // Status publik & status internal legal/approval
            $table->enum('mdl_status', ['draft', 'active', 'closed', 'archived'])->default('draft');

            // Dokumen/file pendukung
            $table->string('mdl_file_acara')->nullable();                 // modul materi
            $table->string('mdl_file_rundown')->nullable();                // susunan / rundown
            $table->string('mdl_template_sertifikat')->nullable();        // template sertifikat
            $table->boolean('mdl_sertifikat_aktif')->default(false);         // apakah akan terbit sertifikat?
            $table->boolean('mdl_doorprize_aktif')->default(false);         // apakah akan terbit sertifikat?
            $table->string('mdl_banner_acara')->nullable();                // poster/banner promosi

            // Catatan
            $table->text('mdl_catatan')->nullable();               // info untuk peserta

            // Audit
            $table->unsignedBigInteger('created_by');
            $table->unsignedBigInteger('updated_by')->nullable();
            $table->timestamps();
            $table->softDeletes();

            // FK
            $table->foreign('user_id')->references('id')->on('users');
            $table->foreign('created_by')->references('id')->on('users');
            $table->foreign('updated_by')->references('id')->on('users');
        });
    }


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('modul_acara');
    }
};
