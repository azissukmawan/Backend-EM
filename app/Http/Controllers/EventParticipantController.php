<?php

namespace App\Http\Controllers;

use App\Helpers\StorageHelper;
use App\Models\PendaftaranAcara;
use Illuminate\Http\Request;

class EventParticipantController extends Controller
{

    public function listParticipants(Request $request, $eventId)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $query = PendaftaranAcara::with([
            'user.detailPeserta',
            'modulAcara',
        ])->where('modul_acara_id', $eventId);

        // Pagination opsional
        if ($request->has('per_page')) {
            $participants = $query->paginate($request->get('per_page', 10));
        } else {
            $participants = $query->get();
        }

        // Transformasi data peserta saja (tanpa status kehadiran)
        $data = [];
        foreach ($participants as $item) {
            $data[] = [
                'id' => $item->id,
                'nama' => $item->user->name ?? '-',
                'email' => $item->user->email ?? '-',
                'no_whatsapp' => $item->user->telp ?? '-',
                'photo_profile' => StorageHelper::getStorageUrl($item->user->detailPeserta?->foto),
                'type' => $item->modulAcara ? ($item->modulAcara->mdl_tipe === 'hybrid' ? $item->tipe_kehadiran : $item->modulAcara->mdl_tipe) : '-',
                'doorprize' => (bool) $item->has_doorprize,
            ];
        }

        // Response dengan atau tanpa pagination
        $response = [
            'success' => true,
            'data' => $data,
        ];
        if ($participants instanceof \Illuminate\Pagination\LengthAwarePaginator) {
            $response['meta'] = [
                'current_page' => $participants->currentPage(),
                'last_page' => $participants->lastPage(),
                'total' => $participants->total(),
                'per_page' => $participants->perPage(),
            ];
        }

