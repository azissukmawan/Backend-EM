<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailAdmin extends Model
{
    use HasFactory;

    /**
     * The table associated with the model.
     *
     * @var string
     */
    protected $table = 'detail_admin';

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'user_id',
        'divisi_id',
    ];

    /**
     * Get the user that owns the detail admin.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the divisi that owns the detail admin.
     */
    public function divisi()
    {
        return $this->belongsTo(Divisi::class);
    }
}
