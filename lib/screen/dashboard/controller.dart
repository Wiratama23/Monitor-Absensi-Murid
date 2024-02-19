import 'dart:convert';

import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart' as login;


import '../../routes/routes_name.dart';

class DashboardController extends GetxController {
  AttendanceController? aController;
  SharedPreferences? shared;
  var savedat;

  RxList<dynamic> data = <Map<String, dynamic>>[].obs;
  RxList<dynamic> dataAttendance = [].obs;
  late String nama;
  late String image;
  static late String nis;
  final bool isSecure = true;
  late Size mediaSize;
  var token;
  RxString status = "".obs;
  Rx<Color> color = (Colors.grey).obs;
  RxString thisDay="Senin".obs;
  RxString thisMonth="Januari".obs;
  RxInt present = 0.obs;
  RxInt daysInMonth = 0.obs;
  RxBool isLoading = false.obs;

  List<String> days = [];
  List<String> months = [];

  Rx<Widget> widget = const Icon(Icons.question_mark_outlined, color: Colors.grey).obs; // Initialize with default widget

  // aController.getAttendanceData(year: DateTime.now().year, month : DateTime.now().month);
  // print("DateTime.now().day = ${DateTime.now().day-1}");
  // print(aController.presensi);
  // String status = aController.cekStatus(DateTime.now().day-1);
  // print("status on dashboard : $status");

  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    savedat = shared!.get('user');
    data.add(jsonDecode(savedat));
    aController = Get.find<AttendanceController>();
    print("ini share preferences(dashboard) : $token");
    getCurrentData();
  }

  void getCurrentData() async {
    await aController!.getAttendanceData(year: DateTime.now().year, month : DateTime.now().month);

    // aController.getAttendanceData(year: DateTime.now().year, month : DateTime.now().month);
    // print("DateTime.now().day = ${DateTime.now().day-1}");
    // print(aController.presensi);
    // print("DateTime.now().day on getCurrentData() : ${DateTime.now().day}");
    status.value = aController!.cekStatus(DateTime.now().day-1);
    if(status.value=="Hadir"){
      color.value = Colors.lightBlue;
    } else {
      color.value = Colors.orange;
    }
    // aController!.genColor(status.value)!;
    widget.value = aController!.buildLeadingIcon(status.value);
    // update();
    days.addAll(aController!.days);
    months.addAll(aController!.months);
    thisDay.value = days[DateTime.now().weekday-1];
    thisMonth.value = months[DateTime.now().month-1];
    countPresent();
    print(days);
    print(months);
    print("status on dashboard : $status");
    isLoading.value = true;
  }

  void countPresent(){
    daysInMonth.value = aController!.currentMonthDays(DateTime.now().year, DateTime.now().month);
    int minusDays = 0;
    for(int i=1;i<=daysInMonth.value;i++){
      DateTime date = DateTime(DateTime.now().year,DateTime.now().month,i);
      // print("weekday = ${date.weekday}");
      if(date.weekday >=6) minusDays++;
    }
    daysInMonth.value = daysInMonth.value-minusDays;
    print("daysInMonth.value = ${daysInMonth.value}");
    dataAttendance.value = aController!.presensi.value;
    DateTime? date=null;
    print("data.value = ${dataAttendance.value}");
    for(int i=0;i<dataAttendance.value.length;i++){
      print('data[i]["datang"] = ${dataAttendance[i]["datang"]}');
      print('data[i]["pulang"] = ${dataAttendance[i]["pulang"]}');
      DateTime newDate = DateTime.parse(dataAttendance[i]["datang"] != null
          ? dataAttendance[i]["datang"]
          : dataAttendance[i]["pulang"]);
      print(date==null||date.day!=newDate.day);
      if(date==null||date.day!=newDate.day){
        date = newDate;
        present.value++;
      }
    }
    print("present.value = ${present.value}");
  }

  void logout(){
        shared!.remove('token');
        shared!.remove('userid');
        shared!.remove('userpass');
        Get.offAllNamed(Names.pageLogin);
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    isLoading.value = false;
  }
  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   super.onReady();
  //   getData();
  // }
}
