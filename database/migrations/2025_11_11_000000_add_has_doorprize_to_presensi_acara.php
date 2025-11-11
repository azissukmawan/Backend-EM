<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('presensi_acara', function (Blueprint $table) {
            if (!Schema::hasColumn('presensi_acara', 'has_doorprize')) {
                $table->boolean('has_doorprize')->default(false)->after('sesi_acara');
            }
        });
    }

    public function down(): void
    {
        Schema::table('presensi_acara', function (Blueprint $table) {
            if (Schema::hasColumn('presensi_acara', 'has_doorprize')) {
                $table->dropColumn('has_doorprize');
            }
        });
    }
};
