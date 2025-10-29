<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\DB;

// Get latest OTP and make it expired
$otp = DB::table('otps')
    ->orderBy('created_at', 'desc')
    ->whereNull('verified_at')
    ->first();

if ($otp) {
    // Set expires_at to past time
    DB::table('otps')
        ->where('id', $otp->id)
        ->update([
            'expires_at' => date('Y-m-d H:i:s', strtotime('-1 minute'))
        ]);
    
    echo "\n✅ OTP has been set to EXPIRED\n";
    echo "Code: " . $otp->code . "\n";
    echo "Email: ";
    $user = DB::table('users')->where('id', $otp->user_id)->first();
    echo $user->email . "\n";
    echo "\nTest dengan code ini untuk mendapatkan error 'OTP code has expired'\n\n";
} else {
    echo "No unverified OTP found.\n";
}