        return response()->json($response);
    }

    public function index(Request $request, $eventId)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $query = PendaftaranAcara::with([
            'user.detailPeserta',
            'modulAcara',
            'presensi' => function ($q) use ($eventId, $request) {
                $q->where('modul_acara_id', $eventId);
                if ($request->filled('tanggal')) {
                    $q->whereDate('tanggal_absen', $request->get('tanggal'));
                }
                if ($request->filled('sesi')) {
                    $q->where('sesi_acara', $request->get('sesi'));
                }
            }
        ])->where('modul_acara_id', $eventId);

        // Jika user mengirim parameter per_page -> pakai pagination
        if ($request->has('per_page')) {
            $participants = $query->paginate($request->get('per_page', 10));
        } else {
            // Jika tidak, ambil semua data
            $participants = $query->get();
        }

        // Ambil semua presensi pada event ini
        $presensi = \App\Models\PresensiAcara::where('modul_acara_id', $eventId)->get();

        // Ambil semua tanggal_absen unik dan sesi unik, urutkan
        $allDates = [];
        $allSessions = [];
        foreach ($presensi as $p) {
            if ($p->tanggal_absen) {
                $dateStr = is_object($p->tanggal_absen) ? $p->tanggal_absen->format('Y-m-d') : (string) $p->tanggal_absen;
                $allDates[] = $dateStr;
            }
            if ($p->sesi_acara) {
                $allSessions[] = $p->sesi_acara;
            }
        }
        $uniqueDates = array_values(array_unique($allDates));
        sort($uniqueDates);
        $uniqueSessions = array_values(array_unique($allSessions));
        sort($uniqueSessions);

        // Map tanggal_absen ke hari ke-n
        $dateToDay = [];
        foreach ($uniqueDates as $idx => $date) {
            $dateToDay[$date] = $idx + 1;
        }

        // Ambil semua peserta terdaftar
        $allParticipants = $participants;

        // Buat struktur data: hari -> sesi -> peserta[]
        $data = [];
        foreach ($uniqueDates as $date) {
            $hari_ke = $dateToDay[$date];
            $tanggalSesi = $date;
            $hariLabel = 'Hari-' . $hari_ke;
            $data[$hariLabel] = [];
            foreach ($uniqueSessions as $sesi) {
                $sesiLabel = 'Sesi-' . $sesi;
                $data[$hariLabel][$sesiLabel] = [];
                foreach ($allParticipants as $item) {
                    // Cari presensi peserta pada hari & sesi ini
                    $presensiPeserta = $presensi->first(function ($p) use ($item, $date, $sesi) {
                        return $p->pendaftaran_acara_id == $item->id &&
                            ((is_object($p->tanggal_absen) ? $p->tanggal_absen->format('Y-m-d') : (string)$p->tanggal_absen) === $date) &&
                            $p->sesi_acara == $sesi;
                    });
                    $type = '-';
                    if ($item->modulAcara) {
                        if ($item->modulAcara->mdl_tipe === 'hybrid') {
                            $type = $item->tipe_kehadiran ?? null;
                        } else {
                            $type = $item->modulAcara->mdl_tipe;
                        }
                    }
                    $status = $presensiPeserta ? ($presensiPeserta->status ?? 'Hadir') : 'Belum Hadir';
                    $data[$hariLabel][$sesiLabel][] = [
                        'id' => $item->id,
                        'user_id' => $item->user->id ?? '-',
                        'nama' => $item->user->name ?? '-',
                        'email' => $item->user->email ?? '-',
                        'no_whatsapp' => $item->user->telp ?? '-',
                        'photo_profile' => StorageHelper::getStorageUrl($item->user->detailPeserta?->foto),
                        'type' => $type,
                        'status' => $status,
                        'tanggal_sesi' => $tanggalSesi,
                        'hari_ke' => $hari_ke,
                        'sesi_acara' => $sesi,
                        'doorprize' => (bool) $item->has_doorprize,
                    ];
                }
            }
        }

        // Response untuk data dengan atau tanpa pagination
        $response = [
            'success' => true,
            'data' => $data,
            'meta' => [
                'unique_dates' => $uniqueDates,
                'unique_sessions' => $uniqueSessions,
            ]
        ];

        // Tambahkan meta hanya jika pagination aktif
        if ($participants instanceof \Illuminate\Pagination\LengthAwarePaginator) {
            $response['meta'] = [
                'current_page' => $participants->currentPage(),
                'last_page' => $participants->lastPage(),
                'total' => $participants->total(),
                'per_page' => $participants->perPage(),
            ];
        }

        return response()->json($response);
    }

     public function indexV2(Request $request, $eventId)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $query = PendaftaranAcara::with([
            'user.detailPeserta',
            'modulAcara',
            'presensi' => function ($q) use ($eventId, $request) {
                $q->where('modul_acara_id', $eventId);
                if ($request->filled('tanggal')) {
                    $q->whereDate('tanggal_absen', $request->get('tanggal'));
                }
                if ($request->filled('sesi')) {
                    $q->where('sesi_acara', $request->get('sesi'));
                }
            }
        ])->where('modul_acara_id', $eventId);

        // Jika user mengirim parameter per_page -> pakai pagination
        if ($request->has('per_page')) {
            $participants = $query->paginate($request->get('per_page', 10));
        } else {
            // Jika tidak, ambil semua data
            $participants = $query->get();
        }

        // Ambil semua presensi pada event ini
        $presensi = \App\Models\PresensiAcara::where('modul_acara_id', $eventId)->get();

        // Ambil semua tanggal_absen unik, urutkan
        $allDates = [];
        foreach ($presensi as $p) {
            if ($p->tanggal_absen) {
                $dateStr = is_object($p->tanggal_absen) ? $p->tanggal_absen->format('Y-m-d') : (string) $p->tanggal_absen;
                $allDates[] = $dateStr;
            }
        }
        $uniqueDates = array_values(array_unique($allDates));
        sort($uniqueDates);

        // Hitung sesi maksimal per hari dari presensi (sama seperti listSayaV2)
        $sesiPerHari = [];
        foreach ($presensi as $p) {
            if ($p->tanggal_absen && $p->sesi_acara) {
                $dateStr = is_object($p->tanggal_absen) ? $p->tanggal_absen->format('Y-m-d') : (string) $p->tanggal_absen;
                $sesi = $p->sesi_acara;
                
                // Hitung sesi maksimal per hari
                if (!isset($sesiPerHari[$dateStr]) || $sesi > $sesiPerHari[$dateStr]) {
                    $sesiPerHari[$dateStr] = $sesi;
                }
            }
        }

        // Map tanggal_absen ke hari ke-n
        $dateToDay = [];
        foreach ($uniqueDates as $idx => $date) {
            $dateToDay[$date] = $idx + 1;
        }

        // Ambil semua peserta terdaftar
        $allParticipants = $participants;

        // Buat struktur data: hari -> sesi -> peserta[]
        $data = [];
        foreach ($uniqueDates as $date) {
            $hari_ke = $dateToDay[$date];
            $tanggalSesi = $date;
            $hariLabel = 'Hari-' . $hari_ke;
            $data[$hariLabel] = [];
            
            // Ambil jumlah sesi untuk hari ini berdasarkan presensi terbanyak di hari tersebut
            $totalSesiHariIni = isset($sesiPerHari[$date]) ? $sesiPerHari[$date] : 1;
            
            // Loop sesi dari 1 sampai total sesi di hari ini
            for ($sesi = 1; $sesi <= $totalSesiHariIni; $sesi++) {
                $sesiLabel = 'Sesi-' . $sesi;
                $data[$hariLabel][$sesiLabel] = [];
                
                foreach ($allParticipants as $item) {
                    // Cari presensi peserta pada hari & sesi ini
                    $presensiPeserta = $presensi->first(function ($p) use ($item, $date, $sesi) {
                        return $p->pendaftaran_acara_id == $item->id &&
                            ((is_object($p->tanggal_absen) ? $p->tanggal_absen->format('Y-m-d') : (string)$p->tanggal_absen) === $date) &&
                            $p->sesi_acara == $sesi;
                    });
                    $type = '-';
                    if ($item->modulAcara) {
                        if ($item->modulAcara->mdl_tipe === 'hybrid') {
                            $type = $item->tipe_kehadiran ?? null;
                        } else {
                            $type = $item->modulAcara->mdl_tipe;
                        }
                    }
                    $status = $presensiPeserta ? ($presensiPeserta->status ?? 'Hadir') : 'Belum Hadir';
                    $data[$hariLabel][$sesiLabel][] = [
                        'id' => $item->id,
                        'user_id' => $item->user->id ?? '-',
                        'nama' => $item->user->name ?? '-',
                        'email' => $item->user->email ?? '-',
                        'no_whatsapp' => $item->user->telp ?? '-',
                        'photo_profile' => StorageHelper::getStorageUrl($item->user->detailPeserta?->foto),
                        'type' => $type,
                        'status' => $status,
                        'tanggal_sesi' => $tanggalSesi,
                        'hari_ke' => $hari_ke,
                        'sesi_acara' => $sesi,
                        'doorprize' => (bool) $item->has_doorprize,
                    ];
                }
            }
        }

        // Response untuk data dengan atau tanpa pagination
        $response = [
            'success' => true,
            'data' => $data,
            'meta' => [
                'unique_dates' => $uniqueDates,
                'sesi_per_hari' => $sesiPerHari, // Tambahkan info sesi per hari
            ]
        ];

        // Tambahkan meta hanya jika pagination aktif
        if ($participants instanceof \Illuminate\Pagination\LengthAwarePaginator) {
            $response['meta'] = [
                'current_page' => $participants->currentPage(),
                'last_page' => $participants->lastPage(),
                'total' => $participants->total(),
                'per_page' => $participants->perPage(),
            ];
        }

        return response()->json($response);
    }
}
