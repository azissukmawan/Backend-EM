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
use App\Http\Controllers\ManageUsersController;


// Public routes - Landing Page Events
Route::get('/events', [EventController::class, 'index']); // Event yang SEDANG AKTIF
Route::get('/events/all', [EventController::class, 'all']); // SEMUA event (aktif, upcoming, past)
Route::get('/events/upcoming', [EventController::class, 'upcoming']); // Event AKAN DATANG
Route::get('/events/past', [EventController::class, 'past']); // Event SUDAH SELESAI
Route::get('/events/{identifier}', [EventController::class, 'show']); // Detail event by ID or slug
Route::get('/events/{identifier}/mobile', [EventController::class, 'showMobile']); // Detail event by ID or slug
Route::get('/events/{id}/participants', [EventParticipantController::class, 'index']);

// Auth routes
// Auth routes - Register (rate limited)
Route::middleware('throttle:api')->group(function () {
    Route::post('/register', [AuthController::class, 'register']);
});

// Auth routes - Login (rate limited - 5 attempts per minute)
Route::middleware('throttle:login')->group(function () {
    Route::post('/login', [AuthController::class, 'login']);
});
Route::post('/verify-otp', [AuthController::class, 'verifyOtp']);
Route::post('/resend-otp', [AuthController::class, 'resendOtp']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);



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



// Protected routes - General (untuk semua authenticated users)
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});

// Admin routes - Hanya untuk admin/superadmin/panitia
Route::middleware(['auth:sanctum', 'admin'])->group(function () {
    // Admin routes for managing events
    Route::get('/admin/events', [ModulAcaraController::class, 'index']);
    Route::get('/admin/events/{id}', [ModulAcaraController::class, 'show']);
    Route::post('/admin/events', [ModulAcaraController::class, 'store']);
    Route::put('/admin/events/{id}', [ModulAcaraController::class, 'update']);
    Route::delete('/admin/events/{id}', [ModulAcaraController::class, 'destroy']);

    // Admin routes - manage users
    Route::get('/admin/users', [ManageUsersController::class, 'index']);
    Route::delete('/admin/users/{id}', [ManageUsersController::class, 'destroy']);

    // QR & Presensi
    Route::get('/admin/events/{id}/qr', [ModulAcaraController::class, 'qr']);
    Route::patch('/admin/events/{id}/presensi', [ModulAcaraController::class, 'setPresensiAktif']);
    Route::put('/admin/event/{id}/presensi/toggle', [ToggleQRController::class, 'toggle']);



    // Doorprize routes
    Route::post('/admin/events/{eventId}/draw-winner', [DoorprizeController::class, 'drawWinner']);
    Route::get('/admin/events/{eventId}/winners', [DoorprizeController::class, 'getWinners']);
    Route::put('/admin/events/{eventId}/winners/{userId}', [DoorprizeController::class, 'deleteWinner']);

    // Admin routes for managing participant & stats
    Route::get('/admin/events/{id}/participants', [EventParticipantController::class, 'index']);
    Route::get('/admin/events/{eventId}/stats', [EventStatisticController::class, 'show']);
    Route::get('/dashboard-admin/stats', [DashboardAdminController::class, 'stats']);

    Route::post('/events/{eventId}/daftar-invite', [PendaftaranAcaraController::class, 'daftarInvite']);
});

Route::middleware(['auth:sanctum', 'peserta'])->group(function () {

    // Profile routes - Untuk semua user
    Route::prefix('profile')->group(function () {
        Route::get('/', [ProfileController::class, 'getProfile']);
        Route::post('/update', [ProfileController::class, 'updateProfile']);
        Route::post('/change-password', [ProfileController::class, 'changePassword']);

        Route::get('/dashboard', [DashboardController::class, 'index']);
        Route::get('/dashboard/events/{identifier}', [DashboardController::class, 'show']);
    });

    // Pendaftaran Acara - Untuk peserta
    Route::post('/events/{eventId}/daftar', [PendaftaranAcaraController::class, 'daftar']);
    Route::delete('/events/{eventId}/batal-daftar', [PendaftaranAcaraController::class, 'batalDaftar']);
    Route::get('/me/pendaftaran', [PendaftaranAcaraController::class, 'listSaya']);
    Route::get('events/{eventId}/me', [PendaftaranAcaraController::class, 'detailEventSaya']);

    // Sertifikat routes
    Route::post('/sertifikat/generate', [SertifikatController::class, 'generate']);
    Route::get('/sertifikat/acara/{idAcara}/download', [SertifikatController::class, 'download']);
    Route::get('/sertifikat/me', [SertifikatController::class, 'mySertifikat']);

    // Presensi Acara routes
    Route::post('/presensi', [PresensiController::class, 'store']);               // peserta absen
    Route::get('/acara/{id}/presensi', [PresensiController::class, 'index']);     // daftar presensi
    Route::get('/acara/{id}/presensi/me', [PresensiController::class, 'me']);     // status user sendiri
    Route::get('/acara/{id}/qr-code', [PresensiController::class, 'showQr']);     // tampilkan QR event
    Route::post('/acara/{id}/presensi/reset', [PresensiController::class, 'reset']); // reset presensi
});
