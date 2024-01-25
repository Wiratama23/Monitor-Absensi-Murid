import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceController extends GetxController {
  // final RxInt currentMonthIndex = 5.obs;
  // final RxInt currentYear = 2030.obs;
  final RxInt currentMonthIndex = (DateTime.now().month - 1).obs;
  final RxInt currentYear = DateTime.now().year.obs;
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
  List<String> days = [
    "Senin",
    "Selasa",
    "Rabu",
    "kamis",
    "Jumat",
    "Sabtu",
    "Minggu"
  ];

  String get currentMonth => months[currentMonthIndex.value];

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
    } else if (currentMonthIndex.value >= months.length - 1 && currentYear < years.last) {
      currentYear.value++;
      currentMonthIndex.value = 0;
    }
  }

  void decrementMonth() {
    if (currentMonthIndex.value > 0) {
      currentMonthIndex.value--;
    } else if (currentMonthIndex.value <= 0 && currentYear > years.first) {
      currentYear.value--;
      currentMonthIndex.value = months.length - 1;
    }
  }

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
