<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Cache\RateLimiting\Limit;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Http\Request;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        $this->configureRateLimiting();
    }

    /**
     * Configure the rate limiters for the application.
     */
    protected function configureRateLimiting(): void
    {
        // Rate limiter untuk login - 15 attempts per 1 menit per email+IP
        // Lebih tinggi dari failed login limit (5x) agar account locking bisa berfungsi
        RateLimiter::for('login', function (Request $request) {
            $email = $request->input('login', 'guest');
            return Limit::perMinute(15)->by($email . '|' . $request->ip());
        });

        // Rate limiter untuk OTP - 5 attempts per 1 menit per email
        RateLimiter::for('otp', function (Request $request) {
            $email = $request->input('email', 'guest');
            return Limit::perMinute(5)->by($email . '|' . $request->ip());
        });

        // Rate limiter untuk password reset - 5 attempts per 5 menit
        RateLimiter::for('reset', function (Request $request) {
            return Limit::perMinutes(5, 5)->by($request->ip());
        });

        // Rate limiter untuk API umum - 60 requests per menit
        RateLimiter::for('api', function (Request $request) {
            return Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
        });
    }
}
