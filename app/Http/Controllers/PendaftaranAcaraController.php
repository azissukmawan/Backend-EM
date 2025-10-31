<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use Illuminate\Http\Request;
use App\Models\DetailPeserta;
use App\Models\PendaftaranAcara;

class PendaftaranAcaraController extends Controller
{
    //
    /**
     * Peserta mendaftar ke acara tertentu.
     * Endpoint: POST /api/acara/{modul_acara_id}/daftar
     */
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

    /**
     * Peserta membatalkan pendaftaran acara.
     * Endpoint: DELETE /api/acara/{modul_acara_id}/batal-daftar
     */
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
}
