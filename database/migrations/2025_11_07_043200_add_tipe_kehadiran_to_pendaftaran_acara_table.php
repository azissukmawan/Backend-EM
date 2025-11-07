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
        Schema::table('pendaftaran_acara', function (Blueprint $table) {
            $table->enum('tipe_kehadiran', ['online', 'offline'])->nullable()->after('has_doorprize');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('pendaftaran_acara', function (Blueprint $table) {
            $table->dropColumn('tipe_kehadiran');
        });
    }
};