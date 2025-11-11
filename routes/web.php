<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

// Preview OTP Email Template
Route::get('/preview-otp-email', function () {
    return view('emails.otp', [
        'otpCode' => '123456',
        'userName' => 'John Doe'
    ]);
});

// Preview Reset Password Email Template
Route::get('/preview-reset-password-email', function () {
    return view('emails.reset-password', [
        'resetLink' => 'http://localhost:3000/reset-password?token=sample_token_here&email=user@example.com',
        'userName' => 'John Doe'
    ]);
});

Route::get('/info', function () {
    dd(phpinfo());
});
