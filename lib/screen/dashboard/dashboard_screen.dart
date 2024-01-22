import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/dashboard/components/profile.dart';
import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class DashboardSiswa extends StatelessWidget {
  const DashboardSiswa({super.key});
  static const String _nama = Dummy.nama;
  static const String _kelas = Dummy.kelas;
  static const String _nis = Dummy.nis;
  static const String _images = Dummy.image;
  static const List<Map<String, String>> presensi = Dummy.presensi;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (bool didpop){Get.toNamed(Names.pageLogin);},
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,top: 8.0),
              child: GestureDetector(
                onTap: (){
                  //adding logout function.........
                  Get.toNamed(Names.pageLogin);
                },
                child: SizedBox(
                    width: 50,
                    height: 20,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: const Icon(Icons.logout),
                    )
                ),
              ),
            ),
            const Profile(
                name: _nama,
                kelas: _kelas,
                image: _images,
                nis: _nis),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                color: Colors.tealAccent,
                child: Container(
                  height: 80,
                  child: const Center(
                    child: ListTile(
                      leading: Text("Senin, 22 Januari 2024", style: TextStyle(fontSize: 18)),
                      trailing: Icon(Icons.check),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                Get.toNamed(Names.pageAttendance);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.limeAccent,
                  child: Container(
                    height: 200,
                    child: const Center(
                      child: ListTile(
                        title: Text("Januari 2024", style: TextStyle(fontSize: 25)),
                        subtitle: Text("Total Kehadiran: 10/28"),
                        trailing: Icon(Icons.calendar_month),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}
