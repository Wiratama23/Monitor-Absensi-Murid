import 'package:flutter/material.dart';
import 'package:absensi_sd/dummyData/dummy.dart';
import 'package:absensi_sd/screen/components/build_list.dart';

import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);
  final String _namaSiswa = DummyData.nama;
  final String _nisSiswa = DummyData.nis;
  final String _kelasSiswa = DummyData.kelas;
  final String _imageSiswa = DummyData.imagePath;
  final List<Map<String, String>> _data = data;

  static const List<Map<String, String>> data = [
    {"date": "12-20-2021", "day": "Minggu", "status": "Hadir"},
    {"date": "11-20-2021", "day": "Senin", "status": "Tidak Hadir"},
    // Add other attendance data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          // style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Widget-widget dari dashboard

          // Kartu berwarna merah di bawah dashboard
          Card(
            color: Colors.red,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Foto 3x4 di sebelah kiri
                  Container(
                    width: 72,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            _imageSiswa), // Ganti dengan path foto siswa
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Spacer antara foto dan teks

                  // Informasi siswa di sebelah kanan
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama siswa
                        Text(
                          "Nama \t: " + _namaSiswa,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(height: 5), // Spacer antara nama dan NIS

                        // NIS siswa
                        Text(
                          "NIS \t: " + _nisSiswa,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 5), // Spacer antara NIS dan kelas

                        // Kelas siswa
                        Text(
                          "Kelas \t: " + _kelasSiswa,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          BuildList(data: _data)
        ],
      ),
      //membuat sebuah card yang menampilkan informasi dasar siswa
    );
  }
}
