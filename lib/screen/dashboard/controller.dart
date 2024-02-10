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

  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  RxList<dynamic> datas = [].obs;
  late String nama;
  late String image;
  static late String nis;
  final bool isSecure = true;
  late Size mediaSize;
  var token;
  RxString status = "".obs;
  Rx<Color> color = (Colors.grey).obs;

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
    await aController!.getAttendanceData(DateTime.now().year, DateTime.now().month);
    // aController.getAttendanceData(year: DateTime.now().year, month : DateTime.now().month);
    // print("DateTime.now().day = ${DateTime.now().day-1}");
    // print(aController.presensi);
    status.value = aController!.cekStatus(6);
    color.value = aController!.genColor(status.value)!;
    widget.value = aController!.buildLeadingIcon(status.value);
    // update();
    print("status on dashboard : $status");
  }

  void logout(){
        shared!.remove('token');
        shared!.remove('userid');
        shared!.remove('userpass');
        Get.offAndToNamed(Names.pageLogin);
  }
  // @override
  // void onReady() {
  //   // TODO: implement onReady
  //   super.onReady();
  //   getData();
  // }
}
