import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
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
  RxInt itemCount = RxInt(0);
  SharedPreferences? shared;
  var token;
  RxInt currentMonthIndex = (DateTime.now().month - 1).obs;
  RxInt currentYear = DateTime.now().year.obs;
  // final RxInt currentMonthIndex = 8.obs;
  // final RxInt currentYear = 2023.obs;
  List<int> years = [];
  RxList<dynamic> presensi = [].obs;

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

  String cekStatus(DateTime? datang, DateTime? pulang){
    String status = "Tidak hadir";
    if(datang!=null||pulang!=null){
      if(datang == DateTime.now() || pulang == DateTime.now()){
        status = "Hadir";
      }
    }
    return status;
  }

  void currentMonthDays(int year, int month){
    int days=0;
    if(DateTime.now().year == year && DateTime.now().month == month){
      days = DateTime.now().day;
    } else {
      days = DateTime(year,month).day;
    }
    print("print $days");
    itemCount.value = days;
    update();
    print("itemkon ${itemCount.value}");
  }

  DateTime? extractDate(String dateTimeString) {
    if (dateTimeString != null && dateTimeString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      print("Extracted Date : ${DateTime(dateTime.year, dateTime.month, dateTime.day)}");
      return DateTime(dateTime.year, dateTime.month, dateTime.day);
    } else {
      print("Extracted Date Error");
      return null;
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

  static const String urlPresensi = "http://bersekolah.web.id:8002/m_api/load_presensi_individu";
  Future<void> getAttendanceData() async {
    var reqBody = {
      'tahun':'${currentYear}',
      'bulan': '${currentMonthIndex}'
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
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    getAttendanceData();
    currentMonthDays(DateTime.now().month - 1, DateTime.now().year);
    print("ini share preferences :$token");
    // update();
  }

}
