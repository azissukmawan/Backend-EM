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

            // Get registered event IDs for current user
            $registeredEventIds = [];
            if ($user) {
                $registeredEventIds = PendaftaranAcara::where('user_id', $user->id)
                    ->whereIn('modul_acara_id', collect($events->items())->pluck('id'))
                    ->pluck('modul_acara_id')
                    ->toArray();
            }

            // Transform data untuk menambahkan URL media
            $eventsWithMedia = collect($events->items())->map(function ($event) use ($registeredEventIds) {
                $eventArray = $event->toArray();

                // Hilangkan field yang tidak perlu
                unset($eventArray['mdl_banner_acara']);
                unset($eventArray['mdl_file_acara']);
                unset($eventArray['mdl_file_rundown']);
                unset($eventArray['mdl_template_sertifikat']);

                // Check if user is registered
                $isRegistered = in_array($event->id, $registeredEventIds);

                // Hanya tampilkan URL yang tidak kosong
                $mediaUrls = [];

                $bannerUrl = StorageHelper::getStorageUrl($event->mdl_banner_acara);
                if (!empty($bannerUrl)) {
                    $mediaUrls['banner'] = $bannerUrl;
                }

                // File acara dan rundown hanya untuk user yang sudah registrasi
                if ($isRegistered) {
                    $fileAcaraUrl = StorageHelper::getStorageUrl($event->mdl_file_acara);
                    if (!empty($fileAcaraUrl)) {
                        $mediaUrls['file_acara'] = $fileAcaraUrl;
                    }

                    $fileRundownUrl = StorageHelper::getStorageUrl($event->mdl_file_rundown);
                    if (!empty($fileRundownUrl)) {
                        $mediaUrls['file_rundown'] = $fileRundownUrl;
                    }
                }

                $eventArray['media_urls'] = $mediaUrls;
                return $eventArray;
            });

            return response()->json([
                'success' => true,
                'message' => 'Dashboard events retrieved successfully',
                'data' => [
                    'events' => $eventsWithMedia,
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
            $pendaftaran = null;
            $isRegistered = false;
            if ($user) {
                $pendaftaran = PendaftaranAcara::where('modul_acara_id', $event->id)
                    ->where('user_id', $user->id)
                    ->first();

                if ($pendaftaran) {
                    $isRegistered = true;
                }
            }

            // Tambahkan URL media yang bisa diakses publik
            $eventArray = $event->toArray();

            // Hilangkan field yang tidak perlu
            unset($eventArray['mdl_banner_acara']);
            unset($eventArray['mdl_file_acara']);
            unset($eventArray['mdl_file_rundown']);
            unset($eventArray['mdl_template_sertifikat']);

            $mediaUrls = [];

            // Banner selalu ditampilkan jika ada
            $bannerUrl = StorageHelper::getStorageUrl($event->mdl_banner_acara);
            if (!empty($bannerUrl)) {
                $mediaUrls['banner'] = $bannerUrl;
            }

            // File acara dan rundown hanya untuk user yang sudah registrasi
            if ($isRegistered) {
                $fileAcaraUrl = StorageHelper::getStorageUrl($event->mdl_file_acara);
                if (!empty($fileAcaraUrl)) {
                    $mediaUrls['file_acara'] = $fileAcaraUrl;
                }

                $fileRundownUrl = StorageHelper::getStorageUrl($event->mdl_file_rundown);
                if (!empty($fileRundownUrl)) {
                    $mediaUrls['file_rundown'] = $fileRundownUrl;
                }
            }

            $eventArray['media_urls'] = $mediaUrls;

            return response()->json([
                'success' => true,
                'message' => 'Event detail retrieved successfully',
                'data' => [
                    'event' => $eventArray,
                    'pendaftaran' => $pendaftaran
                ]
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve event detail',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
