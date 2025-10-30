<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PendaftaranAcara extends Model
{
    use HasFactory;

    protected $table = 'pendaftaran_acara';
    protected $guarded = [];

    public function event()
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
    }
}
