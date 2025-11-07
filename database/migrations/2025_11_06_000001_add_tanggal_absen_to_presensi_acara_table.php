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
        Schema::table('presensi_acara', function (Blueprint $table) {
            // Drop unique constraint lama (satu presensi per pendaftaran)
            $table->dropUnique('presensi_pendaftaran_unique');

            // Tambahkan kolom tanggal_absen untuk tracking absen per hari
            $table->date('tanggal_absen')->after('waktu_absen')->nullable();

            // Buat unique constraint baru: user hanya bisa absen 1x per hari per event
            $table->unique(['modul_acara_id', 'user_id', 'tanggal_absen'], 'unique_presensi_per_hari');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('presensi_acara', function (Blueprint $table) {
            // Drop constraint baru
            $table->dropUnique('unique_presensi_per_hari');

            // Hapus kolom tanggal_absen
            $table->dropColumn('tanggal_absen');

            // Kembalikan unique constraint lama
            $table->unique('pendaftaran_acara_id', 'presensi_pendaftaran_unique');
        });
    }
};
