import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  final RxInt currentMonthIndex = 5.obs;

  // List of months
  List<String> months = [
    "Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"
  ];
  
  String get currentMonth => months[currentMonthIndex.value];

  void incrementMonth() {
    if (currentMonthIndex.value < months.length - 1) {
      currentMonthIndex.value++;
    }
  }

  void decrementMonth() {
    if (currentMonthIndex.value > 0) {
      currentMonthIndex.value--;
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