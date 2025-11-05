<?php

namespace App\Helpers;

use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

class SertifikatGenerator
{
    /**
     * Generate sertifikat dengan overlay text menggunakan GD Library
     *
     * @param string $templatePath Path template di S3 (relatif)
     * @param string $namaPeserta Nama peserta
     * @param string $noSertifikat Nomor sertifikat
     * @param string $namaAcara Nama acara
     * @param string $tanggalAcara Tanggal acara
     * @return string|null Path file sertifikat yang sudah di-generate
     */
    public static function generate(
        string $templatePath,
        string $namaPeserta,
        string $noSertifikat,
        string $namaAcara = '',
        string $tanggalAcara = ''
    ): ?string {
        try {
            // Download template dari S3
            $templateContent = Storage::disk('s3')->get($templatePath);

            if (!$templateContent) {
                \Log::error("Template sertifikat tidak ditemukan: $templatePath");
                return null;
            }

            // Simpan ke temporary file
            $tempTemplate = sys_get_temp_dir() . '/' . Str::random(10) . '.jpg';
            file_put_contents($tempTemplate, $templateContent);

            // Deteksi tipe image
            $imageInfo = getimagesize($tempTemplate);
            $mimeType = $imageInfo['mime'];

            // Load image sesuai tipe
            switch ($mimeType) {
                case 'image/jpeg':
                    $img = imagecreatefromjpeg($tempTemplate);
                    break;
                case 'image/png':
                    $img = imagecreatefrompng($tempTemplate);
                    break;
                default:
                    throw new \Exception("Format image tidak didukung: $mimeType");
            }

            if (!$img) {
                throw new \Exception("Gagal load template image");
            }

            // Dapatkan dimensi gambar
            $width = imagesx($img);
            $height = imagesy($img);

            // Path font (pastikan font tersedia)
            $fontPath = public_path('fonts/MomoSignature-Regular.ttf');

            if (!file_exists($fontPath)) {
                \Log::error("Font Arial ihiw.ttf tidak ditemukan di: $fontPath");
                $fontPath = null; // fallback
            }

            // =====================================================================
            // 🔧 KONFIGURASI FONT SIZE
            // =====================================================================
            $fontSizeNomor = 20;  // ukuran font untuk nomor sertifikat
            $fontSizeNama  = 20; // ukuran font untuk nama peserta
            // =====================================================================

            // ✅ 1. NOMOR SERTIFIKAT (di atas)
            $nomorText = "Nomor: $noSertifikat";
            $nomorPosY = (int)($height * 0.30);
            $nomorColor = imagecolorallocate($img, 30, 58, 138); // Biru gelap

            if ($fontPath) {
                // Hitung posisi center horizontal
                $bbox = imagettfbbox($fontSizeNomor, 0, $fontPath, $nomorText);
                $textWidth = abs($bbox[4] - $bbox[0]);
                $nomorPosX = (int)(($width - $textWidth) / 2);

                imagettftext($img, $fontSizeNomor, 0, $nomorPosX, $nomorPosY, $nomorColor, $fontPath, $nomorText);
            } else {
                imagestring($img, 5, (int)($width / 2 - 100), $nomorPosY, $nomorText, $nomorColor);
            }

            // ✅ 2. NAMA PESERTA (di tengah)
            $namaPosY = (int)($height * 0.45);
            $namaColor = imagecolorallocate($img, 0, 0, 0); // Hitam

            if ($fontPath) {
                $bbox = imagettfbbox($fontSizeNama, 0, $fontPath, $namaPeserta);
                $textWidth = abs($bbox[4] - $bbox[0]);
                $namaPosX = (int)(($width - $textWidth) / 2);

                imagettftext($img, $fontSizeNama, 0, $namaPosX, $namaPosY, $namaColor, $fontPath, $namaPeserta);
            } else {
                imagestring($img, 5, (int)($width / 2 - 50), $namaPosY, $namaPeserta, $namaColor);
            }

            // Generate nama file unik
            $fileName = 'sertifikat_' . time() . '_' . Str::random(10) . '.jpg';
            $outputPath = sys_get_temp_dir() . '/' . $fileName;

            // Simpan hasil ke file sementara
            imagejpeg($img, $outputPath, 90);

            // Bersihkan memory
            imagedestroy($img);

            // Upload ke S3
            $s3Path = 'sertifikat-generated/' . $fileName;
            Storage::disk('s3')->put($s3Path, file_get_contents($outputPath), 'public');

            // Hapus file temp
            @unlink($tempTemplate);
            @unlink($outputPath);

            return $s3Path;

        } catch (\Exception $e) {
            \Log::error('Error generating sertifikat: ' . $e->getMessage());
            \Log::error('Stack trace: ' . $e->getTraceAsString());

            if (isset($tempTemplate) && file_exists($tempTemplate)) {
                @unlink($tempTemplate);
            }
            if (isset($outputPath) && file_exists($outputPath)) {
                @unlink($outputPath);
            }
            if (isset($img) && is_resource($img)) {
                imagedestroy($img);
            }

            return null;
        }
    }
}
