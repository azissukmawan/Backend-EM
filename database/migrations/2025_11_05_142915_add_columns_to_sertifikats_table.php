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
        Schema::table('sertifikats', function (Blueprint $table) {
            // Cek dan tambah kolom user_id
            if (!Schema::hasColumn('sertifikats', 'user_id')) {
                $table->unsignedBigInteger('user_id')->after('id')->nullable();
                $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            }

            // Cek dan tambah kolom modul_acara_id
            if (!Schema::hasColumn('sertifikats', 'modul_acara_id')) {
                $table->unsignedBigInteger('modul_acara_id')->after('user_id')->nullable();
                $table->foreign('modul_acara_id')->references('id')->on('modul_acara')->onDelete('cascade');
            }

            // Cek dan tambah kolom file_sertifikat
            if (!Schema::hasColumn('sertifikats', 'file_sertifikat')) {
                $table->string('file_sertifikat')->nullable()->after('tanggal_sertif');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('sertifikats', function (Blueprint $table) {
            if (Schema::hasColumn('sertifikats', 'user_id')) {
                $table->dropForeign(['user_id']);
                $table->dropColumn('user_id');
            }

            if (Schema::hasColumn('sertifikats', 'modul_acara_id')) {
                $table->dropForeign(['modul_acara_id']);
                $table->dropColumn('modul_acara_id');
            }

            if (Schema::hasColumn('sertifikats', 'file_sertifikat')) {
                $table->dropColumn('file_sertifikat');
            }
        });
    }
};
