<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ModulAcara extends Model
{
    use HasFactory, SoftDeletes;

    // Nama tabel
    protected $table = 'modul_acara';

    // Primary key
    protected $primaryKey = 'id';

    // Kolom yang boleh diisi (mass assignable)
    protected $fillable = [
        'user_id',
        'mdl_kode',
        'mdl_slug',
        'mdl_nama',
        'mdl_deskripsi',
        'mdl_kategori_acara',
        'mdl_tipe',
        'mdl_lokasi',
        'mdl_latitude',
        'mdl_longitude',
        'mdl_radius',
        'mdl_pendaftaran_mulai',
        'mdl_pendaftaran_selesai',
        'mdl_maks_peserta_eksternal',
        'mdl_acara_mulai',
        'mdl_acara_selesai',
        'mdl_status',
        'mdl_file_acara',
        'mdl_file_rundown',
        'mdl_template_sertifikat',
        'mdl_sertifikat_aktif',
        'mdl_doorprize_aktif',
        'mdl_banner_acara',
        'mdl_catatan',
        'created_by',
        'updated_by',
    ];

    // Relasi ke user pembuat acara
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    // Relasi ke user yang membuat (admin)
    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    // Relasi ke user yang terakhir mengubah
    public function updater()
    {
        return $this->belongsTo(User::class, 'updated_by');
    }

    // Accessor untuk format tanggal lebih rapi
    public function getTanggalAcaraAttribute()
    {
        return $this->mdl_acara_mulai
            ? date('d M Y H:i', strtotime($this->mdl_acara_mulai))
            : null;
    }

    // Scope untuk acara aktif
    public function scopeAktif($query)
    {
        return $query->where('mdl_status', 'active');
    }

    // Scope untuk publik
    public function scopePublik($query)
    {
        return $query->where('mdl_kategori', 'public');
    }
}
