<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PendaftaranAcara extends Model
{
    use HasFactory;

    protected $table = 'pendaftaran_acarhttps://github.com/Event-Management-airnav/Backend-EM/pull/49/conflict?name=database%252Fseeders%252FPendaftaranAcaraSeeder.php&base_oid=d380e5fb5c8f2d82ef7c42733ff58da4fba1b38d&head_oid=8648bb4f9eccbe9744e33406d423a597fd0e584ea';
    protected $guarded = [];

    public function event()
    //
    protected $table = 'pendaftaran_acara'
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
