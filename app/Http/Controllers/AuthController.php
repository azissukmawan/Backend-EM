<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Otp;
use App\Mail\OtpMail;
use App\Mail\ResetPasswordMail;
use App\Models\DetailPeserta;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
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
            'status_karyawan' => 'required',
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
            'role' => 'peserta',
        ]);

        DetailPeserta::create([
            'user_id' => $user->id,
            'status_karyawan' => $request->status_karyawan,
            'foto' => null,
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

        // Cek apakah ada OTP yang baru saja dikirim dalam 2 menit terakhir
        $lastOtp = Otp::where('user_id', $user->id)
            ->where('created_at', '>', Carbon::now()->subMinutes(2))
            ->latest()
            ->first();

        if ($lastOtp) {
            $waitTime = Carbon::now()->diffInSeconds($lastOtp->created_at->addMinutes(2));
            return response()->json([
                'success' => false,
                'message' => 'Please wait before requesting a new OTP',
                'wait_seconds' => $waitTime
            ], 429);
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
            'login' => 'required|string', // Bisa email atau username
            'password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Cek apakah login menggunakan email atau username
        $loginField = filter_var($request->login, FILTER_VALIDATE_EMAIL) ? 'email' : 'username';

        $user = User::where($loginField, $request->login)->first();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid credentials'
            ], 401);
        }

        // Cek apakah akun terkunci
        if ($user->isLocked()) {
            $lockRemaining = Carbon::now()->diffInMinutes($user->locked_until);
            return response()->json([
                'success' => false,
                'message' => 'Account is temporarily locked due to too many failed login attempts',
                'locked_until' => $user->locked_until->toDateTimeString(),
                'minutes_remaining' => $lockRemaining
            ], 423);
        }

        // Verifikasi password
        if (!Hash::check($request->password, $user->password)) {
            // Increment failed login attempts
            $user->incrementFailedLoginAttempts();

            $remainingAttempts = 5 - $user->failed_login_attempts;

            if ($user->isLocked()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Too many failed login attempts. Account locked for 15 minutes.',
                    'locked_until' => $user->locked_until->toDateTimeString()
                ], 423);
            }

            return response()->json([
                'success' => false,
                'message' => 'Invalid credentials',
                'remaining_attempts' => max(0, $remainingAttempts)
            ], 401);
        }

        // Cek email verification
        if (!$user->email_verified_at) {
            return response()->json([
                'success' => false,
                'message' => 'Please verify your email first'
            ], 403);
        }

        // Login berhasil - reset failed attempts
        $user->resetFailedLoginAttempts();

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

    /**
     * Forgot Password - Send reset link
     */
    public function forgotPassword(Request $request)
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

        // Generate random token
        $token = Str::random(60);

        // Hapus token lama jika ada
        DB::table('password_resets')->where('email', $request->email)->delete();

        // Simpan token baru
        DB::table('password_resets')->insert([
            'email' => $request->email,
            'token' => Hash::make($token),
            'created_at' => Carbon::now()
        ]);

        // Buat reset link (ganti dengan URL frontend kamu)
        $resetLink = env('FRONTEND_URL', 'http://localhost:3000') . '/reset-password?token=' . $token . '&email=' . urlencode($request->email);

        // Kirim email
        try {
            Mail::to($user->email)->send(new ResetPasswordMail($resetLink, $user->name));
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to send reset password email',
                'error' => $e->getMessage()
            ], 500);
        }

        return response()->json([
            'success' => true,
            'message' => 'Password reset link has been sent to your email'
        ], 200);
    }

    /**
     * Reset Password
     */
    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email',
            'token' => 'required|string',
            'password' => 'required|string|min:8|confirmed',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validation error',
                'errors' => $validator->errors()
            ], 422);
        }

        // Cari token di database
        $passwordReset = DB::table('password_resets')
            ->where('email', $request->email)
            ->first();

        if (!$passwordReset) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid reset token'
            ], 400);
        }

        // Cek apakah token sudah expired (60 menit)
        $createdAt = Carbon::parse($passwordReset->created_at);
        if ($createdAt->addMinutes(60)->isPast()) {
            DB::table('password_resets')->where('email', $request->email)->delete();
            return response()->json([
                'success' => false,
                'message' => 'Reset token has expired'
            ], 400);
        }

        // Verifikasi token
        if (!Hash::check($request->token, $passwordReset->token)) {
            return response()->json([
                'success' => false,
                'message' => 'Invalid reset token'
            ], 400);
        }

        // Update password user
        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'User not found'
            ], 404);
        }

        // Update hanya password, jangan update field lain
        $user->password = Hash::make($request->password);
        $user->save();

        // Hapus token reset password dari tabel password_resets
        DB::table('password_resets')->where('email', $request->email)->delete();

        // Revoke semua access token Sanctum (logout dari semua device)
        $user->tokens()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Password has been reset successfully'
        ], 200);
    }
}
