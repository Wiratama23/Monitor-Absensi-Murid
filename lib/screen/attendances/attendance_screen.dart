
import 'package:absensi_sd/screen/attendances/components/attendance.dart';
import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceSiswa extends GetView<AttendanceController> {
  const AttendanceSiswa({super.key});
  @override
  Widget build(BuildContext context) {
    controller.currentMonthDays(controller.currentYear.value, controller.currentMonthIndex.value+1);
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8.0),
              child: GestureDetector(
                onTap: () {
                  Get.back(canPop: false);
                },
                child: const SizedBox(
                  width: 50,
                  height: 20,
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
              child: Center(
                child:
                Obx(
                      () =>
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DropdownButton(
                                alignment: Alignment.center,
                                value: controller.currentMonth,
                                items: controller.monthsForYear.map((String month) {
                                  return DropdownMenuItem<String>(
                                      value: month,
                                      child: Text(month,
                                          style: const TextStyle(
                                              fontSize: 25)));
                                }).toList(),
                                onChanged: (String? newVal) {
                                  controller.newVal(month : newVal);
                                }
                                ),
                            const SizedBox(width: 10),
                            DropdownButton(
                                value: controller.currentYear.value.toString(),
                                items: controller.years.map((int years) {
                                  return DropdownMenuItem<String>(
                                      value: years.toString(),
                                      child: Text(years.toString(),
                                          style: const TextStyle(
                                              fontSize: 25)));
                                }).toList(),
                                onChanged: (String? newVal) {
                                  controller.newVal(year: newVal);

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
            Obx(() =>
                Attendance(
                    data: controller.presensi.value, controller: controller,count: controller.itemCount.value),
            )
          ],
        ),
      ),
    );
  }
}
