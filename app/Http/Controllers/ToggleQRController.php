<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\ModulAcara;
use Illuminate\Support\Facades\Auth;

class ToggleQRController extends Controller
{
    /**
     * Toggle status presensi (aktif / nonaktif)
     */
    public function toggle(Request $request, $id)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $request->validate([
            'status_qr' => 'required|boolean',
        ]);

        $event = ModulAcara::findOrFail($id);

        // Konversi boolean ke integer
        $status = $request->boolean('status_qr') ? 1 : 0;

        // Update status presensi
        $event->update([
            'mdl_presensi_aktif' => $request->status_qr,
            'updated_by' => Auth::id(),
        ]);

        return response()->json([
            'success' => true,
            'message' => $status
                ? 'Presensi diaktifkan.'
                : 'Presensi dinonaktifkan.',
            'data' => [
                'id' => $event->id,
                'nama' => $event->mdl_nama,
                'kode_qr' => $event->mdl_kode_qr,
                'presensi_aktif' => $status,
            ]
        ]);
    }
}
