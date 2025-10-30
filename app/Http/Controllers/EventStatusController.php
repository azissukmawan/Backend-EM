<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use Illuminate\Http\Request;

class EventStatusController extends Controller
{
    public function getStatusCounts()
    {
        $now = now();

        $comingSoon = ModulAcara::where('mdl_acara_mulai', '>', $now)->count();
        $ongoing = ModulAcara::where('mdl_acara_mulai', '<=', $now)
                        ->where('mdl_acara_selesai', '>=', $now)
                        ->count();
        $closed = ModulAcara::where('mdl_acara_selesai', '<', $now)->count();

        return [
            'coming_soon' => $comingSoon,
            'ongoing' => $ongoing,
            'closed' => $closed,
        ];
    }
}