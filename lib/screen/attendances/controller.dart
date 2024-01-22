import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildLeadingIcon(String? status) {
  return Icon(
    status == "Hadir" ? Icons.check_box : Icons.check_box_outline_blank,
    color: status == "Hadir" ? Colors.green : Colors.red,
  );
}

Color genColor(String? status) {
  return status == "Hadir" ? Colors.tealAccent : Colors.orange;
}


class AttendanceController extends GetxController {
  // Define the RxString
  var dropdownVal = "".obs;

  // Define the onChanged method
  void onChanged(String? newVal) {
    // Update the dropdownVal using the RxString value property
    dropdownVal.value = newVal ?? "";
  }
}