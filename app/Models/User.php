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
        'failed_login_attempts',
        'locked_until',
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
            'locked_until' => 'datetime',
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

    /**
     * Check if account is currently locked
     */
    public function isLocked()
    {
        return $this->locked_until && $this->locked_until->isFuture();
    }

    /**
     * Reset failed login attempts
     */
    public function resetFailedLoginAttempts()
    {
        $this->update([
            'failed_login_attempts' => 0,
            'locked_until' => null,
        ]);
    }

    /**
     * Increment failed login attempts and lock if necessary
     */
    public function incrementFailedLoginAttempts()
    {
        $this->increment('failed_login_attempts');
        $this->refresh(); // Reload data dari database untuk mendapatkan nilai terbaru

        // Lock account for 15 minutes after 5 failed attempts
        if ($this->failed_login_attempts >= 5) {
            $this->update([
                'locked_until' => now()->addMinutes(15),
            ]);
        }
    }
    public function pendaftarans()
    {
        return $this->hasMany(PendaftaranAcara::class, 'user_id');
    }
}
