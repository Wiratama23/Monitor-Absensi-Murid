import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:absensi_sd/screen/dashboard/components/profile.dart';
import 'package:absensi_sd/screen/dashboard/controller.dart';
import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/navigationDrawer.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();






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
        key: _scaffoldKey,
        drawer: DrawerItem(controller: controller),
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
                  // controller.logout();
                  // Scaffold.of(context).openDrawer();
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: SizedBox(
                    width: 50,
                    height: 20,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: const Icon(Icons.menu),
                    )
                ),
              ),
            ),
            Obx(
              ()=>
                  Profile(
                  name: controller.data.isNotEmpty  ? controller.data[0]['nama_siswa']  : "unknown",
                  // kelas: _kelas,
                  image: controller.data.isNotEmpty ? controller.data[0]['foto']  : "unknown",
                  // nis: _nis
                  nis: controller.data.isNotEmpty ? controller.data[0]['nisn'] : "unknown" ,
              ),
            ),
            const SizedBox(height: 5),
            DateTime.now().weekday<6 ? Obx(() =>
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: controller.color.value,
                  child: Container(
                    height: 80,
                    child: Center(
                      child:  ListTile(
                        leading:Text(
                          "${controller.days[DateTime.now().weekday-1]}, ${DateTime.now().day} ${controller.months[DateTime.now().month-1]} ${DateTime.now().year}",
                          style: TextStyle(fontSize: 18),
                        ),
                        trailing: controller.widget.value,
                      ),
                    ),
                  ),
                ),
              )
            ):SizedBox(),
            const SizedBox(height: 20),
        //
            GestureDetector(
              onTap: (){
                Get.toNamed(Names.pageAttendance);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  color: Colors.tealAccent,
                  child: Container(
                    height: 200,
                    child: Center(
                      child:
                      Obx(() =>
                      ListTile(
                        title: Text("${controller.thisMonth} ${DateTime.now().year}", style: TextStyle(fontSize: 25)),
                        subtitle: Text("Total Kehadiran: ${controller.present}/${controller.daysInMonth}"),
                        trailing: Icon(Icons.calendar_month),
                      )
                    )
                    ),
                  ),
                ),
              ),
            )
        //
          ],
        ),
      ),
    );
  }


}
