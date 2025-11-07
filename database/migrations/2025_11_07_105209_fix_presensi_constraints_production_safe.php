<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Step 1: Tambahkan kolom tanggal_absen jika belum ada
        if (!Schema::hasColumn('presensi_acara', 'tanggal_absen')) {
            Schema::table('presensi_acara', function (Blueprint $table) {
                $table->date('tanggal_absen')->nullable()->after('waktu_absen');
            });

            // Isi tanggal_absen dari waktu_absen untuk data existing
            DB::statement('UPDATE presensi_acara SET tanggal_absen = DATE(waktu_absen) WHERE tanggal_absen IS NULL');

            // Set NOT NULL setelah data terisi
            Schema::table('presensi_acara', function (Blueprint $table) {
                $table->date('tanggal_absen')->nullable(false)->change();
            });
        }

        // Step 2: Cek dan hapus duplicate entries sebelum add unique constraint
        $this->removeDuplicateEntries();

        // Step 3: Drop foreign key yang menggunakan unique constraint
        $foreignKeys = DB::select(
            "SELECT CONSTRAINT_NAME
             FROM information_schema.KEY_COLUMN_USAGE
             WHERE TABLE_SCHEMA = DATABASE()
             AND TABLE_NAME = 'presensi_acara'
             AND COLUMN_NAME = 'pendaftaran_acara_id'
             AND REFERENCED_TABLE_NAME IS NOT NULL"
        );

        foreach ($foreignKeys as $fk) {
            try {
                DB::statement("ALTER TABLE presensi_acara DROP FOREIGN KEY {$fk->CONSTRAINT_NAME}");
            } catch (\Exception $e) {
                // Ignore if already dropped
            }
        }

        // Step 4: Drop index bermasalah
        $indexes = ['presensi_pendaftaran_unique', 'unique_attendance_per_day'];

        foreach ($indexes as $indexName) {
            try {
                $indexExists = DB::select(
                    "SHOW INDEX FROM presensi_acara WHERE Key_name = ?",
                    [$indexName]
                );

                if (!empty($indexExists)) {
                    DB::statement("ALTER TABLE presensi_acara DROP INDEX {$indexName}");
                }
            } catch (\Exception $e) {
                // Ignore if index doesn't exist
            }
        }

        // Step 5: Tambahkan unique constraint baru (per hari)
        try {
            $uniqueExists = DB::select(
                "SHOW INDEX FROM presensi_acara WHERE Key_name = 'unique_presensi_per_hari'"
            );

            if (empty($uniqueExists)) {
                DB::statement(
                    "ALTER TABLE presensi_acara
                     ADD UNIQUE KEY unique_presensi_per_hari (modul_acara_id, user_id, tanggal_absen)"
                );
            }
        } catch (\Exception $e) {
            // Jika gagal karena duplicate, hapus duplicate dulu
            $this->removeDuplicateEntries();
            DB::statement(
                "ALTER TABLE presensi_acara
                 ADD UNIQUE KEY unique_presensi_per_hari (modul_acara_id, user_id, tanggal_absen)"
            );
        }

        // Step 6: Recreate foreign key TANPA unique constraint
        try {
            DB::statement(
                "ALTER TABLE presensi_acara
                 ADD CONSTRAINT presensi_acara_pendaftaran_acara_id_foreign
                 FOREIGN KEY (pendaftaran_acara_id)
                 REFERENCES pendaftaran_acara(id)
                 ON DELETE CASCADE"
            );
        } catch (\Exception $e) {
            // Ignore if already exists
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Drop foreign key
        try {
            DB::statement("ALTER TABLE presensi_acara DROP FOREIGN KEY presensi_acara_pendaftaran_acara_id_foreign");
        } catch (\Exception $e) {
            // Ignore
        }

        // Drop unique constraint baru
        try {
            DB::statement("ALTER TABLE presensi_acara DROP INDEX unique_presensi_per_hari");
        } catch (\Exception $e) {
            // Ignore
        }

        // Recreate constraint lama
        try {
            DB::statement(
                "ALTER TABLE presensi_acara
                 ADD CONSTRAINT presensi_acara_pendaftaran_acara_id_foreign
                 UNIQUE KEY (pendaftaran_acara_id),
                 ADD FOREIGN KEY (pendaftaran_acara_id)
                 REFERENCES pendaftaran_acara(id)
                 ON DELETE CASCADE"
            );
        } catch (\Exception $e) {
            // Ignore
        }

        // Drop kolom tanggal_absen
        if (Schema::hasColumn('presensi_acara', 'tanggal_absen')) {
            Schema::table('presensi_acara', function (Blueprint $table) {
                $table->dropColumn('tanggal_absen');
            });
        }
    }

    /**
     * Remove duplicate entries before adding unique constraint
     */
    private function removeDuplicateEntries(): void
    {
        // Cari duplicate entries (same modul_acara_id, user_id, tanggal_absen)
        $duplicates = DB::select("
            SELECT modul_acara_id, user_id, tanggal_absen, COUNT(*) as count
            FROM presensi_acara
            GROUP BY modul_acara_id, user_id, tanggal_absen
            HAVING count > 1
        ");

        if (!empty($duplicates)) {
            echo "\nFound " . count($duplicates) . " duplicate entries. Removing...\n";

            // Untuk setiap duplicate, keep yang paling lama (id terkecil)
            foreach ($duplicates as $dup) {
                DB::statement("
                    DELETE t1 FROM presensi_acara t1
                    INNER JOIN presensi_acara t2
                    WHERE t1.id > t2.id
                    AND t1.modul_acara_id = ?
                    AND t1.user_id = ?
                    AND t1.tanggal_absen = ?
                ", [$dup->modul_acara_id, $dup->user_id, $dup->tanggal_absen]);
            }

            echo "Duplicates removed successfully\n";
        }
    }
};
