<?php

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

use Illuminate\Support\Facades\DB;

// Get all users
$users = DB::table('users')
    ->select('id', 'name', 'username', 'email', 'role', 'email_verified_at')
    ->get();

echo "\n=== ALL REGISTERED USERS ===\n\n";
foreach ($users as $user) {
    echo "ID: " . $user->id . "\n";
    echo "Name: " . $user->name . "\n";
    echo "Username: " . $user->username . "\n";
    echo "Email: " . $user->email . "\n";
    echo "Role: " . $user->role . "\n";
    echo "Verified: " . ($user->email_verified_at ? 'Yes' : 'No') . "\n";
    echo "----------------------------\n";
}
echo "\nTotal Users: " . count($users) . "\n";
