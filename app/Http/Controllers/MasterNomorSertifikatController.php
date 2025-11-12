<?php

namespace App\Http\Controllers;

use App\Models\ModulAcara;
use Illuminate\Http\Request;
use App\Helpers\StorageHelper;
use Illuminate\Validation\Rule;
use App\Models\MasterNomorSertifikat;


class MasterNomorSertifikatController extends Controller
{
    //
    public function store(Request $request, $eventId)
    {
        $event = ModulAcara::where('id', $eventId)->first();

        // Cek Event
        if (!$event) {
            return response()->json(['status' => false, 'message' => 'Event tidak ditemukan'], 404);
        }

        if ($event->mdl_status !== 'closed') {
            return response()->json(['status' => false, 'message' => 'Acara belum di selesaikan, selesaikan dulu acara'], 422);
        }

        // Cek Sudah di generate atau belum
        if ($event->is_certificate_generated) {
            return response()->json(['status' => false, 'message' => 'Sertifikat sudah digenerate'], 422);
        }

        $request->merge(['modul_acara_id' => $event->id]);

        $validated = $request->validate([
            'nomor_sk'             => ['required', 'integer', 'min:1'],
            'format_nomor'         => ['required', 'string', 'max:255'],
            'template_sertifikat'  => ['required', 'file', 'mimes:jpg,jpeg,png', 'max:2048'],
            'tanggal_pengesahan'   => ['nullable', 'date'],
            'modul_acara_id'       => ['unique:master_nomor_sertifikat,modul_acara_id'],
        ]);

        $nomorSk     = (int) $validated['nomor_sk'];
        $formatNomor = trim($validated['format_nomor']);

        // Tahun ambil pakai format nomor panjang
        // if (!preg_match('/(\d{4})\s*$/', $formatNomor, $m)) {
        //     return response()->json([
        //         'status'  => false,
        //         'message' => 'Format penomoran tidak valid: tahun (YYYY) wajib di bagian akhir.'
        //     ], 422);
        // }
        // $tahun = (int) $m[1];

        // Tahun ambil dari tanggal pengesahan
        $tahun = substr($validated['tanggal_pengesahan'], 0, 4);

        $prefix = $this->ambilPrefixSampaiTitik($formatNomor);
        $suffix = $this->ambilSuffixDariSlashPertama($formatNomor);

        // --- Cek nomor SK tertinggi sebelumnya (tahun yang sama, semua event) ---
        // $nomorSkTertinggi = MasterNomorSertifikat::where('tahun', $tahun)->max('nomor_sk') ?? 0;

        // if ($nomorSk <= $nomorSkTertinggi) {
        //     return response()->json([
        //         'status'  => false,
        //         'message' => "Nomor SK harus lebih besar dari nomor SK terakhir ($nomorSkTertinggi) di tahun $tahun."
        //     ], 422);
        // }

        // Validasi nomor SK unik base on tahun
        $request->validate([
            'nomor_sk' => [
                Rule::unique('master_nomor_sertifikat', 'nomor_sk')
                    ->where(fn($q) => $q->where('tahun', $tahun))
            ],
        ], [
            'nomor_sk.unique' => "Nomor SK {$nomorSk} untuk tahun {$tahun} sudah digunakan."
        ]);

        // handle template path sertif
        try {
            $templatePath = $this->handleTemplateSertifikat($request->file('template_sertifikat'));
        } catch (\Throwable $e) {
            return response()->json([
                'status'  => false,
                'message' => $e->getMessage(),
            ], 422);
        }

        $payload = [
            'modul_acara_id'      => $event->id,
            'nomor_sk'            => $nomorSk,
            'tanggal_pengesahan'  => $request->tanggal_pengesahan,
            'tahun'               => $tahun,
            'format_nomor'        => $formatNomor,
            'prefix_format_nomor' => $prefix,
            'suffix_format_nomor' => $suffix,
            'template_sertifikat' => $templatePath,
            'created_by'          => $request->user()->id,
        ];

        $record = MasterNomorSertifikat::create($payload);

        $event->is_certificate_generated = true;
        $event->save();

        $record->template_sertifikat_url = StorageHelper::getStorageUrl($record->template_sertifikat);

        return response()->json([
            'status'  => true,
            'message' => 'Master nomor sertifikat berhasil dibuat',
            'data'    => $record
        ], 201);
    }

    public function get($eventId)
    {
        $masterNomorSurat = MasterNomorSertifikat::where('modul_acara_id', $eventId)->first();

        if (!$masterNomorSurat) {
            return response()->json(['status' => false, 'message' => 'Master Nomor tidak ditemukan/belum digenerate'], 404);
        }

        $payload = [
            'nomor_sk'            => $masterNomorSurat->nomor_sk,
            'tanggal_pengesahan'  => $masterNomorSurat->tanggal_pengesahan,
            'format_nomor'        => $masterNomorSurat->format_nomor,
            'template_sertifikat' => StorageHelper::getStorageUrl($masterNomorSurat->template_sertifikat),
        ];

        return response()->json([
            'success'  => true,
            'message' => 'Berhasil mendapatkan master nomor sertifikat',
            'data'    => $payload
        ], 200);
    }


    /**
     * Handle upload template sertifikat
     * Hanya menerima JPG/PNG, reject PDF
     *
     * @param \Illuminate\Http\UploadedFile $file
     * @return string Path file di S3
     * @throws \Exception
     */
    protected function handleTemplateSertifikat($file): string
    {
        // Validasi: Hanya terima JPG/PNG
        $allowedMimes = ['image/jpeg', 'image/jpg', 'image/png'];
        $fileMime = $file->getMimeType();

        if (!in_array($fileMime, $allowedMimes)) {
            throw new \Exception('Template sertifikat harus berformat JPG atau PNG. Format PDF tidak didukung. Silakan convert PDF Anda ke JPG/PNG terlebih dahulu.');
        }

        // Validasi ukuran file (max 5MB)
        if ($file->getSize() > 2 * 1024 * 1024) {
            throw new \Exception('Ukuran file template sertifikat maksimal 2 MB.');
        }

        // Upload langsung ke S3
        return $file->store('modul-acara/sertifikat', 's3');
    }

    private function ambilPrefixSampaiTitik(string $format): ?string
    {
        // Ambil semua karakter sampai titik pertama (termasuk titik)
        $pos = strpos($format, '.');
        if ($pos === false) return null;
        return substr($format, 0, $pos + 1);
    }

    private function ambilSuffixDariSlashPertama(string $format): ?string
    {
        // Ambil mulai dari slash pertama sampai akhir (termasuk slash)
        $pos = strpos($format, '/');
        if ($pos === false) return null;
        return substr($format, $pos);
    }
}
