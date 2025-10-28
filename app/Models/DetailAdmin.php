<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetailAdmin extends Model
{
    //
    protected $table = 'detail_admin';
    protected $fillable = [
        'user_id',
        'divisi_id',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function divisi()
    {
        return $this->belongsTo(Divisi::class);
    }
}
