<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasApiTokens;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'username',
        'telp',
        'role',
        'email',
        'password',
        'email_verified_at',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function detailPeserta()
    {
        return $this->hasOne(DetailPeserta::class);
    }

    public function detailAdmin()
    {
        return $this->hasOne(DetailAdmin::class);
    }

    public function otps()
    {
        return $this->hasMany(Otp::class);
    }

    // public function acaraTerdaftar(){
    //     return $this->belongsToMany(ModulAcara::class, '');
    // }

    public function acaraTerdaftar(): BelongsToMany
    {
        return $this->belongsToMany(ModulAcara::class, 'pendaftaran_acara', 'user_id', 'modul_acara_id')
            ->withPivot(['metode_daftar', 'waktu_daftar'])
            ->withTimestamps();
    }

    public function acaraHadir(): BelongsToMany
    {
        return $this->belongsToMany(ModulAcara::class, 'presensi_acara', 'user_id', 'modul_acara_id')
            ->withPivot(['waktu_absen', 'latitude', 'longitude'])
            ->withTimestamps();
    }
}
