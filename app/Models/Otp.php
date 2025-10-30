<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Otp extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'code',
        'expires_at',
        'verified_at',
    ];

    protected $casts = [
        'expires_at' => 'datetime',
        'verified_at' => 'datetime',
    ];

    /**
     * Relasi ke User
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Cek apakah OTP sudah kadaluarsa
     */
    public function isExpired()
    {
        return $this->expires_at->isPast();
    }

    /**
     * Cek apakah OTP sudah diverifikasi
     */
    public function isVerified()
    {
        return !is_null($this->verified_at);
    }
}
