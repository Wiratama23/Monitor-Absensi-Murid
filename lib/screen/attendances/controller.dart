import 'dart:ffi';

import 'package:date_utilities/date_utilities.dart';
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
  RxInt currentDataIndex = 0.obs;
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

  List<String> days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
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

  // AttendanceController() {
  //   years = genYears(currentYear);
  //   // getAttendanceData();
  //   print("presensi on AttendanceController() = $presensi");
  //   print("presensi.value on AttendanceController() = ${presensi.value}");
  //
  // }

  void incrementMonth() {
    if (currentMonthIndex.value < months.length - 1) {
      currentMonthIndex.value++;
    } else if (currentMonthIndex.value >= months.length - 1 && currentYear < years.last) {
      currentYear.value++;
      currentMonthIndex.value = 0;
    }
    currentMonthDays(currentYear.value, currentMonthIndex.value+1);
    getAttendanceData(currentYear.value, currentMonthIndex.value);

  }

  void decrementMonth() {
    if (currentMonthIndex.value > 0) {
      currentMonthIndex.value--;
    } else if (currentMonthIndex.value <= 0 && currentYear > years.first) {
      currentYear.value--;
      currentMonthIndex.value = months.length - 1;
    }
    currentMonthDays(currentYear.value, currentMonthIndex.value+1);
    getAttendanceData(currentYear.value, currentMonthIndex.value);

  }

  String cekStatus(int index){
    print("-----------------------------------");
    String status="Tidak Hadir";
    DateTime dateIndex = DateTime(currentYear.value,currentMonthIndex.value+1,index+1);
    DateTime? date;
    String? use;
    for(var i=0;i<presensi.length;i++){
      if(presensi[i]["datang"]!=null){
        // print('presensi[currentDataIndex.value]["datang"]:${presensi[currentDataIndex.value]["datang"]}');
        use = "pulang";
        date = DateTime.parse(presensi[i]["datang"]);
      } else {
        use = "pulang";
        date = DateTime.parse(presensi[i]["pulang"]);
      }
      if(date.year==dateIndex.year && date.month==dateIndex.month && date.day==dateIndex.day){
        status = "Hadir";
      }
    }

    print("use '$use' date $date");
    print("status on $dateIndex = $status");
    print("-----------------------------------");
    return status;
  }

  void currentMonthDays(int year, int month){
    int days=0;
    // print("year on currentMonthDays:$year");
    // print("month on currentMonthDays:$month");
    // print("DateTime.now().year : ${DateTime.now().year}");
    // print("DateTime.now().month : ${DateTime.now().month}");
    var cek = (DateTime.now().year == year && DateTime.now().month == month);
    print("cek on currentMonthDays() : $cek");
    if(cek){
      days = DateTime.now().day;
      print("is this day? days : $days");
    } else {
      days = (dateutil.daysInMonth(currentMonthIndex.value+1, currentYear.value))!;
      print("else days : $days");
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
  Future<void> getAttendanceData(int? year, int? month) async {
    var reqBody;
    if(year==null&&month==null){
      reqBody = {
        'tahun':'${currentYear.value}',
        'bulan': '${currentMonthIndex.value+1}'
      };
    } else {
      reqBody = {
        'tahun':'$year',
        'bulan': '$month'
      };
    }
    print("reqBody = $reqBody");
    var response = await http.post(
        Uri.parse(urlPresensi),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body:jsonEncode(reqBody!)
    );
    // print("response : $response");
    // jsonResponse['status'] == 200
    print("response.statusCode : ${response.statusCode}");
    var jsonResponse = jsonDecode(response.body);
    if(response.statusCode==200){
      if (jsonResponse.containsKey("data")) {
        var data = jsonResponse["data"];

        if (data is List) {
          // Clear the existing data before adding the new data
          presensi.clear();

          // Add the new data to the presensi list
          presensi.addAll(data);

          print("presensi.value on getAttendanceData(): ${presensi.value}");
        } else {
          print("Invalid data format in the response.");
        }
      } else {
        print("Missing 'data' key in the response.");
      }
    } else {
      print("getAttendanceData() load data failed");
    }
    print("presensi.value on getAttendanceData() : ${presensi.value}");
    print("presensi on getAttendanceData() : ${presensi}");

  }

  final dateutil = DateUtilities();
  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    // currentMonthDays(DateTime.now().month - 1, DateTime.now().year);
    // print("itemCount.value onInit() : ${itemCount.value}");
    // print("on init DateTime.now().month - 1, DateTime.now().year : ${DateTime.now().month - 1}, ${DateTime.now().year}");
    // // print("${DateTime(year,month).day}");
    // print("ini share preferences :$token");
    // // print("${dateutil.}")
    // print("on init DateTime.now().day.days.inDays : ${DateTime.now().day.days.inDays}");
    // print("on init DateTime.now().day.days : ${DateTime.now().day.days}");
    // print("on init DateTime.now().day : ${DateTime.now().day}");
    //
    // print("ini total ${dateutil.daysInMonth(DateTime.now().month - 1, DateTime.now().year)}");
    update();
  }

}
