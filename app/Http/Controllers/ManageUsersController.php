<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class ManageUsersController extends Controller
{
    /**
     * Display a listing of users with optional filters and pagination.
     * Query params:
     * - search: filter by name/username/email/phone (contains)
     * - role: filter by role (admin, panitia, peserta, superadmin, etc.)
     * - per_page: items per page (default 15, max 100)
     */
    public function index(Request $request): JsonResponse
    {
        $search = $request->query('search');
        $role = $request->query('role');

        $query = User::query()
            ->whereNotNull('email_verified_at')
            ->where('role', 'peserta')
            ->with('detailPeserta')
            ->latest('id');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('username', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('telp', 'like', "%{$search}%");
            });
        }

        // Force role peserta; ignore custom role filter to ensure only 'peserta' is managed
        if ($role && $role !== 'peserta') {
            // no-op: we intentionally do not allow other roles
        }

        $users = $query->get();

        return response()->json([
            'success' => true,
            'message' => 'Daftar user berhasil diambil',
            'data' => $users,
        ]);
    }

    public function userNotVerified(Request $request): JsonResponse
    {
        $search = $request->query('search');
        $role = $request->query('role');

        $query = User::query()
            ->whereNull('email_verified_at')
            ->where('role', 'peserta')
            ->with('detailPeserta')
            ->latest('id');

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('username', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%")
                    ->orWhere('telp', 'like', "%{$search}%");
            });
        }

        // Force role peserta; ignore custom role filter to ensure only 'peserta' is managed
        if ($role && $role !== 'peserta') {
            // no-op: we intentionally do not allow other roles
        }

        $users = $query->get();

        return response()->json([
            'success' => true,
            'message' => 'Daftar user berhasil diambil',
            'data' => $users,
        ]);
    }

    /**
     * Remove the specified user from storage.
     */
    public function destroy(int $id): JsonResponse
    {
        $user = User::find($id);

        if (! $user) {
            return response()->json([
                'success' => false,
                'message' => 'User tidak ditemukan',
            ], 404);
        }

        // Optional guard: prevent deleting self via API if desired
        if (auth()->check() && auth()->id() === $user->id) {
            return response()->json([
                'success' => false,
                'message' => 'Tidak dapat menghapus akun sendiri',
            ], 422);
        }

        // Validasi hanya bisa hapus user dengan role 'peserta'
        if ($user->role !== 'peserta') {
            return response()->json([
                'success' => false,
                'message' => 'Hanya user dengan role peserta yang dapat dihapus',
            ], 403);
        }

        $user->delete();

        return response()->json([
            'success' => true,
            'message' => 'User berhasil dihapus',
        ]);
    }


    public function destroyAllNotVerified(): JsonResponse
    {
        $deleted = User::whereNull('email_verified_at')
            ->where('role', 'peserta')
            ->delete();

        return response()->json([
            'success' => true,
            'message' => $deleted > 0
                ? "Berhasil menghapus {$deleted} user yang belum verifikasi email."
                : "Tidak ada user yang belum verifikasi email untuk dihapus.",
        ]);
    }
}