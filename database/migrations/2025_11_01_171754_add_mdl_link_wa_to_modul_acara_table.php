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
        Schema::table('modul_acara', function (Blueprint $table) {
            $table->string('mdl_link_wa', 255)
                ->nullable()
                ->after('mdl_kode_qr');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('modul_acara', function (Blueprint $table) {
            $table->dropColumn('mdl_link_wa');
        });
    }
};
