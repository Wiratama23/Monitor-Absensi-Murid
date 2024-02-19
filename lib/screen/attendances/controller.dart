
import 'package:date_utilities/date_utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AttendanceController extends GetxController {
  RxInt itemCount = RxInt(0);
  SharedPreferences? shared;
  var token;
  RxInt currentMonthIndex = (DateTime.now().month - 1).obs;
  RxInt currentYear = DateTime.now().year.obs;
  List<int> years = [];
  RxList<dynamic> presensi = [].obs;
  RxList<String> monthsForYear = [""].obs;
  final ScrollController scrollController = ScrollController();

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

  void updateMonthsList(){
    monthsForYear.clear();
    if(DateTime.now().year==currentYear.value){
      for(int i=0;i<(DateTime.now().month);i++){
        monthsForYear.add(months[i]);
      }
    } else {
      for(int i=0;i<12;i++){
        monthsForYear.add(months[i]);
      }
    }

  }

  void newVal({String? year, String? month}){
    if (year != null) {
      if(int.parse(year)==DateTime.now().year){
        currentMonthIndex.value=DateTime.now().month-1;
      }
      currentYear.value =
          int.parse(year);
    }
    if(month !=null){
      currentMonthIndex.value =
          months.indexOf(month);
    }
    updateData();
  }

  void updateData(){
    currentMonthDays(currentYear.value, currentMonthIndex.value+1);
    getAttendanceData();
    updateMonthsList();
  }



  List<int> genYears(RxInt currentYear) {
    List<int> years = [];
    for (int i = 4; i >= 1; i--) {
      years.add(currentYear.value - i);
    }
    years.add(currentYear.value);
    return years;
  }

  AttendanceController() {
    years = genYears(currentYear);
    updateMonthsList();
  }

  void incrementMonth() {
    if (currentMonthIndex.value < months.length - 1) {
      if((currentYear.value == DateTime.now().year) && (currentMonthIndex.value+1 < DateTime.now().month)) {
        currentMonthIndex.value++;
      }else if(currentYear.value < DateTime.now().year){
        currentMonthIndex.value++;
      }
    } else if ((currentMonthIndex.value >= months.length - 1) && (currentYear < years.last)) {
      currentYear.value++;
      currentMonthIndex.value = 0;
    }
    updateData();

  }

  void decrementMonth() {
    if (currentMonthIndex.value > 0) {
      currentMonthIndex.value--;
    } else if (currentMonthIndex.value <= 0 && currentYear > years.first) {
      currentYear.value--;
      currentMonthIndex.value = months.length - 1;
    }
    updateData();
  }

  String cekStatus(int index){
    String status="Tidak Hadir";
    DateTime dateIndex = DateTime(currentYear.value,currentMonthIndex.value+1,index+1);
    DateTime? date;
    for(var i=0;i<presensi.length;i++){
      if(presensi[i]["datang"]!=null){
        date = DateTime.parse(presensi[i]["datang"]);
      } else {
        date = DateTime.parse(presensi[i]["pulang"]);
      }
      if(date.year==dateIndex.year && date.month==dateIndex.month && date.day==dateIndex.day){
        status = "Hadir";
      }
    }

    return status;
  }

  int currentMonthDays(int year, int month){
    int days=0;
    var cek = (DateTime.now().year == year && DateTime.now().month == month);
    if(cek){
      days = DateTime.now().day;
    } else {
      days = (dateutil.daysInMonth(currentMonthIndex.value+1, currentYear.value))!;
    }
    itemCount.value = days;
    update();
    return days;
  }

  DateTime? extractDate(String dateTimeString) {
    if (dateTimeString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateTime(dateTime.year, dateTime.month, dateTime.day);
    } else {
      return null;
    }
  }

  Widget buildLeadingIcon(String? status) {
    return Icon(
      status == "Hadir" ? Icons.check_box : Icons.check_box_outline_blank,
      color: status == "Hadir" ? Colors.black : Colors.red,
    );
  }

  Color genColor(String? status) {
    return status == "Hadir" ? Colors.cyanAccent : Colors.orange;
  }

  static const String urlPresensi = "http://bersekolah.web.id:8002/m_api/load_presensi_individu";
  Future<void> getAttendanceData({int? year, int? month}) async {

    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
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
    var response = await http.post(
        Uri.parse(urlPresensi),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body:jsonEncode(reqBody!)
    );

    var jsonResponse = jsonDecode(response.body);
    if(response.statusCode==200){
      if (jsonResponse.containsKey("data")) {
        var data = jsonResponse["data"];

        if (data is List) {
          presensi.clear();
          presensi.addAll(data);
        } else {
        }
      } else {
      }
    } else {
    }

  }

  final dateutil = DateUtilities();

  ScrollController? scroll(){
    if(currentYear.value==DateTime.now().year&&currentMonthIndex.value+1==DateTime.now().month) {
      return scrollController;
    } else {
      return null;
    }
  }

}
