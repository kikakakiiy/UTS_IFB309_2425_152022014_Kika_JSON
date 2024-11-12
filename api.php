<?php
// Menambahkan header untuk mengizinkan permintaan dari semua origin (untuk akses CORS)
header("Access-Control-Allow-Origin: *");

// Menambahkan header untuk mengizinkan metode GET, POST, dan OPTIONS dalam permintaan HTTP
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");

// Menambahkan header untuk mengizinkan pengaturan header Content-Type dalam permintaan HTTP
header("Access-Control-Allow-Headers: Content-Type");

// Menetapkan jenis konten yang akan dikirimkan sebagai response yaitu format JSON
header('Content-Type: application/json');

// Mendeklarasikan data dalam bentuk array asosiatif yang akan diubah menjadi JSON
$data = [
    // Nilai suhu maksimum
    "suhumax" => 36,
    
    // Nilai suhu minimum
    "suhumin" => 21,

    // Rata-rata suhu
    "suhurata" => 28.35,

    // Menyimpan daftar data suhu maksimum, kelembapan maksimum, dan kecerahan dengan timestamp
    "nilai_suhu_max_humid_max" => [
        [
            // ID pertama
            "idx" => 101,
            // Nilai suhu
            "suhu" => 36,
            // Nilai kelembapan
            "humid" => 36,
            // Nilai kecerahan
            "kecerahan" => 25,
            // Timestamp data
            "timestamp" => "2010-09-18 07:23:48"
        ],
        [
            // ID kedua
            "idx" => 226,
            // Nilai suhu
            "suhu" => 36,
            // Nilai kelembapan
            "humid" => 36,
            // Nilai kecerahan
            "kecerahan" => 27,
            // Timestamp data
            "timestamp" => "2011-05-02 12:29:34"
        ]
    ],
    
    // Menyimpan data bulan dan tahun maksimum
    "month_year_max" => [
        // Bulan dan tahun pertama
        ["month_year" => "9-2010"],
        // Bulan dan tahun kedua
        ["month_year" => "5-2011"]
    ]
];

// Mengubah array $data menjadi format JSON dan menampilkannya dengan indentasi untuk pembacaan yang lebih mudah
echo json_encode($data, JSON_PRETTY_PRINT);
