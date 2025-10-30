<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetailPeserta extends Model
{
    //
    protected $table = 'detail_peserta';

    protected $fillable = [
        'user_id',
        'foto',
        'status_karyawan',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
