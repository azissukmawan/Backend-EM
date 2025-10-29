<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Otp;
use App\Mail\OtpMail;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use Carbon\Carbon;

class AuthController extends Controller
{
    /**
     * Register user baru
     */
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:users',
            'email' => 'required|string|email|max:255|unique:users',
            'telp' => 'required|string|max:20',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|in:superadmin,peserta',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Buat user baru
        $user = User::create([
            'name' => $request->name,
            'username' => $request->username,
            'email' => $request->email,
            'telp' => $request->telp,
            'password' => Hash::make($request->password),
            'role' => $request->role,
        ]);

        // Generate OTP code
        $otpCode = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        // Simpan OTP ke database
        $otp = Otp::create([
            'user_id' => $user->id,
            'code' => $otpCode,
            'expires_at' => Carbon::now()->addMinutes(10), // OTP berlaku 10 menit
        ]);

        // Kirim OTP via email
        try {
            Mail::to($user->email)->send(new OtpMail($otpCode, $user->name));
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'User created but failed to send OTP email',
                'error' => $e->getMessage()
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'User registered successfully. Please check your email for OTP code.',
            'data' => [
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'username' => $user->username,
                    'email' => $user->email,
                    'telp' => $user->telp,
                    'role' => $user->role,
                ]
            ]
        ], 201);
    }

    /**
     * Verify OTP
     */
    public function verifyOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'otp' => 'required|string|size:6',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        // Cari OTP yang belum diverifikasi dan belum expired
        $otp = Otp::where('user_id', $user->id)
            ->where('code', $request->otp)
            ->whereNull('verified_at')
            ->first();

        if (!$otp) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid OTP code'
            ], 400);
        }

        if ($otp->isExpired()) {
            return response()->json([
                'success' => false,
                'message' => 'OTP code has expired'
            ], 400);
        }

        // Update OTP sebagai terverifikasi
        $otp->update(['verified_at' => Carbon::now()]);

        // Update user email_verified_at
        $user->update(['email_verified_at' => Carbon::now()]);

        return response()->json([
            'success' => true,
            'message' => 'Email verified successfully'
        ], 200);
    }

    /**
     * Resend OTP
     */
    public function resendOtp(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        if ($user->email_verified_at) {
            return response()->json([
                'success' => false,
                'message' => 'Email already verified'
            ], 400);
        }

        // Generate OTP code baru
        $otpCode = str_pad(random_int(0, 999999), 6, '0', STR_PAD_LEFT);

        // Simpan OTP baru ke database
        $otp = Otp::create([
            'user_id' => $user->id,
            'code' => $otpCode,
            'expires_at' => Carbon::now()->addMinutes(10),
        ]);

        // Kirim OTP via email
        try {
            Mail::to($user->email)->send(new OtpMail($otpCode, $user->name));
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to send OTP email',
                'error' => $e->getMessage()
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'OTP code has been resent to your email'
        ], 200);
    }

    /**
     * Login user
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid credentials'
            ], 401);
        }

        if (!$user->email_verified_at) {
            return response()->json([
                'success' => false,
                'message' => 'Please verify your email first'
            ], 403);
        }

        // Buat token menggunakan Sanctum
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'data' => [
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'username' => $user->username,
                    'email' => $user->email,
                    'telp' => $user->telp,
                    'role' => $user->role,
                    'email_verified_at' => $user->email_verified_at,
                ],
                'access_token' => $token,
                'token_type' => 'Bearer'
            ]
        ], 200);
    }

    /**
     * Logout user
     */
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logout successful'
        ], 200);
    }

    /**
     * Get authenticated user
     */
    public function me(Request $request)
    {
        return response()->json([
            'success' => true,
            'data' => [
                'user' => $request->user()
            ]
        ], 200);
    }
}
