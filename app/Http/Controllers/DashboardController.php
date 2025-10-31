<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ModulAcara;
use App\Models\PendaftaranAcara;
use App\Helpers\StorageHelper;
use Carbon\Carbon;

class DashboardController extends Controller
{
    /**
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function index(Request $request)
    {
        try {
            $user = $request->user();

            // Query builder untuk modul acara
            $query = ModulAcara::query();

            // Filter berdasarkan status jika ada parameter
            if ($request->has('status') && in_array($request->status, ['draft', 'active', 'closed', 'archived'])) {
                $query->where('mdl_status', $request->status);
            }

            // Filter berdasarkan tipe acara (online, offline, hybrid)
            if ($request->has('tipe') && in_array($request->tipe, ['online', 'offline', 'hybrid'])) {
                $query->where('mdl_tipe', $request->tipe);
            }

            // Filter berdasarkan kategori (public, private, invite-only)
            if ($request->has('kategori') && in_array($request->kategori, ['public', 'private', 'invite-only'])) {
                $query->where('mdl_kategori', $request->kategori);
            }

            // Search berdasarkan nama acara
            if ($request->has('search') && !empty($request->search)) {
                $query->where('mdl_nama', 'like', '%' . $request->search . '%');
            }

            // Sorting - default terbaru
            $sortBy = $request->get('sort_by', 'mdl_acara_mulai');
            $sortOrder = $request->get('sort_order', 'desc');

            if (in_array($sortBy, ['mdl_acara_mulai', 'mdl_pendaftaran_mulai', 'created_at', 'mdl_nama'])) {
                $query->orderBy($sortBy, $sortOrder);
            } else {
                $query->orderBy('mdl_acara_mulai', 'desc');
            }

            // Pagination - 6 items per page
            $perPage = $request->get('per_page', 6);
            $events = $query->paginate($perPage);

            // Transform data untuk response
            $transformedData = collect($events->items())->map(function ($event) {
                return $this->transformEventData($event);
            });

            return response()->json([
                'success' => true,
                'message' => 'Dashboard events retrieved successfully',
                'data' => [
                    'events' => $transformedData,
                    'pagination' => [
                        'total' => $events->total(),
                        'per_page' => $events->perPage(),
                        'current_page' => $events->currentPage(),
                        'last_page' => $events->lastPage(),
                        'from' => $events->firstItem(),
                        'to' => $events->lastItem(),
                    ]
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve dashboard events',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * @param Request $request
     * @param string $identifier (can be ID or slug)
     * @return \Illuminate\Http\JsonResponse
     */
    public function show(Request $request, $identifier)
    {
        try {
            $user = $request->user();

            // Cari event berdasarkan ID atau slug
            $event = ModulAcara::where('id', $identifier)
                ->orWhere('mdl_slug', $identifier)
                ->first();

            if (!$event) {
                return response()->json([
                    'success' => false,
                    'message' => 'Event not found'
                ], 404);
            }

            // Jika user adalah peserta, cek apakah event active
            // if ($user->role === 'peserta' && $event->mdl_status !== 'active') {
            //     return response()->json([
            //         'success' => false,
            //         'message' => 'Event is not available'
            //     ], 403);
            // }

            // Load relationships
            $event->load(['user', 'creator']);

            // Cek apakah user sudah terdaftar
            $isRegistered = false;
            $registrationData = null;

            if ($user) {
                $pendaftaran = PendaftaranAcara::where('modul_acara_id', $event->id)
                    ->where('user_id', $user->id)
                    ->first();

                if ($pendaftaran) {
                    $isRegistered = true;
                    $registrationData = [
                        'metode_daftar' => $pendaftaran->metode_daftar,
                        'waktu_daftar' => Carbon::parse($pendaftaran->waktu_daftar)->format('d F Y, H:i') . ' WIB',
                        'no_sertifikat' => $pendaftaran->no_sertifikat,
                        'has_doorprize' => $pendaftaran->has_doorprize ?? false,
                    ];
                }
            }

            $eventDetail = $this->transformEventDetailData($event, $isRegistered, $registrationData);

            return response()->json([
                'success' => true,
                'message' => 'Event detail retrieved successfully',
                'data' => $eventDetail
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve event detail',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Transform event data for list view
     *
     * @param ModulAcara $event
     * @return array
     */
    private function transformEventData($event)
    {
        $now = Carbon::now();
        $eventStart = Carbon::parse($event->mdl_acara_mulai);
        $eventEnd = $event->mdl_acara_selesai ? Carbon::parse($event->mdl_acara_selesai) : null;
        $registrationEnd = Carbon::parse($event->mdl_pendaftaran_selesai);

        $eventTimeStatus = 'upcoming';
        if ($now->greaterThan($eventStart)) {
            if ($eventEnd && $now->lessThan($eventEnd)) {
                $eventTimeStatus = 'ongoing';
            } elseif ($eventEnd && $now->greaterThan($eventEnd)) {
                $eventTimeStatus = 'completed';
            }
        }

        // Registration status
        $registrationStatus = $now->lessThan($registrationEnd) ? 'open' : 'closed';

        return [
            'id' => $event->id,
            'kode' => $event->mdl_kode,
            'slug' => $event->mdl_slug,
            'nama' => $event->mdl_nama,
            'deskripsi' => substr($event->mdl_deskripsi, 0, 150) . (strlen($event->mdl_deskripsi) > 150 ? '...' : ''),
            'tipe' => $event->mdl_tipe,
            'status' => $event->mdl_status,
            'kategori' => $event->mdl_kategori,
            'lokasi' => $event->mdl_lokasi,
            'tanggal_mulai' => Carbon::parse($event->mdl_acara_mulai)->format('d F Y, H:i') . ' WIB',
            'tanggal_selesai' => $event->mdl_acara_selesai
                ? Carbon::parse($event->mdl_acara_selesai)->format('d F Y, H:i') . ' WIB'
                : null,
            'pendaftaran_selesai' => Carbon::parse($event->mdl_pendaftaran_selesai)->format('d F Y, H:i') . ' WIB',
            'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
            'event_time_status' => $eventTimeStatus,
            'registration_status' => $registrationStatus,
        ];
    }

    /**
     * Transform event data for detail view
     *
     * @param ModulAcara $event
     * @param bool $isRegistered
     * @param array|null $registrationData
     * @return array
     */
    private function transformEventDetailData($event, $isRegistered = false, $registrationData = null)
    {
        $now = Carbon::now();
        $eventStart = Carbon::parse($event->mdl_acara_mulai);
        $eventEnd = $event->mdl_acara_selesai ? Carbon::parse($event->mdl_acara_selesai) : null;
        $registrationStart = Carbon::parse($event->mdl_pendaftaran_mulai);
        $registrationEnd = Carbon::parse($event->mdl_pendaftaran_selesai);

        // Determine event time status
        $eventTimeStatus = 'upcoming';
        if ($now->greaterThan($eventStart)) {
            if ($eventEnd && $now->lessThan($eventEnd)) {
                $eventTimeStatus = 'ongoing';
            } elseif ($eventEnd && $now->greaterThan($eventEnd)) {
                $eventTimeStatus = 'completed';
            }
        }

        // Registration status
        $registrationStatus = 'closed';
        if ($now->greaterThanOrEqualTo($registrationStart) && $now->lessThan($registrationEnd)) {
            $registrationStatus = 'open';
        } elseif ($now->lessThan($registrationStart)) {
            $registrationStatus = 'upcoming';
        }

        $data = [
            'id' => $event->id,
            'kode' => $event->mdl_kode,
            'slug' => $event->mdl_slug,
            'nama' => $event->mdl_nama,
            'deskripsi' => $event->mdl_deskripsi,
            'tipe' => $event->mdl_tipe,
            'status' => $event->mdl_status,
            'kategori' => $event->mdl_kategori,

            // Informasi Lokasi
            'lokasi' => [
                'alamat' => $event->mdl_lokasi,
                'latitude' => $event->mdl_latitude,
                'longitude' => $event->mdl_longitude,
                'radius' => $event->mdl_radius,
            ],

            // Informasi Pendaftaran
            'pendaftaran' => [
                'mulai' => Carbon::parse($event->mdl_pendaftaran_mulai)->format('d F Y, H:i') . ' WIB',
                'selesai' => Carbon::parse($event->mdl_pendaftaran_selesai)->format('d F Y, H:i') . ' WIB',
                'maks_peserta_eksternal' => $event->mdl_maks_peserta_eksternal,
                'status' => $registrationStatus,
            ],

            // Informasi Acara
            'acara' => [
                'tanggal_mulai' => Carbon::parse($event->mdl_acara_mulai)->format('d F Y'),
                'tanggal_selesai' => $event->mdl_acara_selesai
                    ? Carbon::parse($event->mdl_acara_selesai)->format('d F Y')
                    : null,
                'jam_mulai' => Carbon::parse($event->mdl_acara_mulai)->format('H:i'),
                'jam_selesai' => $event->mdl_acara_selesai
                    ? Carbon::parse($event->mdl_acara_selesai)->format('H:i')
                    : null,
                'durasi' => $eventEnd
                    ? $eventStart->diffInMinutes($eventEnd) . ' menit'
                    : null,
            ],

            // Fitur
            'fitur' => [
                'sertifikat_aktif' => $event->mdl_sertifikat_aktif,
                'doorprize_aktif' => $event->mdl_doorprize_aktif,
            ],

            // Additional Info
            'catatan' => $event->mdl_catatan,
            'event_time_status' => $eventTimeStatus,

            // Organizer Info (if loaded)
            'organizer' => $event->user ? [
                'id' => $event->user->id,
                'name' => $event->user->name,
                'email' => $event->user->email,
            ] : null,

            // User Registration Status
            'is_registered' => $isRegistered,

            // Timestamps
            'created_at' => Carbon::parse($event->created_at)->format('d F Y, H:i') . ' WIB',
            'updated_at' => Carbon::parse($event->updated_at)->format('d F Y, H:i') . ' WIB',
        ];

        // Add registration info if user is registered
        if ($isRegistered && $registrationData) {
            $data['user_registration'] = $registrationData;
        }

        // Add media files only if user is registered
        if ($isRegistered) {
            $data['media'] = [
                'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
                'file_acara' => StorageHelper::getStorageUrl($event->mdl_file_acara),
                'file_rundown' => StorageHelper::getStorageUrl($event->mdl_file_rundown),
            ];
        } else {
            // Only show banner for non-registered users
            $data['media'] = [
                'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
            ];
        }

        return $data;
    }
}
