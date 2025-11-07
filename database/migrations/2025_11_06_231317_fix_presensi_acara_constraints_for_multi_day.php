<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Cek dan drop constraint lama yang membatasi satu presensi per pendaftaran
        try {
            DB::statement('ALTER TABLE presensi_acara DROP INDEX presensi_pendaftaran_unique');
        } catch (\Exception $e) {
            // Index mungkin sudah tidak ada, skip
        }

        // 2. Tambahkan kolom tanggal_absen jika belum ada
        if (!Schema::hasColumn('presensi_acara', 'tanggal_absen')) {
            Schema::table('presensi_acara', function (Blueprint $table) {
                $table->date('tanggal_absen')->after('waktu_absen')->nullable();
            });
        }

        // 3. Update data existing: set tanggal_absen dari waktu_absen
        DB::statement('UPDATE presensi_acara SET tanggal_absen = DATE(waktu_absen) WHERE tanggal_absen IS NULL');

        // 4. Cek dan buat unique constraint baru jika belum ada
        try {
            DB::statement('
                ALTER TABLE presensi_acara
                ADD UNIQUE INDEX unique_presensi_per_hari (modul_acara_id, user_id, tanggal_absen)
            ');
        } catch (\Exception $e) {
            // Index mungkin sudah ada, skip
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Drop constraint baru
        try {
            DB::statement('ALTER TABLE presensi_acara DROP INDEX unique_presensi_per_hari');
        } catch (\Exception $e) {
            // Index mungkin sudah tidak ada, skip
        }

        // Hapus kolom tanggal_absen
        if (Schema::hasColumn('presensi_acara', 'tanggal_absen')) {
            Schema::table('presensi_acara', function (Blueprint $table) {
                $table->dropColumn('tanggal_absen');
            });
        }

        // Kembalikan unique constraint lama
        try {
            DB::statement('
                ALTER TABLE presensi_acara
                ADD UNIQUE INDEX presensi_pendaftaran_unique (pendaftaran_acara_id)
            ');
        } catch (\Exception $e) {
            // Index mungkin sudah ada, skip
        }
    }
};
