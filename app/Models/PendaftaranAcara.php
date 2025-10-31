<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PendaftaranAcara extends Model
{
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
        return $this->belongsTo(User::class);
    }
}
