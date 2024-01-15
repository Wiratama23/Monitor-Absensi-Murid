import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/main.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/dashboard/components/attendance.dart';
import 'package:absensi_sd/screen/dashboard/components/profile.dart';
import 'package:absensi_sd/screen/globalcomponents/build_button.dart';
import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'controller.dart';

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
                  Get.toNamed(Names.pageLogin);
                  //adding logout function.........
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
            // const SizedBox(height: 2),
            const Attendance(data: presensi),
          ],
        ),
      ),
    );
  }


}
