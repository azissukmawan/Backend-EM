<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DashboardAdminController extends Controller
{
    protected $eventStatus;

    public function __construct(EventStatusController $eventStatus)
    {
        $this->eventStatus = $eventStatus;
    }

    public function stats()
    {
        $eventStats = $this->eventStatus->getStatusCounts();

        return response()->json([
            'success' => true,
            'event_stats' => $eventStats,
        ]);
    }
}