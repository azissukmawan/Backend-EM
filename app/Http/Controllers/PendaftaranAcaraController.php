<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use Illuminate\Http\Request;
use App\Models\DetailPeserta;
use App\Models\PendaftaranAcara;
use App\Helpers\StorageHelper;

class PendaftaranAcaraController extends Controller
{

    public function daftar(Request $request, $modul_acara_id)
    {
        $user = auth()->user();

        if ($user->role !== 'peserta') {
            return response()->json([
                'success' => false,
                'message' => 'Akses ditolak. Hanya peserta yang dapat mendaftar acara.',
            ], 403);
        }
        // Ambil data acara
        $acara = ModulAcara::find($modul_acara_id);
        if (!$acara) {
            return response()->json([
                'success' => false,
                'message' => 'Acara tidak ditemukan.',
            ], 404);
        }

        // Cek status event aktif
        if ($acara->mdl_status !== 'active') {
            return response()->json([
                'success' => false,
                'message' => 'Acara tidak aktif atau belum dibuka.',
            ], 400);
        }

        $now = now();
        if ($now->lt($acara->mdl_pendaftaran_mulai)) {
            return response()->json([
                'success' => false,
                'message' => 'Pendaftaran belum dibuka.',
            ], 400);
        }
        if ($now->gt($acara->mdl_pendaftaran_selesai)) {
            return response()->json([
                'success' => false,
                'message' => 'Pendaftaran sudah ditutup.',
            ], 400);
        }

        // Cek apakah sudah terdaftar
        $sudah = PendaftaranAcara::where('modul_acara_id', $acara->id)
            ->where('user_id', $user->id)
            ->exists();

        if ($sudah) {
            return response()->json([
                'success' => false,
                'message' => 'Anda sudah terdaftar pada acara ini.',
            ], 400);
        }

        // Ambil detail peserta
        $detail = DetailPeserta::where('user_id', $user->id)->first();

        // Jika acara invite-only
        if ($acara->mdl_kategori === 'invite-only') {
            return response()->json([
                'success' => false,
                'message' => 'Acara bersifat undangan saja. Anda tidak dapat mendaftar sendiri.',
            ], 403);
        }

        // Jika acara private → hanya karyawan boleh
        if ($acara->mdl_kategori === 'private') {
            if (!$detail || !$detail->status_karyawan) {
                return response()->json([
                    'success' => false,
                    'message' => 'Acara ini hanya untuk karyawan.',
                ], 403);
            }
        }

        // Jika acara public → cek batas peserta eksternal
        if ($acara->mdl_kategori === 'public') {
            $isEksternal = !$detail || !$detail->status_karyawan;

            if ($isEksternal && $acara->mdl_maks_peserta_eksternal) {
                $totalEksternal = PendaftaranAcara::where('modul_acara_id', $acara->id)
                    ->whereHas('user.detailPeserta', function ($q) {
                        $q->where('status_karyawan', false);
                    })
                    ->count();

                if ($totalEksternal >= $acara->mdl_maks_peserta_eksternal) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Kuota peserta eksternal sudah penuh.',
                    ], 403);
                }
            }
        }

        // Simpan pendaftaran
        PendaftaranAcara::create([
            'modul_acara_id' => $acara->id,
            'user_id' => $user->id,
            'metode_daftar' => 'self',
            'no_sertifikat' => null,
            'waktu_daftar' => now(),
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Pendaftaran acara berhasil.',
        ]);
    }


    public function daftarInvite(Request $request, $modul_acara_id)
    {
        $admin = auth()->user();

        // Pastikan hanya superadmin yang bisa
        if ($admin->role !== 'superadmin') {
            return response()->json([
                'success' => false,
                'message' => 'Akses ditolak. Hanya superadmin yang dapat mengundang peserta.',
            ], 403);
        }

        // Validasi request
        $data = $request->validate([
            'user_ids' => 'required|array|min:1',
            'user_ids.*' => 'integer|exists:users,id',
        ]);

        $acara = ModulAcara::find($modul_acara_id);
        if (!$acara) {
            return response()->json([
                'success' => false,
                'message' => 'Acara tidak ditemukan.',
            ], 404);
        }

        $berhasil = [];
        $gagal = [];

        foreach ($data['user_ids'] as $userId) {
            // Cek apakah user sudah terdaftar di event ini
            $sudah = PendaftaranAcara::where('modul_acara_id', $acara->id)
                ->where('user_id', $userId)
                ->exists();

            if ($sudah) {
                $gagal[] = [
                    'user_id' => $userId,
                    'alasan' => 'Sudah terdaftar sebelumnya (self/invite).',
                ];
                continue;
            }

            // Simpan pendaftaran via invite
            PendaftaranAcara::create([
                'modul_acara_id' => $acara->id,
                'user_id' => $userId,
                'metode_daftar' => 'invite',
                'waktu_daftar' => now(),
            ]);

            $berhasil[] = ['user_id' => $userId];
        }

        return response()->json([
            'success' => true,
            'message' => 'Proses undangan selesai.',
            'total_diproses' => count($data['user_ids']),
            'berhasil' => $berhasil,
            'gagal' => $gagal,
        ]);
    }


    public function batalDaftar(Request $request, $modul_acara_id)
    {
        $user = auth()->user();

        // Cek acara ada
        $acara = ModulAcara::find($modul_acara_id);
        if (!$acara) {
            return response()->json([
                'success' => false,
                'message' => 'Acara tidak ditemukan.',
            ], 404);
        }

        // Cari pendaftaran user
        $pendaftaran = PendaftaranAcara::where('modul_acara_id', $acara->id)
            ->where('user_id', $user->id)
            ->first();

        // Belum terdaftar
        if (!$pendaftaran) {
            return response()->json([
                'success' => false,
                'message' => 'Anda belum terdaftar pada acara ini.',
            ], 400);
        }

        // Kalau pendaftarannya dari undangan (invite), tolak
        if ($pendaftaran->metode_daftar === 'invite') {
            return response()->json([
                'success' => false,
                'message' => 'Anda tidak dapat membatalkan undangan acara. Hubungi admin.',
            ], 403);
        }

        // Jika acara sudah dimulai, tidak bisa batal
        if (now()->gte($acara->mdl_acara_mulai)) {
            return response()->json([
                'success' => false,
                'message' => 'Acara sudah dimulai, tidak dapat membatalkan pendaftaran.',
            ], 400);
        }

        // Hapus pendaftaran
        $pendaftaran->delete();

        return response()->json([
            'success' => true,
            'message' => 'Pendaftaran Anda telah dibatalkan.',
        ]);
    }

    public function listSaya(Request $request)
    {
        $user = auth()->user();

        if ($user->role !== 'peserta') {
            return response()->json([
                'success' => false,
                'message' => 'Akses ditolak. Hanya peserta yang dapat melihat daftar pendaftarannya.',
            ], 403);
        }

        // Query param opsional: ?per_page=10
        $perPage = (int) $request->query('per_page', 10);

        $pendaftaran = PendaftaranAcara::query()
            ->with([
                // relasi event (acara)
                'modulAcara:id,mdl_kode,mdl_slug,mdl_nama,mdl_kategori,mdl_tipe,mdl_lokasi,mdl_acara_mulai,mdl_acara_selesai,mdl_status,mdl_banner_acara,mdl_kode_qr,mdl_file_acara,mdl_file_rundown,mdl_template_sertifikat',
                // relasi profil user (ringan)
                // 'user:id,name,username,telp',

            ])
            ->where('user_id', $user->id)
            ->orderByDesc('waktu_daftar')
            ->paginate($perPage);

        // Transform data untuk menambahkan URL lengkap pada media
        $pendaftaran->getCollection()->transform(function ($item) {
            if ($item->modulAcara) {
                // Tambahkan URL lengkap untuk media files
                $item->modulAcara->mdl_banner_acara_url = StorageHelper::getStorageUrl($item->modulAcara->mdl_banner_acara);
                $item->modulAcara->mdl_file_acara_url = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_acara);
                $item->modulAcara->mdl_file_rundown_url = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_rundown);

                // Hide internal path fields dari response
                $item->modulAcara->makeHidden(['mdl_banner_acara', 'mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat']);
            }
            return $item;
        });

        // Response rapi (tetap simpel)
        return response()->json([
            'success' => true,
            'message' => 'Daftar Event Anda.',
            'data' => $pendaftaran,
        ]);
    }

    public function detailEventSaya(Request $request, $eventid)
    {
        $user = auth()->user();

        if ($user->role !== 'peserta') {
            return response()->json([
                'success' => false,
                'message' => 'Akses ditolak. Hanya peserta yang dapat melihat daftar pendaftarannya.',
            ], 403);
        }

        // Query param opsional: ?per_page=10
        $perPage = (int) $request->query('per_page', 10);

        $event = PendaftaranAcara::query()
            ->with([
                // relasi event (acara)
                'modulAcara',
                // relasi profil user (ringan)


            ])
            ->where('user_id', $user->id)
            ->where('modul_acara_id', $eventid)
            ->first();

        if (!$event) {
            return response()->json([
                'success' => false,
                'message' => 'Detail Acara tidak ditemukan.',
            ], 404);
        }

        // Transform data untuk menambahkan URL lengkap pada media
        if ($event->modulAcara) {
            // Tambahkan URL lengkap untuk media files
            $event->modulAcara->mdl_banner_acara_url = StorageHelper::getStorageUrl($event->modulAcara->mdl_banner_acara);
            $event->modulAcara->mdl_file_acara_url = StorageHelper::getStorageUrl($event->modulAcara->mdl_file_acara);
            $event->modulAcara->mdl_file_rundown_url = StorageHelper::getStorageUrl($event->modulAcara->mdl_file_rundown);

            // Hide internal path fields dari response
            $event->modulAcara->makeHidden(['mdl_banner_acara', 'mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat']);
        }

        // Response rapi (tetap simpel)
        return response()->json([
            'success' => true,
            'message' => 'Detail Event Anda.',
            'data' => $event,
        ]);
    }
}
