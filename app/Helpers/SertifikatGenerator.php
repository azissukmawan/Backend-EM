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

            // $fontPath = public_path('fonts/MomoSignature-Regular.ttf');
            $fontPathNomor = public_path('fonts/montserrat/Montserrat-Regular.ttf');
            $fontPathNama = public_path('fonts/montserrat/Montserrat-Medium.ttf');



            // 1. NOMOR SERTIFIKAT (di atas)

            $nomorText = "Nomor: $noSertifikat";
            $nomorFontSize = 45; // Ukuran font lebih besar
            $nomorPosY = (int)($height * 0.29);
            $nomorColor = imagecolorallocate($img, 100, 100, 100); // Biru gelap

            // Hitung lebar text untuk center alignment
            $nomorBox = imagettfbbox($nomorFontSize, 0, $fontPathNomor, $nomorText);
            $nomorWidth = abs($nomorBox[4] - $nomorBox[0]);
            $nomorPosX = (int)(($width - $nomorWidth) / 2);

            imagettftext($img, $nomorFontSize, 0, $nomorPosX, $nomorPosY, $nomorColor, $fontPathNomor, $nomorText);

            // ✅ 2. NAMA PESERTA (di tengah)
            $namaFontSize = 80; // Font lebih besar untuk nama
            $namaPosY = (int)($height * 0.43);
            $namaColor = imagecolorallocate($img, 0, 102, 128); // Hitam

            // Hitung lebar text untuk center alignment
            $namaBox = imagettfbbox($namaFontSize, 0, $fontPathNama, $namaPeserta);
            $namaWidth = abs($namaBox[4] - $namaBox[0]);
            $namaPosX = (int)(($width - $namaWidth) / 2);

            imagettftext($img, $namaFontSize, 0, $namaPosX, $namaPosY, $namaColor, $fontPathNama, $namaPeserta);

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
