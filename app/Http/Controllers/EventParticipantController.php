<?php

namespace App\Http\Controllers;

use App\Helpers\StorageHelper;
use App\Models\PendaftaranAcara;
use Illuminate\Http\Request;

class EventParticipantController extends Controller
{
    /**
     * Menampilkan daftar peserta per acara (default: semua data, bisa pagination via request)
     */
    public function index(Request $request, $eventId)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $query = PendaftaranAcara::with([
            'user.detailPeserta',
            'modulAcara',
            'presensi' => function ($q) use ($eventId) {
                $q->where('modul_acara_id', $eventId);
            }
        ])->where('modul_acara_id', $eventId);

        // Jika user mengirim parameter per_page -> pakai pagination
        if ($request->has('per_page')) {
            $participants = $query->paginate($request->get('per_page', 10));
        } else {
            // Jika tidak, ambil semua data
            $participants = $query->get();
        }

        // Format respons
        $data = $participants->map(function ($item) {
            return [
                'id' => $item->id,
                'nama' => $item->user->name ?? '-',
                'email' => $item->user->email ?? '-',
                'no_whatsapp' => $item->user->telp ?? '-',
                'photo_profile' => StorageHelper::getStorageUrl($item->user->detailPeserta?->foto),
                'type' => $item->modulAcara->mdl_tipe ?? '-',
                'status' =>  $item->presensi->status ?? 'Belum Hadir',
                'doorprize' => (bool) $item->has_doorprize,
            ];
        });

        // Response untuk data dengan atau tanpa pagination
        $response = [
            'success' => true,
            'data' => $data,
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
