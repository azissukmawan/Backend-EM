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
