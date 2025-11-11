<?php

namespace App\Http\Controllers;

use App\Helpers\StorageHelper;
use App\Models\PendaftaranAcara;
use Illuminate\Http\Request;

class EventParticipantController extends Controller
{
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
            $hariLabel = 'Hari-' . $hari_ke;
            $data[$hariLabel] = [];
            foreach ($uniqueSessions as $sesi) {
                $sesiLabel = 'Sesi-' . $sesi;
                $data[$hariLabel][$sesiLabel] = [];
                foreach ($allParticipants as $item) {
                    // Cari presensi peserta pada hari & sesi ini
                    $presensiPeserta = $presensi->first(function($p) use ($item, $date, $sesi) {
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
                        'nama' => $item->user->name ?? '-',
                        'email' => $item->user->email ?? '-',
                        'no_whatsapp' => $item->user->telp ?? '-',
                        'photo_profile' => StorageHelper::getStorageUrl($item->user->detailPeserta?->foto),
                        'type' => $type,
                        'status' => $status,
                        'hari_ke' => $hari_ke,
                        'sesi_acara' => $sesi,
                        'tanggal_sesi' => $date,
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
}
