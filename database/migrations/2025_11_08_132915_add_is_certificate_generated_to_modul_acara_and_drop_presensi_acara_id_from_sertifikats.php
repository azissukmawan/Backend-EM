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
        // Tambahkan kolom baru di modul_acara
        Schema::table('modul_acara', function (Blueprint $table) {
            $table->boolean('is_certificate_generated')->default(false)->after('mdl_status');
        });

        // Hapus kolom presensi_acara_id di sertifikats
        Schema::table('sertifikats', function (Blueprint $table) {
            if (Schema::hasColumn('sertifikats', 'presensi_acara_id')) {
                $table->dropForeign(['presensi_acara_id']); // hapus foreign key dulu
                $table->dropColumn('presensi_acara_id');    // baru hapus kolomnya
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Hapus kolom baru
        Schema::table('modul_acara', function (Blueprint $table) {
            $table->dropColumn('is_certificate_generated');
        });

        // Tambahkan kembali kolom presensi_acara_id seperti semula
        Schema::table('sertifikats', function (Blueprint $table) {
            if (!Schema::hasColumn('sertifikats', 'presensi_acara_id')) {
                $table->unsignedBigInteger('presensi_acara_id')->after('modul_acara_id')->nullable();
                $table->foreign('presensi_acara_id')->references('id')->on('presensi_acara')->onDelete('cascade');
            }
        });
    }
};
