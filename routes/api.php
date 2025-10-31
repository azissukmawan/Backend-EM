<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ModulAcaraController;
use App\Http\Controllers\EventController;
use App\Http\Controllers\DashboardAdminController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\DoorprizeController;
use App\Http\Controllers\PendaftaranAcaraController;

// Public routes - Landing Page Events
Route::get('/events', [EventController::class, 'index']); // Event yang SEDANG AKTIF
Route::get('/events/all', [EventController::class, 'all']); // SEMUA event (aktif, upcoming, past)
Route::get('/events/upcoming', [EventController::class, 'upcoming']); // Event AKAN DATANG
Route::get('/events/past', [EventController::class, 'past']); // Event SUDAH SELESAI
Route::get('/events/{identifier}', [EventController::class, 'show']); // Detail event by ID or slug

// Auth routes
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/verify-otp', [AuthController::class, 'verifyOtp']);
Route::post('/resend-otp', [AuthController::class, 'resendOtp']);
Route::post('/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/reset-password', [AuthController::class, 'resetPassword']);
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
    // CRUD superadmin
    Route::post('/admin/events', [ModulAcaraController::class, 'store']);
    Route::put('/admin/events/{id}', [ModulAcaraController::class, 'update']);
    Route::delete('/admin/events/{id}', [ModulAcaraController::class, 'destroy']);
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

    Route::get('/events', [ModulAcaraController::class, 'index']);


    // Pendaftaran Acara
    Route::post('/events/{eventId}/daftar', [PendaftaranAcaraController::class, 'daftar']);
    Route::post('/events/{eventId}/daftar-invite', [PendaftaranAcaraController::class, 'daftarInvite']);
    Route::delete('/events/{eventId}/batal-daftar', [PendaftaranAcaraController::class, 'batalDaftar']);
});
