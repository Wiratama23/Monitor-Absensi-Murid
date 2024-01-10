import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';

class DashboardSiswa extends StatelessWidget {
  const DashboardSiswa({super.key});
  static const String _nama = Dummy.nama;
  static const String _kelas = Dummy.kelas;
  static const String _nis = Dummy.nis;
  static const List<Map<String, String>> presensi = Dummy.presensi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: const Text("aloha"),
                  ),
                  const Column(
                    children: [
                      Text("Nama : " + _nama),
                      SizedBox(height: 10),
                      Text("Kelas : " + _kelas),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: presensi.length,
                  itemBuilder: (context, index) {
                    final String status = presensi[index]["status"].toString();
                    return BuildTile(
                      title: presensi[index]["day"].toString(),
                      subtitle: presensi[index]["date"],
                      trailing: status,
                      leading: buildLeadingIcon(status),
                      color: genColor(status),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLeadingIcon(String? status) {
    return Icon(
      status == "Hadir" ? Icons.check_box : Icons.check_box_outline_blank,
      color: status == "Hadir" ? Colors.green : Colors.red,
    );
  }

  Color genColor(String? status) {
    return status == "Hadir" ? Colors.tealAccent : Colors.orange;
  }
}
