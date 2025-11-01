<?php


use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        // 1) Tambah kolom baru (nullable dulu)
        Schema::table('presensi_acara', function (Blueprint $table) {
            $table->unsignedBigInteger('pendaftaran_acara_id')->nullable()->after('id');
        });

        // 2) Backfill dari kombinasi (modul_acara_id, user_id)
        DB::statement("
            UPDATE presensi_acara pa
            JOIN pendaftaran_acara pda
              ON pa.modul_acara_id = pda.modul_acara_id
             AND pa.user_id       = pda.user_id
            SET pa.pendaftaran_acara_id = pda.id
        ");

        // (opsional tapi disarankan) cek duplikasi sebelum pasang unique:
        // SELECT pda.id, COUNT(*) c FROM presensi_acara pa
        // JOIN pendaftaran_acara pda ON pa.modul_acara_id=pda.modul_acara_id AND pa.user_id=pda.user_id
        // GROUP BY pda.id HAVING c>1;

        // 3) Pasang FK + unique
        Schema::table('presensi_acara', function (Blueprint $table) {
            $table->foreign('pendaftaran_acara_id')
                ->references('id')->on('pendaftaran_acara')
                ->cascadeOnDelete();

            // Satu presensi per pendaftaran
            $table->unique('pendaftaran_acara_id', 'presensi_pendaftaran_unique');
        });

        // 4) (opsional) ubah menjadi NOT NULL tanpa install doctrine/dbal
        DB::statement("
            ALTER TABLE presensi_acara
            MODIFY COLUMN pendaftaran_acara_id BIGINT UNSIGNED NOT NULL
        ");

        // 5) (opsional) lepas unique lama berdasarkan (modul_acara_id,user_id)
        // ganti nama index sesuai yang ada di DB-mu
        // Schema::table('presensi_acara', function (Blueprint $table) {
        //     $table->dropUnique('presensi_acara_modul_acara_id_user_id_unique');
        // });
    }

    public function down(): void
    {
        Schema::table('presensi_acara', function (Blueprint $table) {
            $table->dropForeign(['pendaftaran_acara_id']);
            $table->dropUnique('presensi_pendaftaran_unique');
            $table->dropColumn('pendaftaran_acara_id');
        });
    }
};
