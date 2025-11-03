<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class AdminMiddleware
{
    public function handle(Request $request, Closure $next): Response
    {
        if (!Auth::check()) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthenticated'
            ], 401);
        }

        $user = Auth::user();

        // Cek apakah user punya detail_admin (berarti dia admin/superadmin/panitia)
        if (!$user->detailAdmin) {
            return response()->json([
                'success' => false,
                'message' => 'Forbidden. Only admin can access this resource.'
            ], 403);
        }

        // Jika punya detail_admin, berarti sudah bisa akses admin routes
        return $next($request);
    }
}
