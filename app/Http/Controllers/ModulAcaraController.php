<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ModulAcara;
use Illuminate\Http\Request;

class ModulAcaraController extends Controller
{
    public function index(Request $request)
    {
        $query = ModulAcara::query();

        // Filter pencarian berdasarkan nama acara
        if ($request->filled('search')) {
            $query->where('mdl_nama', 'like', '%' . $request->search . '%');
        }

        // Filter status acara
        if ($request->filled('status')) {
            $query->where('mdl_status', $request->status);
        }

        // Filter berdasarkan tanggal pendaftaran mulai
        if ($request->filled('tanggal_mulai')) {
            $query->whereDate('mdl_pendaftaran_mulai', '>=', $request->tanggal_mulai);
        }

        $events = $query->latest()->paginate(10);

        return response()->json([
            'status' => true,
            'message' => 'Daftar acara berhasil diambil',
            'data' => $events
        ]);
    }

    public function show($id)
    {
        $event = ModulAcara::find($id);

        if (!$event) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }

        return response()->json([
            'status' => true,
            'message' => 'Detail acara berhasil diambil',
            'data' => $event
        ]);
    }

    // public function index()
    // {
    //     $events = ModulAcara::latest()->paginate(10);
    //     return response()->json([
    //         'status' => true,
    //         'message' => 'Daftar acara berhasil diambil',
    //         'data' => $events
    //     ]);
    // }

    // public function show($id)
    // {
    //     $event = ModulAcara::find($id);

    //     if (!$event) {
    //         return response()->json([
    //             'status' => false,
    //             'message' => 'Acara tidak ditemukan'
    //         ], 404);
    //     }

    //     return response()->json([
    //         'status' => true,
    //         'message' => 'Detail acara berhasil diambil',
    //         'data' => $event
    //     ]);
    // }
}


