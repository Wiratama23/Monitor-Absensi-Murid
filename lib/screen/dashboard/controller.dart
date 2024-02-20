import 'dart:convert';

import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

  Rx<Widget> widget = const Icon(Icons.question_mark_outlined, color: Colors.grey).obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    savedat = shared!.get('user');
    data.add(jsonDecode(savedat));
    aController = Get.find<AttendanceController>();
    getCurrentData();
  }

  void getCurrentData() async {
    await aController!.getAttendanceData(year: DateTime.now().year, month : DateTime.now().month);
    status.value = aController!.cekStatus(DateTime.now().day-1);
    if(status.value=="Hadir"){
      color.value = Colors.lightBlue;
    } else {
      color.value = Colors.orange;
    }
    widget.value = aController!.buildLeadingIcon(status.value);
    days.addAll(aController!.days);
    months.addAll(aController!.months);
    thisDay.value = days[DateTime.now().weekday-1];
    thisMonth.value = months[DateTime.now().month-1];
    countPresent();
    isLoading.value = true;
  }

  void countPresent(){
    daysInMonth.value = aController!.currentMonthDays(DateTime.now().year, DateTime.now().month);
    int minusDays = 0;
    for(int i=1;i<=daysInMonth.value;i++){
      DateTime date = DateTime(DateTime.now().year,DateTime.now().month,i);
      if(date.weekday >=6) minusDays++;
    }
    daysInMonth.value = daysInMonth.value-minusDays;
    dataAttendance.value = aController!.presensi.value;
    DateTime? date;
    for(int i=0;i<dataAttendance.value.length;i++){
      DateTime newDate = DateTime.parse(dataAttendance[i]["datang"] ?? dataAttendance[i]["pulang"]);
      if(date==null||date.day!=newDate.day){
        date = newDate;
        present.value++;
      }
    }
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
}
