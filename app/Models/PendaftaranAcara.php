<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PendaftaranAcara extends Model
{
    use HasFactory;

    protected $guarded = [];

    //
    protected $table = 'pendaftaran_acara';
    protected $fillable = [
        'modul_acara_id',
        'user_id',
        'metode_daftar',
        'has_doorprize',
        'no_sertifikat',
    ];

    public function modulAcara()
    {
        return $this->belongsTo(ModulAcara::class, 'modul_acara_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function presensi()
    {
        return $this->hasOne(PresensiAcara::class, 'user_id', 'user_id');
        return $this->belongsTo(User::class);
    }
}
