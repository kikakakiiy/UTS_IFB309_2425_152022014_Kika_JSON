import 'dart:convert'; // Mengimpor pustaka 'dart:convert' untuk mengencode dan decode data JSON
import 'package:flutter/material.dart'; // Mengimpor pustaka untuk antarmuka pengguna Flutter
import 'package:http/http.dart'
    as http; // Mengimpor pustaka HTTP untuk melakukan permintaan ke API
import 'backend.dart'; // Mengimpor file backend.dart untuk model data dan fungsi tambahan

void main() {
  runApp(MyApp()); // Memulai aplikasi Flutter dengan widget MyApp
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter JSON Parsing', // Judul aplikasi
      theme: ThemeData(
        primarySwatch:
            Colors.pink, // Mengatur tema utama dengan warna merah muda
        scaffoldBackgroundColor:
            Color(0xFFF8EDED), // Warna latar belakang untuk scaffold
        appBarTheme: AppBarTheme(
          color: Color(0xFFB71C1C), // Warna app bar
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(
              color: Color(
                  0xFF4E342E)), // Gaya teks untuk body dengan warna tertentu
        ),
      ),
      home: HomePage(), // Menetapkan HomePage sebagai halaman utama aplikasi
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState(); // Membuat state untuk HomePage
}

class _HomePageState extends State<HomePage> {
  late Future<DataModel>
      dataModel; // Variabel untuk menampung data yang akan diambil

  // Fungsi untuk mengambil data dari API
  Future<DataModel> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://localhost/utsiotkika/api.php')); // Permintaan HTTP GET

    if (response.statusCode == 200) {
      return DataModel.fromJson(json.decode(response
          .body)); // Jika respons berhasil, mengubah data JSON menjadi DataModel
    } else {
      throw Exception('Failed to load data'); // Jika gagal, lemparkan exception
    }
  }

  @override
  void initState() {
    super.initState();
    dataModel = fetchData(); // Mengambil data saat state diinisialisasi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Sensor JSON Parsing'), // Judul AppBar
        centerTitle: true, // Menyusun judul di tengah
      ),
      body: FutureBuilder<DataModel>(
        future:
            dataModel, // Menggunakan FutureBuilder untuk menangani data asinkron
        builder: (context, snapshot) {
          // Menentukan tampilan berdasarkan status koneksi
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child:
                    CircularProgressIndicator()); // Menampilkan indikator loading
          } else if (snapshot.hasError) {
            return Center(
                child: Text(
                    'Error: ${snapshot.error}')); // Menampilkan error jika ada masalah
          } else if (!snapshot.hasData) {
            return Center(
                child: Text(
                    'No Data Found')); // Menampilkan pesan jika tidak ada data
          } else {
            final data = snapshot.data!; // Mendapatkan data dari snapshot
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Tabel dengan data suhu
                  Table(
                    border: TableBorder.all(
                        color: Colors.pink, width: 2), // Membuat border tabel
                    children: [
                      TableRow(
                        children: [
                          _buildTableCell('Suhu Max',
                              backgroundColor: Color(
                                  0xFFFFF9C4)), // Sel dengan warna latar belakang kuning pastel
                          _buildTableCell('Suhu Min',
                              backgroundColor: Color(
                                  0xFFFFF9C4)), // Sel dengan warna latar belakang kuning pastel
                          _buildTableCell('Suhu Rata-rata',
                              backgroundColor: Color(
                                  0xFFFFF9C4)), // Sel dengan warna latar belakang kuning pastel
                        ],
                      ),
                      TableRow(
                        children: [
                          _buildTableCell(
                              '${data.suhumax}'), // Menampilkan suhu maksimum
                          _buildTableCell(
                              '${data.suhumin}'), // Menampilkan suhu minimum
                          _buildTableCell(
                              '${data.suhurata}'), // Menampilkan suhu rata-rata
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20), // Memberikan jarak antara widget
                  Text(
                    'Nilai Temperature dan Humidity Max:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFB71C1C), // Gaya teks dengan warna merah
                    ),
                  ),
                  ...data.nilaiSuhuMaxHumidMax.map((item) => Card(
                        color: Color(0xFFFFEBEE), // Warna latar belakang card
                        elevation: 5, // Mengatur elevasi card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Membuat sudut card melengkung
                        ),
                        child: ListTile(
                          leading: Icon(Icons.thermostat,
                              color: Colors.red), // Ikon suhu
                          title: Text('ID: ${item.idx}'), // Menampilkan ID item
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Suhu: ${item.suhu}'), // Menampilkan suhu
                              Text(
                                  'Humid: ${item.humid}'), // Menampilkan kelembapan
                              Text(
                                  'Kecerahan: ${item.kecerahan}'), // Menampilkan kecerahan
                              Text(
                                  'Timestamp: ${item.timestamp}'), // Menampilkan timestamp
                            ],
                          ),
                        ),
                      )),
                  SizedBox(height: 20), // Memberikan jarak antara widget
                  Text(
                    'Month Year Max:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFFB71C1C), // Gaya teks dengan warna merah
                    ),
                  ),
                  ...data.monthYearMax.map((item) => Card(
                        color: Color(0xFFFFCDD2), // Warna latar belakang card
                        elevation: 5, // Mengatur elevasi card
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Membuat sudut card melengkung
                        ),
                        child: ListTile(
                          leading: Icon(Icons.calendar_today,
                              color: Colors.pinkAccent), // Ikon kalender
                          title: Text(
                              'Month Year: ${item.monthYear}'), // Menampilkan bulan dan tahun
                        ),
                      )),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Widget untuk menampilkan judul dan nilai dalam bentuk baris
  Widget _buildTitle(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Padding vertikal
      child: Row(
        children: [
          Icon(Icons.arrow_right,
              color: Colors.pink), // Ikon panah untuk menandakan item
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFFB71C1C), // Gaya teks dengan warna merah
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4E342E), // Gaya teks dengan warna coklat tua
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk menampilkan sel dalam tabel dengan kemampuan hover
  Widget _buildTableCell(String value, {Color backgroundColor = Colors.white}) {
    Color cellColor =
        backgroundColor; // Variable untuk melacak warna latar belakang saat hover

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          cellColor = Colors.lightBlueAccent; // Mengubah warna sel saat hover
        });
      },
      onExit: (_) {
        setState(() {
          cellColor =
              backgroundColor; // Mengembalikan warna ke semula setelah hover
        });
      },
      child: Container(
        color: cellColor, // Menggunakan warna latar belakang saat ini
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF880E4F), // Warna teks untuk nilai tabel
              ),
            ),
          ],
        ),
      ),
    );
  }
}
