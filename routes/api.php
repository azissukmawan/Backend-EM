<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ModulAcaraController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\DashboardAdminController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\EventParticipantController;
use App\Http\Controllers\EventStatisticController;
use App\Http\Controllers\SertifikatController;
use App\Http\Controllers\DoorprizeController;
use App\Http\Controllers\PendaftaranAcaraController;
use App\Http\Controllers\PresensiController;
use App\Http\Controllers\ToggleQRController;


// Public routes - Landing Page Events
Route::get('/events', [EventController::class, 'index']); // Event yang SEDANG AKTIF
Route::get('/events/all', [EventController::class, 'all']); // SEMUA event (aktif, upcoming, past)
Route::get('/events/upcoming', [EventController::class, 'upcoming']); // Event AKAN DATANG
Route::get('/events/past', [EventController::class, 'past']); // Event SUDAH SELESAI
Route::get('/events/{identifier}', [EventController::class, 'show']); // Detail event by ID or slug
Route::get('/events/{id}/participants', [EventParticipantController::class, 'index']);

// Auth routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/verify-otp', [AuthController::class, 'verifyOtp']);
Route::post('/resend-otp', [AuthController::class, 'resendOtp']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);

// Auth routes - Register (rate limited)
Route::middleware('throttle:api')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
});

// Auth routes - Login (rate limited - 5 attempts per minute)
Route::middleware('throttle:login')->group(function () {
    Route::post('/login', [AuthController::class, 'login']);
});

// Auth routes - OTP (rate limited - 3 attempts per minute)
Route::middleware('throttle:otp')->group(function () {
    Route::post('/verify-otp', [AuthController::class, 'verifyOtp']);
    Route::post('/resend-otp', [AuthController::class, 'resendOtp']);
});

// Auth routes - Password Reset (rate limited - 3 attempts per 5 minutes)
Route::middleware('throttle:reset')->group(function () {
    Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
    Route::post('/reset-password', [AuthController::class, 'resetPassword']);
});

// Public routes - Dashboard Stats
Route::get('/dashboard-admin/stats', [DashboardAdminController::class, 'stats']);


// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
    // Admin routes for managing events
    Route::get('/admin/events', [ModulAcaraController::class, 'index']);
    Route::get('/admin/events/{id}', [ModulAcaraController::class, 'show']);
    // CRUD superadmin
    Route::post('/admin/events', [ModulAcaraController::class, 'store']);
    Route::put('/admin/events/{id}', [ModulAcaraController::class, 'update']);
    Route::delete('/admin/events/{id}', [ModulAcaraController::class, 'destroy']);

    // QR & Presensi (khusus superadmin)
    Route::get('/admin/events/{id}/qr', [ModulAcaraController::class, 'qr']);
    Route::patch('/admin/events/{id}/presensi', [ModulAcaraController::class, 'setPresensiAktif']);

    // Alternative routes (modul-acara)
    Route::get('/modul-acara', [ModulAcaraController::class, 'index']);
    Route::get('/modul-acara/{id}', [ModulAcaraController::class, 'show']);
    Route::post('/modul-acara', [ModulAcaraController::class, 'store']);
    Route::put('/modul-acara/{id}', [ModulAcaraController::class, 'update']);
    Route::delete('/modul-acara/{id}', [ModulAcaraController::class, 'destroy']);
    // Peserta routes atau GET biasa

    Route::prefix('profile')->group(function () {
        Route::get('/', [ProfileController::class, 'getProfile']);
        Route::post('/update', [ProfileController::class, 'updateProfile']);
        Route::post('/change-password', [ProfileController::class, 'changePassword']);

        Route::get('/dashboard', [DashboardController::class, 'index']);
        Route::get('/dashboard/events/{identifier}', [DashboardController::class, 'show']);
    });

    // Admin routes for managing events
    Route::get('/admin/events', [ModulAcaraController::class, 'index']);

    // Doorprize routes - Superadmin only
    Route::post('/admin/events/{eventId}/draw-winner', [DoorprizeController::class, 'drawWinner']);
    Route::get('/admin/events/{eventId}/winners', [DoorprizeController::class, 'getWinners']);

    // Admin routes for managing participant
    Route::get('/admin/events/{id}/participants', [EventParticipantController::class, 'index']);
    Route::get('/admin/events/{eventId}/stats', [EventStatisticController::class, 'show']);

    // Pendaftaran Acara
    Route::post('/events/{eventId}/daftar', [PendaftaranAcaraController::class, 'daftar']);
    Route::post('/events/{eventId}/daftar-invite', [PendaftaranAcaraController::class, 'daftarInvite']);
    Route::delete('/events/{eventId}/batal-daftar', [PendaftaranAcaraController::class, 'batalDaftar']);
    Route::get('/me/pendaftaran', [PendaftaranAcaraController::class, 'listSaya']);
    Route::get('events/{eventId}/me', [PendaftaranAcaraController::class, 'detailEventSaya']);
    Route::post('/sertifikat/generate', [SertifikatController::class, 'generate']);
});

// Presensi Acara routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/presensi', [PresensiController::class, 'store']);               // peserta absen
    Route::get('/acara/{id}/presensi', [PresensiController::class, 'index']);     // daftar presensi (panitia)
    Route::get('/acara/{id}/presensi/me', [PresensiController::class, 'me']);     // status user sendiri
    Route::get('/acara/{id}/qr-code', [PresensiController::class, 'showQr']);     // tampilkan QR event
    Route::post('/acara/{id}/presensi/reset', [PresensiController::class, 'reset']); // reset presensi
});

Route::middleware('auth:sanctum')->group(function () {
    Route::put('/admin/event/{id}/presensi/toggle', [ToggleQRController::class, 'toggle']);
});
