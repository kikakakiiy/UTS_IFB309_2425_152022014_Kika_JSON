// data_model.dart

// Model utama untuk menampung data sensor yang terdiri dari suhu maksimal, suhu minimal, suhu rata-rata,
// serta list dari data suhu dan kelembaban maksimal dan data bulan tahun maksimal.
class DataModel {
  final int suhumax; // Menyimpan nilai suhu maksimum.
  final int suhumin; // Menyimpan nilai suhu minimum.
  final double suhurata; // Menyimpan nilai rata-rata suhu.
  final List<NilaiSuhuMaxHumidMax>
      nilaiSuhuMaxHumidMax; // List yang menampung data suhu dan kelembaban maksimum.
  final List<MonthYearMax>
      monthYearMax; // List yang menampung data bulan dan tahun maksimum.

  // Constructor untuk menginisialisasi seluruh variabel yang ada pada DataModel.
  DataModel({
    // Constructor dari kelas DataModel untuk menginisialisasi semua variabel yang diperlukan.
    required this.suhumax, // Inisialisasi variabel 'suhumax' sebagai nilai wajib untuk data suhu maksimum.
    required this.suhumin, // Inisialisasi variabel 'suhumin' sebagai nilai wajib untuk data suhu minimum.
    required this.suhurata, // Inisialisasi variabel 'suhurata' sebagai nilai wajib untuk data rata-rata suhu.
    required this.nilaiSuhuMaxHumidMax, // Inisialisasi variabel 'nilaiSuhuMaxHumidMax' sebagai nilai wajib untuk daftar data suhu dan kelembaban maksimum.
    required this.monthYearMax, // Inisialisasi variabel 'monthYearMax' sebagai nilai wajib untuk daftar data bulan dan tahun maksimum.
  });

  // Fungsi factory untuk membuat objek DataModel dari data JSON.
  factory DataModel.fromJson(Map<String, dynamic> json) {
    var list1 = json['nilai_suhu_max_humid_max']
        as List; // Mengambil data 'nilai_suhu_max_humid_max' dari JSON dan mengonversinya ke List.
    var list2 = json['month_year_max']
        as List; // Mengambil data 'month_year_max' dari JSON dan mengonversinya ke List.

    return DataModel(
      suhumax: json[
          'suhumax'], // Mengonversi nilai 'suhumax' dari JSON ke variabel suhumax.
      suhumin: json[
          'suhumin'], // Mengonversi nilai 'suhumin' dari JSON ke variabel suhumin.
      suhurata: json['suhurata']
          .toDouble(), // Mengonversi nilai 'suhurata' ke tipe double dan menampilkannya di suhurata.
      nilaiSuhuMaxHumidMax: list1
          .map((i) => NilaiSuhuMaxHumidMax.fromJson(i))
          .toList(), // Mengonversi setiap item pada list1 ke objek NilaiSuhuMaxHumidMax.
      monthYearMax: list2
          .map((i) => MonthYearMax.fromJson(i))
          .toList(), // Mengonversi setiap item pada list2 ke objek MonthYearMax.
    );
  }
}

// Model untuk menampung data suhu dan kelembaban maksimum beserta informasi lainnya.
class NilaiSuhuMaxHumidMax {
  final int idx; // Menyimpan indeks data.
  final int suhu; // Menyimpan nilai suhu maksimum.
  final int humid; // Menyimpan nilai kelembaban maksimum.
  final int kecerahan; // Menyimpan nilai kecerahan.
  final String timestamp; // Menyimpan nilai waktu pengambilan data.

  // Constructor untuk inisialisasi variabel NilaiSuhuMaxHumidMax.
  NilaiSuhuMaxHumidMax({
    // Constructor dari kelas NilaiSuhuMaxHumidMax untuk inisialisasi semua variabel yang dibutuhkan.
    required this.idx, // Inisialisasi variabel 'idx' sebagai nilai yang wajib diisi.
    required this.suhu, // Inisialisasi variabel 'suhu' sebagai nilai yang wajib diisi.
    required this.humid, // Inisialisasi variabel 'humid' sebagai nilai yang wajib diisi.
    required this.kecerahan, // Inisialisasi variabel 'kecerahan' sebagai nilai yang wajib diisi.
    required this.timestamp, // Inisialisasi variabel 'timestamp' sebagai nilai yang wajib diisi.
  });

  // Fungsi factory untuk membuat objek NilaiSuhuMaxHumidMax dari data JSON.
  factory NilaiSuhuMaxHumidMax.fromJson(Map<String, dynamic> json) {
    return NilaiSuhuMaxHumidMax(
      idx: json['idx'], // Mengambil nilai 'idx' dari JSON ke variabel idx.
      suhu: json['suhu'], // Mengambil nilai 'suhu' dari JSON ke variabel suhu.
      humid:
          json['humid'], // Mengambil nilai 'humid' dari JSON ke variabel humid.
      kecerahan: json[
          'kecerahan'], // Mengambil nilai 'kecerahan' dari JSON ke variabel kecerahan.
      timestamp: json[
          'timestamp'], // Mengambil nilai 'timestamp' dari JSON ke variabel timestamp.
    );
  }
}

// Model untuk menampung data bulan dan tahun maksimum.
class MonthYearMax {
  final String monthYear; // Menyimpan nilai bulan dan tahun maksimum.

  // Constructor untuk inisialisasi variabel monthYear.
  MonthYearMax({required this.monthYear});

  // Fungsi factory untuk membuat objek MonthYearMax dari data JSON.
  factory MonthYearMax.fromJson(Map<String, dynamic> json) {
    return MonthYearMax(
      monthYear: json[
          'month_year'], // Mengambil nilai 'month_year' dari JSON ke variabel monthYear.
    );
  }
}
