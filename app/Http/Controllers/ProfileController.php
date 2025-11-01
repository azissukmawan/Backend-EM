<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use App\Models\DetailPeserta;
use App\Helpers\StorageHelper;
use Intervention\Image\ImageManager;
use Intervention\Image\Drivers\Gd\Driver;

class ProfileController extends Controller
{
    /**
     * Get authenticated user profile (Peserta only)
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function getProfile(Request $request)
    {
        try {
            $user = $request->user();

            if ($user->role !== 'peserta') {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for peserta.'
                ], 403);
            }

            $user->load('detailPeserta');

            $profilePhoto = StorageHelper::getStorageUrl($user->detailPeserta?->foto);

            return response()->json([
                'success' => true,
                'message' => 'Profile retrieved successfully',
                'data' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'username' => $user->username,
                    'email' => $user->email,
                    'telp' => $user->telp,
                    'role' => $user->role,
                    'email_verified_at' => $user->email_verified_at,
                    'profile_photo' => $profilePhoto,
                    'status_karyawan' => $user->detailPeserta->status_karyawan ?? null,
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to retrieve profile',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Update authenticated user profile (Peserta only)
     * Can update: name, telp, profile_photo only
     * Email cannot be updated
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateProfile(Request $request)
    {
        try {
            $user = $request->user();

            if ($user->role !== 'peserta') {
                return response()->json([
                    'success' => false,
                    'message' => 'Access denied. This endpoint is only for peserta.'
                ], 403);
            }

            // Skip validation for profile_photo, we'll handle it manually
            $validator = Validator::make($request->all(), [
                'name' => 'sometimes|string|max:255',
                'telp' => 'sometimes|string|max:20|unique:users,telp,' . $user->id,
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            // Validate profile_photo manually if exists
            if ($request->hasFile('profile_photo')) {
                $file = $request->file('profile_photo');

                // Check if it's a valid image
                if (!in_array($file->getMimeType(), ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'])) {
                    return response()->json([
                        'success' => false,
                        'message' => 'Validation error',
                        'errors' => [
                            'profile_photo' => ['The profile photo must be an image (jpeg, png, jpg, gif).']
                        ]
                    ], 422);
                }
            }

            if ($request->has('email')) {
                return response()->json([
                    'success' => false,
                    'message' => 'Email cannot be updated.',
                    'note' => 'Email is permanent and cannot be changed for security reasons'
                ], 400);
            }

            if ($request->has('name')) {
                $user->name = $request->name;
            }

            if ($request->has('telp')) {
                $user->telp = $request->telp;
            }

            $user->save();

            if ($request->hasFile('profile_photo')) {
                $detailPeserta = $user->detailPeserta;

                if (!$detailPeserta) {
                    $detailPeserta = new DetailPeserta();
                    $detailPeserta->user_id = $user->id;
                }

                // Delete old photo if exists
                if ($detailPeserta->foto && Storage::disk('s3')->exists($detailPeserta->foto)) {
                    Storage::disk('s3')->delete($detailPeserta->foto);
                }

                $file = $request->file('profile_photo');

                // Initialize ImageManager with GD driver
                $manager = new ImageManager(new Driver());

                // Auto-compress image to be less than 1MB
                $image = $manager->read($file);

                // Start with quality 90
                $quality = 90;
                $compressedImage = null;

                // Resize if image is too large (max 1920px width)
                if ($image->width() > 1920) {
                    $image->scale(width: 1920);
                }

                // Compress until file size is less than 1MB
                do {
                    $compressedImage = $image->toJpeg($quality);
                    $fileSize = strlen($compressedImage);

                    // If file is less than 1MB, break
                    if ($fileSize < 314572) { // 3MB = 3145728 bytes
                        break;
                    }

                    // Reduce quality by 5
                    $quality -= 5;

                    // Prevent infinite loop (minimum quality 30)
                    if ($quality < 30) {
                        // If still too large, resize more aggressively
                        $image->scale(width: 1200);
                        $quality = 75;
                        $compressedImage = $image->toJpeg($quality);
                        break;
                    }
                } while (true);

                $path = 'profile_photos/' . uniqid() . '.jpg';

                Storage::disk('s3')->put($path, $compressedImage, 'public');

                $detailPeserta->foto = $path;
                $detailPeserta->save();
            }

            $user->load('detailPeserta');

            $profilePhoto = StorageHelper::getStorageUrl($user->detailPeserta?->foto);

            return response()->json([
                'success' => true,
                'message' => 'Profile updated successfully',
                'data' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'username' => $user->username,
                    'email' => $user->email,
                    'telp' => $user->telp,
                    'role' => $user->role,
                    'email_verified_at' => $user->email_verified_at,
                    'profile_photo' => $profilePhoto,
                    'status_karyawan' => $user->detailPeserta->status_karyawan ?? null,
                ]
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to update profile',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Change user password
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function changePassword(Request $request)
    {
        try {
            $user = $request->user();

            $validator = Validator::make($request->all(), [
                'current_password' => 'required|string',
                'new_password' => 'required|string|min:8|confirmed',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'success' => false,
                    'message' => 'Validation error',
                    'errors' => $validator->errors()
                ], 422);
            }

            if (!Hash::check($request->current_password, $user->password)) {
                return response()->json([
                    'success' => false,
                    'message' => 'Current password is incorrect'
                ], 401);
            }

            $user->password = Hash::make($request->new_password);
            $user->save();

            return response()->json([
                'success' => true,
                'message' => 'Password changed successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Failed to change password',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
