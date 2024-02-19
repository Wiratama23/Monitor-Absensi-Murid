import 'package:absensi_sd/screen/dashboard/components/drawerhead.dart';
import 'package:absensi_sd/screen/dashboard/components/menuitems.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:absensi_sd/screen/dashboard/controller.dart';
import 'dart:math' as math;

import 'package:get/get.dart';


class DrawerItem extends StatelessWidget {
  DrawerItem({
    required this.controller
  });

  DashboardController controller;

  @override
  Widget build(BuildContext context) =>
      Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(
                  () =>
                  BuildHeader(
                    image: controller.data.isNotEmpty ? controller
                        .data[0]['foto'] : "unknown",
                    nama: controller.data[0]['nama_siswa'] ?? "Unknown",
                  ),
            ),
            // buildHeader(context),
            BuildMenuItems(
              title: "Attendance",
              icons: const Icon(Icons.calendar_month),
              tap: () => Get.toNamed(Names.pageAttendance),
            ),
            BuildMenuItems(
              title: "Logout",
              icons: const Icon(Icons.logout),
              tap: () => controller.logout(),
              transform: true,
            ),

            // SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            // GestureDetector(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 15.0),
            //     child: Container(
            //       height: 100,
            //       // width: 50,
            //       decoration: BoxDecoration(
            //         color: Colors.red
            //       ),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(15.0),
            //             child: Container(
            //               height: 50,
            //               width: 50,
            //               decoration: BoxDecoration(
            //                   color: Colors.blue
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Divider(
            //     height: 1,
            //     thickness: 1,
            //     color: Colors.black,
            //   ),
            // ),
            // BuildMenuItems(
            //   title: "Logout",
            //   icons: const Icon(Icons.logout),
            //   tap: ()=>controller.logout(),
            //   transform: true,
            // ),
          ],
        ),
      );
}