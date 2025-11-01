<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sertifikat extends Model
{
    public $timestamps = false;
    
    protected $fillable = [
        'name_peserta',
        'kode_sertif',
        'tanggal_sertif',
    ];
    
}
