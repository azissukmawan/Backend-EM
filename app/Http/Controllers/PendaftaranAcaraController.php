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
        // Validasi tipe_kehadiran untuk acara hybrid
        $tipeKehadiran = null;
        if ($acara->mdl_tipe === 'hybrid') {
            $request->validate([
                'tipe_kehadiran' => 'required|in:online,offline',
            ]);
            $tipeKehadiran = $request->tipe_kehadiran;
        }

        // Simpan pendaftaran
        PendaftaranAcara::create([
            'modul_acara_id' => $acara->id,
            'user_id' => $user->id,
            'metode_daftar' => 'self',
            'no_sertifikat' => null,
            'tipe_kehadiran' => $tipeKehadiran,
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
                'presensi',
                'modulAcara:id,mdl_kode,mdl_slug,mdl_nama,mdl_kategori,mdl_tipe,mdl_lokasi,mdl_acara_mulai,mdl_acara_selesai,mdl_status,mdl_banner_acara,mdl_kode_qr,mdl_file_acara,mdl_file_rundown,mdl_template_sertifikat,mdl_link_wa,mdl_doorprize_aktif,mdl_sesi_acara',
            ])
            ->where('user_id', $user->id)
            ->orderByDesc('waktu_daftar')
            ->paginate($perPage);

        // Transform data untuk menambahkan URL lengkap pada media dan presensi per hari
        $pendaftaran->getCollection()->transform(function ($item) {
            if ($item->modulAcara) {
                // Tambahkan URL lengkap untuk media files
                $item->modulAcara->mdl_banner_acara_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_banner_acara);
                $item->modulAcara->mdl_file_acara_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_acara);
                $item->modulAcara->mdl_file_rundown_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_rundown);
                $item->modulAcara->mdl_template_sertifikat_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_template_sertifikat);

                // Hitung durasi event dalam hari
                $mulai = \Carbon\Carbon::parse($item->modulAcara->mdl_acara_mulai);
                $selesai = \Carbon\Carbon::parse($item->modulAcara->mdl_acara_selesai);
                $totalHari = $mulai->diffInDays($selesai) + 1;

                // Ambil total sesi dari mdl_sesi_acara, atau dari data presensi jika ada
                $totalSesiFromDB = (int) ($item->modulAcara->mdl_sesi_acara ?? 1);

                // Jika ada data presensi, hitung sesi maksimal dari presensi
                $maxSesiFromPresensi = 0;
                if ($item->presensi && $item->presensi->isNotEmpty()) {
                    foreach ($item->presensi as $p) {
                        if ($p->sesi_acara > $maxSesiFromPresensi) {
                            $maxSesiFromPresensi = $p->sesi_acara;
                        }
                    }
                }

                // Gunakan nilai terbesar antara DB dan presensi
                $totalSesi = max($totalSesiFromDB, $maxSesiFromPresensi);

                // Buat map presensi dari database untuk lookup cepat
                $presensiMap = [];
                if ($item->presensi && $item->presensi->isNotEmpty()) {
                    foreach ($item->presensi as $p) {
                        $tanggal = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                        $sesi = $p->sesi_acara;
                        $key = $tanggal . '_' . $sesi;
                        $presensiMap[$key] = $p;
                    }
                }

                // Build presensi dalam format Hari-X -> Sesi-X -> object peserta
                $presensiStruktur = [];
                $currentDate = $mulai->copy();

                for ($hariKe = 1; $hariKe <= $totalHari; $hariKe++) {
                    $tanggal = $currentDate->format('Y-m-d');
                    $hariKey = "Hari-" . $hariKe;
                    $presensiStruktur[$hariKey] = [];

                    // Loop semua sesi di hari ini
                    for ($sesiKe = 1; $sesiKe <= $totalSesi; $sesiKe++) {
                        $sesiKey = "Sesi-" . $sesiKe;
                        $key = $tanggal . '_' . $sesiKe;

                        // Data presensi peserta (sederhana untuk POV peserta)
                        $pesertaData = [
                            'hari_ke' => $hariKe,
                            'sesi_acara' => $sesiKe,
                        ];

                        if (isset($presensiMap[$key])) {
                            // Ada data presensi di database
                            $p = $presensiMap[$key];
                            $pesertaData['status'] = $p->status ?? 'Hadir';
                            $pesertaData['tanggal_sesi'] = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                        } else {
                            // Tidak ada data presensi
                            $pesertaData['status'] = 'Belum Hadir';
                            $pesertaData['tanggal_sesi'] = $tanggal;
                        }

                        $presensiStruktur[$hariKey][$sesiKey] = $pesertaData;
                    }

                    $currentDate->addDay();
                }

                // Tambahkan ke modulAcara
                $item->modulAcara->presensi_per_hari = $presensiStruktur;
                $item->modulAcara->total_hari = $totalHari;
                $item->modulAcara->total_sesi = $totalSesi; // Debug: tambahkan total_sesi
            }

            // Hapus relasi presensi yang lama (karena sudah di-transform)
            unset($item->presensi);

            return $item;
        });


        // Response rapi (tetap simpel)
        return response()->json([
            'success' => true,
            'message' => 'Daftar Acara Anda.',
            'data' => $pendaftaran,
        ]);
    }

    public function listSayaV2(Request $request)
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
                'presensi',
                'modulAcara:id,mdl_kode,mdl_slug,mdl_nama,mdl_kategori,mdl_tipe,mdl_lokasi,mdl_acara_mulai,mdl_acara_selesai,mdl_status,mdl_banner_acara,mdl_kode_qr,mdl_file_acara,mdl_file_rundown,mdl_template_sertifikat,mdl_link_wa,mdl_doorprize_aktif,mdl_sesi_acara',
            ])
            ->where('user_id', $user->id)
            ->orderByDesc('waktu_daftar')
            ->paginate($perPage);

        // Transform data untuk menambahkan URL lengkap pada media dan presensi per hari
        $pendaftaran->getCollection()->transform(function ($item) {
            if ($item->modulAcara) {
                // Tambahkan URL lengkap untuk media files
                $item->modulAcara->mdl_banner_acara_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_banner_acara);
                $item->modulAcara->mdl_file_acara_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_acara);
                $item->modulAcara->mdl_file_rundown_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_rundown);
                $item->modulAcara->mdl_template_sertifikat_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_template_sertifikat);

                // Hitung durasi event dalam hari
                $mulai = \Carbon\Carbon::parse($item->modulAcara->mdl_acara_mulai);
                $selesai = \Carbon\Carbon::parse($item->modulAcara->mdl_acara_selesai);
                $totalHari = $mulai->diffInDays($selesai) + 1;

                // Buat map presensi dari database untuk lookup cepat dan hitung sesi per hari
                $presensiMap = [];
                $sesiPerHari = []; // Array untuk menyimpan jumlah sesi per tanggal

                if ($item->presensi && $item->presensi->isNotEmpty()) {
                    foreach ($item->presensi as $p) {
                        $tanggal = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                        $sesi = $p->sesi_acara;
                        $key = $tanggal . '_' . $sesi;
                        $presensiMap[$key] = $p;

                        // Hitung sesi maksimal per hari dari presensi
                        if (!isset($sesiPerHari[$tanggal]) || $sesi > $sesiPerHari[$tanggal]) {
                            $sesiPerHari[$tanggal] = $sesi;
                        }
                    }
                }

                // Build presensi dalam format Hari-X -> Sesi-X -> object peserta
                $presensiStruktur = [];
                $currentDate = $mulai->copy();

                for ($hariKe = 1; $hariKe <= $totalHari; $hariKe++) {
                    $tanggal = $currentDate->format('Y-m-d');
                    $hariKey = "Hari-" . $hariKe;
                    $presensiStruktur[$hariKey] = [];

                    // Tentukan jumlah sesi untuk hari ini
                    // Ambil dari presensi terbanyak di hari ini, atau default dari DB
                    $totalSesiFromDB = (int) ($item->modulAcara->mdl_sesi_acara ?? 1);
                    $totalSesiHariIni = isset($sesiPerHari[$tanggal]) ? $sesiPerHari[$tanggal] : $totalSesiFromDB;

                    // Loop semua sesi di hari ini
                    for ($sesiKe = 1; $sesiKe <= $totalSesiHariIni; $sesiKe++) {
                        $sesiKey = "Sesi-" . $sesiKe;
                        $key = $tanggal . '_' . $sesiKe;

                        // Data presensi peserta (sederhana untuk POV peserta)
                        $pesertaData = [
                            'hari_ke' => $hariKe,
                            'sesi_acara' => $sesiKe,
                        ];

                        if (isset($presensiMap[$key])) {
                            // Ada data presensi di database
                            $p = $presensiMap[$key];
                            $pesertaData['status'] = $p->status ?? 'Hadir';
                            $pesertaData['tanggal_sesi'] = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                        } else {
                            // Tidak ada data presensi
                            $pesertaData['status'] = 'Belum Hadir';
                            $pesertaData['tanggal_sesi'] = $tanggal;
                        }

                        $presensiStruktur[$hariKey][$sesiKey] = $pesertaData;
                    }

                    $currentDate->addDay();
                }

                // Tambahkan ke modulAcara
                $item->modulAcara->presensi_per_hari = $presensiStruktur;
                $item->modulAcara->total_hari = $totalHari;
            }

            // Hapus relasi presensi yang lama (karena sudah di-transform)
            unset($item->presensi);

            return $item;
        });


        // Response rapi (tetap simpel)
        return response()->json([
            'success' => true,
            'message' => 'Daftar Acara Anda.',
            'data' => $pendaftaran,
        ]);
    }

    public function listSayaMobile(Request $request)
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
                'presensi',
                'modulAcara:id,mdl_kode,mdl_slug,mdl_nama,mdl_kategori,mdl_tipe,mdl_lokasi,mdl_acara_mulai,mdl_acara_selesai,mdl_status,mdl_banner_acara,mdl_kode_qr,mdl_file_acara,mdl_file_rundown,mdl_template_sertifikat,mdl_link_wa,mdl_doorprize_aktif,mdl_sesi_acara',
            ])
            ->where('user_id', $user->id)
            ->orderByDesc('waktu_daftar')
            ->paginate($perPage);

        // Transform data untuk menambahkan URL lengkap pada media dan presensi per hari
        $pendaftaran->getCollection()->transform(function ($item) {
            if ($item->modulAcara) {
                // Tambahkan URL lengkap untuk media files
                $item->modulAcara->mdl_banner_acara_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_banner_acara);
                $item->modulAcara->mdl_file_acara_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_acara);
                $item->modulAcara->mdl_file_rundown_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_file_rundown);
                $item->modulAcara->mdl_template_sertifikat_url  = StorageHelper::getStorageUrl($item->modulAcara->mdl_template_sertifikat);

                // Hitung durasi event dalam hari
                $mulai = \Carbon\Carbon::parse($item->modulAcara->mdl_acara_mulai);
                $selesai = \Carbon\Carbon::parse($item->modulAcara->mdl_acara_selesai);
                $totalHari = $mulai->diffInDays($selesai) + 1;

                // Ambil total sesi dari mdl_sesi_acara, atau dari data presensi jika ada
                $totalSesiFromDB = (int) ($item->modulAcara->mdl_sesi_acara ?? 1);

                // Jika ada data presensi, hitung sesi maksimal dari presensi
                $maxSesiFromPresensi = 0;
                if ($item->presensi && $item->presensi->isNotEmpty()) {
                    foreach ($item->presensi as $p) {
                        if ($p->sesi_acara > $maxSesiFromPresensi) {
                            $maxSesiFromPresensi = $p->sesi_acara;
                        }
                    }
                }

                // Gunakan nilai terbesar antara DB dan presensi
                $totalSesi = max($totalSesiFromDB, $maxSesiFromPresensi);

                // Buat map presensi dari database untuk lookup cepat
                $presensiMap = [];
                if ($item->presensi && $item->presensi->isNotEmpty()) {
                     foreach ($item->presensi as $p) {
                        $tanggal = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                        $sesi = $p->sesi_acara;
                        $key = $tanggal . '_' . $sesi;
                        $presensiMap[$key] = $p;
                    }
                }

                // Build presensi dalam format array of arrays
                $presensiArray = [];
                $currentDate = $mulai->copy();

                for ($hariKe = 1; $hariKe <= $totalHari; $hariKe++) {
                    $tanggal = $currentDate->format('Y-m-d');
                    $sesiPerHari = [];

                    // Loop semua sesi di hari ini
                    for ($sesiKe = 1; $sesiKe <= $totalSesi; $sesiKe++) {
                        $key = $tanggal . '_' . $sesiKe;

                        // Data presensi peserta (sederhana untuk POV peserta)
                        $pesertaData = [
                            'hari_ke' => $hariKe,
                            'sesi_acara' => $sesiKe,
                        ];

                        if (isset($presensiMap[$key])) {
                            // Ada data presensi di database
                            $p = $presensiMap[$key];
                            $pesertaData['status'] = $p->status ?? 'Hadir';
                            $pesertaData['tanggal_sesi'] = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                        } else {
                            // Tidak ada data presensi
                            $pesertaData['status'] = 'Belum Hadir';
                            $pesertaData['tanggal_sesi'] = $tanggal;
                        }

                        $sesiPerHari[] = $pesertaData;
                    }

                    $presensiArray[] = $sesiPerHari;
                    $currentDate->addDay();
                }

                // Tambahkan ke modulAcara
                $item->modulAcara->presensi = $presensiArray;
                $item->modulAcara->total_hari = $totalHari;
                $item->modulAcara->total_sesi = $totalSesi;
            }

            // Hapus relasi presensi yang lama (karena sudah di-transform)
            unset($item->presensi);

            return $item;
        });


        // Response rapi (tetap simpel)
        return response()->json([
            'success' => true,
            'message' => 'Daftar Acara Anda.',
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

        $event = PendaftaranAcara::query()
            ->with([
                // relasi event (acara)
                'presensi',
                'modulAcara:id,mdl_kode,mdl_slug,mdl_nama,mdl_kategori,mdl_tipe,mdl_lokasi,mdl_acara_mulai,mdl_acara_selesai,mdl_status,mdl_banner_acara,mdl_kode_qr,mdl_file_acara,mdl_file_rundown,mdl_template_sertifikat,mdl_link_wa,mdl_doorprize_aktif,mdl_sesi_acara',
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

        // Transform data untuk menambahkan URL lengkap pada media dan presensi per hari
        if ($event->modulAcara) {
            // Tambahkan URL lengkap untuk media files
            $event->modulAcara->mdl_banner_acara_url = StorageHelper::getStorageUrl($event->modulAcara->mdl_banner_acara);
            $event->modulAcara->mdl_file_acara_url = StorageHelper::getStorageUrl($event->modulAcara->mdl_file_acara);
            $event->modulAcara->mdl_file_rundown_url = StorageHelper::getStorageUrl($event->modulAcara->mdl_file_rundown);
            $event->modulAcara->mdl_template_sertifikat_url  = StorageHelper::getStorageUrl($event->modulAcara->mdl_template_sertifikat);

            // Hitung durasi event dalam hari
            $mulai = \Carbon\Carbon::parse($event->modulAcara->mdl_acara_mulai);
            $selesai = \Carbon\Carbon::parse($event->modulAcara->mdl_acara_selesai);
            $totalHari = $mulai->diffInDays($selesai) + 1;

            // Ambil total sesi dari mdl_sesi_acara, atau dari data presensi jika ada
            $totalSesiFromDB = (int) ($event->modulAcara->mdl_sesi_acara ?? 1);

            // Jika ada data presensi, hitung sesi maksimal dari presensi
            $maxSesiFromPresensi = 0;
            if ($event->presensi && $event->presensi->isNotEmpty()) {
                foreach ($event->presensi as $p) {
                    if ($p->sesi_acara > $maxSesiFromPresensi) {
                        $maxSesiFromPresensi = $p->sesi_acara;
                    }
                }
            }

            // Gunakan nilai terbesar antara DB dan presensi
            $totalSesi = max($totalSesiFromDB, $maxSesiFromPresensi);

            // Buat map presensi dari database untuk lookup cepat
            $presensiMap = [];
            if ($event->presensi && $event->presensi->isNotEmpty()) {
                foreach ($event->presensi as $p) {
                    $tanggal = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                    $sesi = $p->sesi_acara;
                    $key = $tanggal . '_' . $sesi;
                    $presensiMap[$key] = $p;
                }
            }

            // Build presensi dalam format Hari-X -> Sesi-X -> object peserta
            $presensiStruktur = [];
            $currentDate = $mulai->copy();

            for ($hariKe = 1; $hariKe <= $totalHari; $hariKe++) {
                $tanggal = $currentDate->format('Y-m-d');
                $hariKey = "Hari-" . $hariKe;
                $presensiStruktur[$hariKey] = [];

                // Loop semua sesi di hari ini
                for ($sesiKe = 1; $sesiKe <= $totalSesi; $sesiKe++) {
                    $sesiKey = "Sesi-" . $sesiKe;
                    $key = $tanggal . '_' . $sesiKe;

                    // Data presensi peserta (sederhana untuk POV peserta)
                    $pesertaData = [
                        'hari_ke' => $hariKe,
                        'sesi_acara' => $sesiKe,
                    ];

                    if (isset($presensiMap[$key])) {
                        // Ada data presensi di database
                        $p = $presensiMap[$key];
                        $pesertaData['status'] = $p->status ?? 'Hadir';
                        $pesertaData['tanggal_sesi'] = \Carbon\Carbon::parse($p->tanggal_absen)->format('Y-m-d');
                    } else {
                        // Tidak ada data presensi
                        $pesertaData['status'] = 'Belum Hadir';
                        $pesertaData['tanggal_sesi'] = $tanggal;
                    }

                    $presensiStruktur[$hariKey][$sesiKey] = $pesertaData;
                }

                $currentDate->addDay();
            }

            // Tambahkan ke modulAcara
            $event->modulAcara->presensi_per_hari = $presensiStruktur;
            $event->modulAcara->total_hari = $totalHari;
            $event->modulAcara->total_sesi = $totalSesi; // Debug: tambahkan total_sesi

            // Hide internal path fields dari response
            $event->modulAcara->makeHidden(['mdl_banner_acara', 'mdl_file_acara', 'mdl_file_rundown', 'mdl_template_sertifikat']);
        }

        // Hapus relasi presensi yang lama (karena sudah di-transform)
        unset($event->presensi);

        // Response rapi (tetap simpel)
        return response()->json([
            'success' => true,
            'message' => 'Detail Acara Anda.',
            'data' => $event,
        ]);
    }
}
