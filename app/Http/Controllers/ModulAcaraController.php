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

    // Fungsi CREATE acara
    public function store(Request $request)
    {
        // Proteksi di level controller (cek role superadmin)
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $validated = $request->validate([
            'mdl_nama' => 'required|string|max:150',
            'mdl_kode' => 'required|string|max:30|unique:modul_acara,mdl_kode',
            'mdl_slug' => 'required|string|max:180|unique:modul_acara,mdl_slug',
            'mdl_deskripsi' => 'required|string',
            'mdl_tipe' => 'required|in:online,offline,hybrid',
            'mdl_kategori' => 'required|in:public,private,invite-only',
            'mdl_lokasi' => 'nullable|string|max:255',
            'mdl_latitude' => 'nullable|numeric',
            'mdl_longitude' => 'nullable|numeric',
            'mdl_radius' => 'nullable|integer',
            'mdl_pendaftaran_mulai' => 'required|date',
            'mdl_pendaftaran_selesai' => 'required|date|after_or_equal:mdl_pendaftaran_mulai',
            'mdl_maks_peserta_eksternal' => 'nullable|integer',
            'mdl_acara_mulai' => 'required|date',
            'mdl_acara_selesai' => 'nullable|date|after_or_equal:mdl_acara_mulai',
            'mdl_status' => 'nullable|in:draft,active,closed,archived',
        ]);
        $validated['user_id'] = $request->user()->id;
        $validated['created_by'] = $request->user()->id;
        $acara = ModulAcara::create($validated);
        return response()->json([
            'status' => true,
            'message' => 'Acara berhasil dibuat',
            'data' => $acara
        ], 201);
    }

    // Fungsi UPDATE acara
    public function update(Request $request, $id)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $acara = ModulAcara::find($id);
        if (!$acara) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }
        $validated = $request->validate([
            'mdl_nama' => 'sometimes|string|max:150',
            'mdl_kode' => 'sometimes|string|max:30|unique:modul_acara,mdl_kode,'.$id,
            'mdl_slug' => 'sometimes|string|max:180|unique:modul_acara,mdl_slug,'.$id,
            'mdl_deskripsi' => 'sometimes|string',
            'mdl_tipe' => 'sometimes|in:online,offline,hybrid',
            'mdl_kategori' => 'sometimes|in:public,private,invite-only',
            'mdl_lokasi' => 'nullable|string|max:255',
            'mdl_latitude' => 'nullable|numeric',
            'mdl_longitude' => 'nullable|numeric',
            'mdl_radius' => 'nullable|integer',
            'mdl_pendaftaran_mulai' => 'sometimes|date',
            'mdl_pendaftaran_selesai' => 'sometimes|date|after_or_equal:mdl_pendaftaran_mulai',
            'mdl_maks_peserta_eksternal' => 'nullable|integer',
            'mdl_acara_mulai' => 'sometimes|date',
            'mdl_acara_selesai' => 'nullable|date|after_or_equal:mdl_acara_mulai',
            'mdl_status' => 'nullable|in:draft,active,closed,archived',
        ]);
        $acara->update($validated);
        return response()->json([
            'status' => true,
            'message' => 'Acara berhasil diupdate',
            'data' => $acara
        ]);
    }

    // Fungsi DELETE acara
    public function destroy(Request $request, $id)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }
        $acara = ModulAcara::find($id);
        if (!$acara) {
            return response()->json([
                'status' => false,
                'message' => 'Acara tidak ditemukan'
            ], 404);
        }
        $acara->forceDelete();
        return response()->json([
            'status' => true,
            'message' => 'Acara berhasil dihapus permanen'
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


