<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ModulAcaraController;
use App\Http\Controllers\EventController;

// Public routes - Landing Page Events
Route::get('/events', [EventController::class, 'index']); // Event yang SEDANG AKTIF
Route::get('/events/all', [EventController::class, 'all']); // SEMUA event (aktif, upcoming, past)
Route::get('/events/upcoming', [EventController::class, 'upcoming']); // Event AKAN DATANG
Route::get('/events/past', [EventController::class, 'past']); // Event SUDAH SELESAI
Route::get('/events/{identifier}', [EventController::class, 'show']); // Detail event by ID or slug

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

// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/me', [AuthController::class, 'me']);
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    // Admin routes for managing events
    Route::get('/admin/events', [ModulAcaraController::class, 'index']);
});
