<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sertifikat extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'user_id',
        'modul_acara_id',
        'presensi_acara_id',
        'name_peserta',
        'kode_sertif',
        'tanggal_sertif',
        'file_sertifikat', // Path file sertifikat yang sudah di-generate
    ];

    // Relasi ke User
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Relasi ke ModulAcara
    public function event()
    {
        return $this->belongsTo(ModulAcara::class, 'modul_acara_id');
    }
}
