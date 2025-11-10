<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('modul_acara', function (Blueprint $table) {
            $table->integer('mdl_sesi_acara')->default(1)->after('mdl_presensi_aktif');
        });

        Schema::table('presensi_acara', function (Blueprint $table) {
            $table->integer('sesi_acara')->nullable()->after('tanggal_absen');
        });
    }

    public function down(): void
    {
        Schema::table('modul_acara', function (Blueprint $table) {
            $table->dropColumn('mdl_sesi_acara');
        });

        Schema::table('presensi_acara', function (Blueprint $table) {
            $table->dropColumn('sesi_acara');
        });
    }
};
