import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final RxInt currentMonthIndex = 5.obs;
  final RxInt currentYear = 2030.obs;
  List<int> years = [];

  // List of months
  List<String> months = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  String get currentMonth => months[currentMonthIndex.value];
  // int get selectedYear => selectedYear;
  // int get currentYear => years[currentYearIndex.value];

  List<int> genYears(RxInt currentYear) {
    List<int> years = [];
    for (int i = 3; i >= 1; i--) {
      years.add(currentYear.value - i);
    }
    years.add(currentYear.value);
    for (int i = 1; i <= 3; i++) {
      years.add(currentYear.value + i);
    }
    return years;
  }

  AttendanceController() {
    years = genYears(currentYear);

  }

  void incrementMonth() {
    if (currentMonthIndex.value < months.length - 1) {
      currentMonthIndex.value++;
    } else if (currentMonthIndex.value > months.length - 1) {
      currentYear.value++;
      // currentYearIndex.value++;
      currentMonthIndex.value = 0;
    }
  }

  void decrementMonth() {
    if (currentMonthIndex.value > 0) {
      currentMonthIndex.value--;
    } else if (currentMonthIndex.value < 0) {
      currentYear.value--;
      // currentYearIndex.value--;
      currentMonthIndex.value = months.length - 1;
    }
  }

  // void incrementYear() {
  //   if (currentYearIndex.value < years.length - 1) {
  //     currentYearIndex.value++;
  //   }
  // }

  // void decrementYear() {
  //   if (currentYearIndex.value > 0) {
  //     currentYearIndex.value--;
  //   }
  // }

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
