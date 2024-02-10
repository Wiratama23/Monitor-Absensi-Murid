import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:absensi_sd/screen/dashboard/components/profile.dart';
import 'package:absensi_sd/screen/dashboard/controller.dart';
import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class DashboardSiswa extends GetView<DashboardController> {
  DashboardSiswa({super.key});
  // String _nama = controller.nama;
  // Map<String, dynamic> data = DashboardController.data;
  // String _nama = data['nama_siswa'];
  // String _kelas = DashboardController.kelas;
  // static const String _nis = Dummy.nis;
  // String _images = DashboardController.image;
  // String _nis =




  @override
  Widget build(BuildContext context) {
    // aController.getAttendanceData(year: DateTime.now().year, month : DateTime.now().month);
    // print("DateTime.now().day = ${DateTime.now().day-1}");
    // print(aController.presensi);
    // String status = aController.cekStatus(DateTime.now().day-1);
    // print("status on dashboard : $status");
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
                  // Get.toNamed(Names.pageLogin);
                  controller.logout();
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
            Obx(
              ()=>
                  Profile(
                  name: controller.data.isNotEmpty ? controller.data[0]['nama_siswa']  : "unknown",
                  // kelas: _kelas,
                  image: controller.data.isNotEmpty ? controller.data[0]['foto']  : "unknown",
                  // nis: _nis
                  nis: controller.data.isNotEmpty ? controller.data[0]['nisn'] : "unknown" ,
              ),
            ),
            const SizedBox(height: 5),

            Obx(() =>
            // DateTime.now().weekday<6 ?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: controller.color.value,
                  child: Container(
                    height: 80,
                    child: Center(
                      child:  ListTile(
                        leading:Text(
                          DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: controller.widget.value,
                      ),
                    ),
                  ),
                ),
              ),
                      // : SizedBox(),
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
                    child: Center(
                      child: ListTile(
                        title: Text(DateFormat('MMMM yyyy').format(DateTime.now()), style: TextStyle(fontSize: 25)),
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
