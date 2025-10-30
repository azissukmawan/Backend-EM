<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PresensiAcara extends Model
{
    use HasFactory;

    protected $table = 'presensi_acara';
    protected $guarded = [];

    public function event()
    {
        return $this->belongsTo(ModulAcara::class, 'modul_acara_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
}
