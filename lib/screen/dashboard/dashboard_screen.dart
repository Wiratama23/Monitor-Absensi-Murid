
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/dashboard/components/profile.dart';
import 'package:absensi_sd/screen/dashboard/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/drawer.dart';
import 'dart:math' as math;


class DashboardSiswa extends GetView<DashboardController> {
  DashboardSiswa({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
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
                  image: controller.data.isNotEmpty ? controller.data[0]['foto']  : "unknown",
                  nis: controller.data.isNotEmpty ? controller.data[0]['nisn'] : "unknown" ,
              ),
            ),
            const SizedBox(height: 5),
            Obx(
              () => controller.isLoading.value == true ?
              DateTime.now().weekday<6 ?
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
                            style: const TextStyle(fontSize: 18),
                          ),
                          trailing: controller.widget.value,
                        ),
                      ),
                    ),
                  ),
              ):const SizedBox() : const CircularProgressIndicator(),
            ),
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
                        title: Text("${controller.thisMonth} ${DateTime.now().year}", style: const TextStyle(fontSize: 25)),
                        subtitle: Text("Total Kehadiran: ${controller.present}/${controller.daysInMonth}"),
                        trailing: const Icon(Icons.calendar_month),
                      )
                    )
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
