<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MasterNomorSertifikat extends Model
{
    //
     protected $table = 'master_nomor_sertifikat';
    protected $guarded = [];
    
    public function event()
    {
        return $this->belongsTo(ModulAcara::class, 'modul_acara_id');
    }
}
