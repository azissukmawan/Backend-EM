<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class PesertaMiddleware
{
    /**
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Belum login → ke login
        if (!Auth::check()) {
            return redirect()->route('login');
        }

        // Sudah login tapi bukan peserta → arahkan ke dashboard yang tepat
        if (!Auth::user() || Auth::user()->role !== 'peserta') {
            return redirect()->route('admin.dashboard'); // ganti sesuai rute kamu
        }

        return $next($request);
    }
}
