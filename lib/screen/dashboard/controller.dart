import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart' as login;


import '../../routes/routes_name.dart';

class DashboardController extends GetxController {
  SharedPreferences? shared;
  var savedat;

  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  late String nama;
  late String image;
  static late String nis;

  final bool isSecure = true;
  late Size mediaSize;

  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    savedat = shared!.get('user');
    data.add(jsonDecode(savedat));
    print("ini share preferences(dashboard) :");
  }

 void logout(){
      shared!.remove('token');
      shared!.remove('userid');
      shared!.remove('userpass');
      Get.offAndToNamed(Names.pageLogin);
    // if(shared!.containsKey('token')){
    // }
 }
}
