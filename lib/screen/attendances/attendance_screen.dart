import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/attendances/components/attendance.dart';
import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class AttendanceSiswa extends GetView<AttendanceController> {
  const AttendanceSiswa({super.key});
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
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: GestureDetector(
                onTap: () {
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
                    )),
              ),
            ),
            const SizedBox(height: 40),
            Center(child: Text("Januari 2024", style: TextStyle(fontSize: 40))),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Previous"),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Next"),
                    ),
                  )
                ],
              ),
            ),
            DropdownButton<String>(
                // value: controller.dropdownVal.value,
                value: "januari",
                icon: const Icon(Icons.calendar_month),
                items: const [
                  DropdownMenuItem<String>(
                      value: "januari", child: Text("Januari")),
                  DropdownMenuItem<String>(
                      value: "februari", child: Text("Februari")),
                  DropdownMenuItem<String>(
                      value: "maret", child: Text("Maret")),
                ],
                onChanged: (String? newVal) {
                  controller.onChanged(newVal);
                }),
            // const Profile(
            //     name: _nama,
            //     kelas: _kelas,
            //     image: _images,
            //     nis: _nis),
            // const SizedBox(height: 2),
            const Attendance(data: presensi),
          ],
        ),
      ),
    );
  }
}
