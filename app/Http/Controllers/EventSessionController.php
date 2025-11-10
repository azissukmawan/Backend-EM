<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EventSessionController extends Controller
{
    //
    public function toggle(Request $request, $id)
    {
        if (!$request->user() || $request->user()->role !== 'superadmin') {
            return response()->json(['message' => 'Forbidden'], 403);
        }

        $request->validate([
            'mdl_sesi_acara' => 'required|integer|between:1,10',
        ]);

        $event = ModulAcara::findOrFail($id);
        $event->update([
            'mdl_sesi_acara' => $request->mdl_sesi_acara,
            'updated_by' => Auth::id(),
        ]);

        return response()->json([
            'success' => true,
            'message' => "Sesi acara berhasil diperbarui ke sesi {$event->mdl_sesi_acara}.",
        ]);
    }
}
