<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\DB;

// Get latest OTP
$otp = DB::table('otps')
    ->orderBy('created_at', 'desc')
    ->first();

if ($otp) {
    echo "\n=== LATEST OTP ===\n";
    echo "Code: " . $otp->code . "\n";
    echo "User ID: " . $otp->user_id . "\n";
    echo "Expires At: " . $otp->expires_at . "\n";
    echo "Created At: " . $otp->created_at . "\n";
    echo "==================\n";
    
    // Get user email
    $user = DB::table('users')->where('id', $otp->user_id)->first();
    if ($user) {
        echo "Email: " . $user->email . "\n";
        echo "Name: " . $user->name . "\n";
    }
} else {
    echo "No OTP found. Please register first.\n";
}

