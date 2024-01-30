import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes_name.dart';

class AttendanceController extends GetxController {
  // final RxInt currentMonthIndex = 5.obs;
  // final RxInt currentYear = 2030.obs;
  SharedPreferences? shared;
  var token;
  final RxInt currentMonthIndex = (DateTime.now().month - 1).obs;
  final RxInt currentYear = DateTime.now().year.obs;
  List<int> years = [];
  List<Map<String, dynamic>> presensi = [];

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
  //
  // checkAttendanceToday(){
  //   pre
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

  static const String urlPresensi = "http://bersekolah.web.id:8002/m_api/load_presensi_individu";
  Future<void> getAttendanceData() async {
    var reqBody = {
      'tahun':'2023',
      'bulan': '8'
    };
    var response = await http.post(
        Uri.parse(urlPresensi),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body:jsonEncode(reqBody)
    );
    // jsonResponse['status'] == 200
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    presensi!.addAll(jsonResponse['data']);

    // // print(jsonResponse);
    // print(nisndat);
    // await shared?.setString('nisn', nisndat['nisn']);
    // var nisn = shared!.getString('nisn');
    // print("Nisn: $nisn");

  }

  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    getAttendanceData();
    print("ini share preferences :$token");
  }
}
