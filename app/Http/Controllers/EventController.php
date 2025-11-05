<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use Illuminate\Http\Request;
use Carbon\Carbon;
use App\Helpers\StorageHelper;

class EventController extends Controller
{
    /**
     * GET /api/events
     * Landing Page - Semua event yang AKTIF (sedang berlangsung)
     * Filter: mdl_kategori = 'public', status = active, acara sedang berlangsung (tanggal acara <= hari ini)
     */
    public function index()
    {
        try {
            $now = Carbon::now();

            $events = ModulAcara::whereIn('mdl_kategori', ['public', 'private'])
                ->where('mdl_status', 'active')
                ->where('mdl_acara_mulai', '<=', $now)
                ->where(function ($query) use ($now) {
                    $query->whereNull('mdl_acara_selesai')
                        ->orWhere('mdl_acara_selesai', '>=', $now);
                })
                ->orderBy('mdl_acara_mulai', 'desc')
                ->get()
                ->map(function ($event) {
                    $eventArray = $event->toArray();

                    // Remove sensitive internal fields
                    // unset($eventArray['user_id']);
                    // unset($eventArray['mdl_banner_acara']);
                    // unset($eventArray['mdl_file_acara']);
                    // unset($eventArray['mdl_file_rundown']);
                    // unset($eventArray['mdl_template_sertifikat']);
                    // unset($eventArray['mdl_kode_qr']);
                    // unset($eventArray['mdl_presensi_aktif']);
                    // unset($eventArray['mdl_link_wa']);
                    // unset($eventArray['mdl_sertifikat_aktif']);
                    // unset($eventArray['mdl_doorprize_aktif']);

                    $eventArray['mdl_file_acara'] = StorageHelper::getStorageUrl($event->mdl_file_acara);
                    $eventArray['mdl_banner_acara'] = StorageHelper::getStorageUrl($event->mdl_banner_acara);
                    $eventArray['mdl_file_rundown'] = StorageHelper::getStorageUrl($event->mdl_file_rundown);
                    $eventArray['mdl_template_sertifikat'] = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);
                    // Add media URLs
                    $eventArray['media_urls'] = [
                        'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
                    ];

                    return $eventArray;
                });

            return response()->json([
                'success' => true,
                'message' => 'Active events retrieved successfully',
                'data' => [
                    'events' => $events,
                    'total' => $events->count(),
                    'description' => 'Event yang sedang aktif/berlangsung saat ini'
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve events',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }

    /**
     * GET /api/events/upcoming
     * Event yang AKAN DATANG (belum dimulai)
     * Filter: mdl_kategori = 'public', status = active, acara_mulai > sekarang
     */
    public function upcoming()
    {
        try {
            $now = Carbon::now();

            $events = ModulAcara::whereIn('mdl_kategori', ['public', 'private'])
                ->where('mdl_status', 'active')
                ->where('mdl_acara_mulai', '>', $now)
                ->orderBy('mdl_acara_mulai', 'asc')
                ->get()
                ->map(function ($event) {
                    $eventArray = $event->toArray();

                    // Remove sensitive internal fields
                    // unset($eventArray['user_id']);
                    // unset($eventArray['mdl_banner_acara']);
                    // unset($eventArray['mdl_file_acara']);
                    // unset($eventArray['mdl_file_rundown']);
                    // unset($eventArray['mdl_template_sertifikat']);
                    // unset($eventArray['mdl_kode_qr']);
                    // unset($eventArray['mdl_presensi_aktif']);
                    // unset($eventArray['mdl_link_wa']);
                    // unset($eventArray['mdl_sertifikat_aktif']);
                    // unset($eventArray['mdl_doorprize_aktif']);

                    $eventArray['mdl_file_acara'] = StorageHelper::getStorageUrl($event->mdl_file_acara);
                    $eventArray['mdl_banner_acara'] = StorageHelper::getStorageUrl($event->mdl_banner_acara);
                    $eventArray['mdl_file_rundown'] = StorageHelper::getStorageUrl($event->mdl_file_rundown);
                    $eventArray['mdl_template_sertifikat'] = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);
                    // Add media URLs
                    $eventArray['media_urls'] = [
                        'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
                    ];

                    return $eventArray;
                });

            return response()->json([
                'success' => true,
                'message' => 'Upcoming events retrieved successfully',
                'data' => [
                    'events' => $events,
                    'total' => $events->count(),
                    'description' => 'Event yang akan datang (belum dimulai)'
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve upcoming events',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }

    /**
     * GET /api/events/past
     * Event yang SUDAH SELESAI (masa lalu)
     * Filter: mdl_kategori = 'public', acara_selesai < sekarang OR (acara_mulai < sekarang AND acara_selesai is null and past 1 day)
     */
    public function past()
    {
        try {
            $now = Carbon::now();

            $events = ModulAcara::whereIn('mdl_kategori', ['public', 'private'])
                ->where(function ($query) use ($now) {
                    // Event yang punya tanggal selesai dan sudah lewat
                    $query->where('mdl_acara_selesai', '<', $now)
                        // ATAU event yang mulai > 1 hari lalu tapi tidak ada tanggal selesai
                        ->orWhere(function ($q) use ($now) {
                            $q->whereNull('mdl_acara_selesai')
                                ->where('mdl_acara_mulai', '<', $now->copy()->subDay());
                        });
                })
                ->orderBy('mdl_acara_mulai', 'desc')
                ->get()
                ->map(function ($event) {
                    $eventArray = $event->toArray();

                    // Remove sensitive internal fields
                    // unset($eventArray['user_id']);
                    // unset($eventArray['mdl_banner_acara']);
                    // unset($eventArray['mdl_file_acara']);
                    // unset($eventArray['mdl_file_rundown']);
                    // unset($eventArray['mdl_template_sertifikat']);
                    // unset($eventArray['mdl_kode_qr']);
                    // unset($eventArray['mdl_presensi_aktif']);
                    // unset($eventArray['mdl_link_wa']);
                    // unset($eventArray['mdl_sertifikat_aktif']);
                    // unset($eventArray['mdl_doorprize_aktif']);

                    $eventArray['mdl_file_acara'] = StorageHelper::getStorageUrl($event->mdl_file_acara);
                    $eventArray['mdl_banner_acara'] = StorageHelper::getStorageUrl($event->mdl_banner_acara);
                    $eventArray['mdl_file_rundown'] = StorageHelper::getStorageUrl($event->mdl_file_rundown);
                    $eventArray['mdl_template_sertifikat'] = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);
                    // Add media URLs
                    $eventArray['media_urls'] = [
                        'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
                    ];

                    return $eventArray;
                });

            return response()->json([
                'success' => true,
                'message' => 'Past events retrieved successfully',
                'data' => [
                    'events' => $events,
                    'total' => $events->count(),
                    'description' => 'Event yang sudah selesai'
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve past events',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }

    /**
     * GET /api/events/all
     * SEMUA event public (tanpa filter status & tanggal)
     * Filter: mdl_kategori = 'public' saja
     */
    public function all()
    {
        try {
            $events = ModulAcara::whereIn('mdl_kategori', ['public', 'private'])
                ->orderBy('mdl_acara_mulai', 'desc')
                ->get()
                ->map(function ($event) {
                    $eventArray = $event->toArray();

                    // Remove sensitive internal fields
                    // unset($eventArray['user_id']);
                    // unset($eventArray['mdl_banner_acara']);
                    // unset($eventArray['mdl_file_acara']);
                    // unset($eventArray['mdl_file_rundown']);
                    // unset($eventArray['mdl_template_sertifikat']);
                    // unset($eventArray['mdl_kode_qr']);
                    // unset($eventArray['mdl_presensi_aktif']);
                    // unset($eventArray['mdl_link_wa']);
                    // unset($eventArray['mdl_sertifikat_aktif']);
                    // unset($eventArray['mdl_doorprize_aktif']);

                    $eventArray['mdl_file_acara'] = StorageHelper::getStorageUrl($event->mdl_file_acara);
                    $eventArray['mdl_banner_acara'] = StorageHelper::getStorageUrl($event->mdl_banner_acara);
                    $eventArray['mdl_file_rundown'] = StorageHelper::getStorageUrl($event->mdl_file_rundown);
                    $eventArray['mdl_template_sertifikat'] = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);

                    // Add media URLs
                    $eventArray['media_urls'] = [
                        'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
                    ];

                    return $eventArray;
                });

            return response()->json([
                'success' => true,
                'message' => 'All events retrieved successfully',
                'data' => [
                    'events' => $events,
                    'total' => $events->count(),
                    'description' => 'Semua event public (tanpa filter status)'
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve all events',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }

    /**
     * GET /api/events/{id} atau /api/events/{slug}
     * Detail event lengkap
     */
    public function show($identifier)
    {
        try {
            // Cari berdasarkan ID atau slug
            $event = ModulAcara::whereIn('mdl_kategori', ['public', 'private'])
                ->where(function ($query) use ($identifier) {
                    $query->where('id', $identifier)
                        ->orWhere('mdl_slug', $identifier);
                })
                ->first();
            //s
            if (!$event) {
                return response()->json([
                    'success' => false,
                    'message' => 'Event not found'
                ], 404);
            }

            $now = Carbon::now();
            $startDate = Carbon::parse($event->mdl_acara_mulai);
            $endDate = $event->mdl_acara_selesai ? Carbon::parse($event->mdl_acara_selesai) : null;

            // Tentukan status acara
            if ($startDate->isFuture()) {
                $statusAcara = 'Akan Datang';
            } elseif ($endDate && $endDate->isPast()) {
                $statusAcara = 'Selesai';
            } elseif ($endDate && $startDate->isPast() && $endDate->isFuture()) {
                $statusAcara = 'Sedang Berlangsung';
            } else {
                $statusAcara = $startDate->diffInDays($now) > 1 ? 'Selesai' : 'Sedang Berlangsung';
            }

            // Format response detail
            $eventDetail = [
                'id' => $event->id,
                'kode' => $event->mdl_kode,
                'slug' => $event->mdl_slug,
                'nama' => $event->mdl_nama,
                'deskripsi' => $event->mdl_deskripsi,
                'mdl_kode_qr' => $event->mdl_kode_qr,
                'mdl_presensi_aktif' => $event->mdl_presensi_aktif,
                'mdl_file_acara' => StorageHelper::getStorageUrl($event->mdl_file_acara),
                'mdl_file_rundown' => StorageHelper::getStorageUrl($event->mdl_file_rundown),
                'mdl_template_sertifikat' => StorageHelper::getStorageUrl($event->mdl_template_sertifikat),
                'mdl_link_wa' => $event->mdl_link_wa,
                'mdl_kategori' => ucfirst($event->mdl_kategori),
                'tipe' => ucfirst($event->mdl_tipe),
                'status_acara' => $statusAcara,
                'lokasi' => $event->mdl_lokasi,
                'latitude' => $event->mdl_latitude,
                'longitude' => $event->mdl_longitude,
                'radius' => $event->mdl_radius,
                'pendaftaran' => [
                    'mulai' => Carbon::parse($event->mdl_pendaftaran_mulai)->format('d M Y, H:i'),
                    'selesai' => Carbon::parse($event->mdl_pendaftaran_selesai)->format('d M Y, H:i'),
                    'mulai_raw' => $event->mdl_pendaftaran_mulai,
                    'selesai_raw' => $event->mdl_pendaftaran_selesai,
                    'is_open' => Carbon::now()->between(
                        Carbon::parse($event->mdl_pendaftaran_mulai),
                        Carbon::parse($event->mdl_pendaftaran_selesai)
                    )
                ],
                'acara' => [
                    'mulai' => $startDate->format('d M Y, H:i'),
                    'selesai' => $endDate ? $endDate->format('d M Y, H:i') : null,
                    'mulai_raw' => $event->mdl_acara_mulai,
                    'selesai_raw' => $event->mdl_acara_selesai,
                ],
                'kapasitas' => [
                    'offline' => $event->mdl_maks_peserta_offline,
                    'online' => $event->mdl_maks_peserta_online,
                ],
                'status' => $event->mdl_status,
                'sertifikat_aktif' => $event->mdl_sertifikat_aktif,
                'doorprize_aktif' => $event->mdl_doorprize_aktif,
                'banner' => StorageHelper::getStorageUrl($event->mdl_banner_acara),
                'catatan' => $event->mdl_catatan,
                'created_at' => Carbon::parse($event->created_at)->format('d M Y, H:i'),
            ];

            return response()->json([
                'success' => true,
                'message' => 'Event detail retrieved successfully',
                'data' => [
                    'event' => $eventDetail
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve event detail',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }
    public function showMobile($identifier)
    {
        try {
            // Cari berdasarkan ID atau slug
            $event = ModulAcara::whereIn('mdl_kategori', ['public', 'private'])
                ->where(function ($query) use ($identifier) {
                    $query->where('id', $identifier)
                        ->orWhere('mdl_slug', $identifier);
                })
                ->first();
            //s
            if (!$event) {
                return response()->json([
                    'success' => false,
                    'message' => 'Event not found'
                ], 404);
            }

            $event->mdl_file_acara = StorageHelper::getStorageUrl($event->mdl_file_acara);
            $event->mdl_banner_acara = StorageHelper::getStorageUrl($event->mdl_banner_acara);
            $event->mdl_file_rundown = StorageHelper::getStorageUrl($event->mdl_file_rundown);
            $event->mdl_template_sertifikat = StorageHelper::getStorageUrl($event->mdl_template_sertifikat);

            return response()->json([
                'success' => true,
                'message' => 'Event detail retrieved successfully',
                'data' => $event
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve event detail',
                'error' => config('app.debug') ? $e->getMessage() : null
            ], 500);
        }
    }
}
