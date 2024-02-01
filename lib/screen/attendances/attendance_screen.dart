import 'dart:math' as math;

import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/attendances/components/attendance.dart';
import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceSiswa extends GetView<AttendanceController> {
  const AttendanceSiswa({super.key});

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
                  Get.toNamed(Names.pageDashboard);
                },
                child: SizedBox(
                    width: 50,
                    height: 20,
                    child:  const Icon(Icons.arrow_back_ios),
                    ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Center(
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    DropdownButton(
                      alignment: Alignment.center,
                        value: controller.currentMonth,
                        items: controller.months.map((String month) {
                          return DropdownMenuItem<String>(
                              value: month,
                              child: Text(month,
                                  style: const TextStyle(fontSize: 25)));
                        }).toList(),
                        // icon: const Icon(Icons.calendar_month),
                        onChanged: (String? newVal) {
                          controller.currentMonthIndex.value =
                              controller.months.indexOf(newVal!);
                        }),
                    const SizedBox(width: 10),
                    DropdownButton(
                        value: controller.currentYear.toString(),
                        items: controller.years.map((int years) {
                          return DropdownMenuItem<String>(
                              value: years.toString(),
                              child: Text(years.toString(),
                                  style: const TextStyle(fontSize: 25)));
                        }).toList(),
                        onChanged: (String? newVal) {
                          if (newVal != null) {
                            controller.currentYear.value = int.parse(newVal);
                          }
                        }),
                  ]),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.decrementMonth();
                        // print(controller.month.value);
                      },
                      child: const Text("Previous"),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.incrementMonth();
                      },
                      child: const Text("Next"),
                    ),
                  )
                ],
              ),
            ),
            Attendance(data: controller.presensi,controller: controller),
          ],
        ),
      ),
    );
  }
}
