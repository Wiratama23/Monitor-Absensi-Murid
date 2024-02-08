import 'dart:convert';

import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:flutter/cupertino.dart';
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

  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    savedat = shared!.get('user');
    data.add(jsonDecode(savedat));
    aController = AttendanceController();
    print("ini share preferences(dashboard) : $token");
    getData();
  }

  // Future<void> getData() async {
  //   print("${DateTime.now().month} - ${DateTime.now().year}");
  //   // print(aController);
  //   // await aController!.getAttendanceData(2023, 8);
  //   // datas.addAll(aController!.presensi.value);
  //   // print("ini data : ${datas.value}");
  //   // print(datas.length);
  // }

  var token;
  static const String urlPresensi = "http://bersekolah.web.id:8002/m_api/load_presensi_individu";
  Future<void> getData() async {
    var reqBody;
      reqBody = {
        'tahun':'${DateTime.now().year}',
        'bulan': '${DateTime.now().month}'
      };
    print("reqBody = $reqBody");
    var response = await http.post(
        Uri.parse(urlPresensi),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
        body:jsonEncode(reqBody)
    );
    // print("response : $response");
    // jsonResponse['status'] == 200
    // print("response.statusCode : ${response.statusCode}");
    var jsonResponse = jsonDecode(response.body);
    if(response.statusCode==200){
      if (jsonResponse.containsKey("data")) {
        var data = jsonResponse["data"];
        print("ini responsenya : $data");
        if (data is List) {
          // Clear the existing data before adding the new data
          datas.clear();

          // Add the new data to the presensi list
          datas.addAll(data);

          print("presensi.value on getAttendanceData(): ${datas.value}");
        } else {
          print("Invalid data format in the response.");
        }
      } else {
        print("Missing 'data' key in the response.");
      }
    } else {
      print("getAttendanceData() load data failed");
    }
    print("presensi.value on getAttendanceData() : ${datas.value}");
    print("presensi on getAttendanceData() : ${datas}");

  }

  void logout(){
        shared!.remove('token');
        shared!.remove('userid');
        shared!.remove('userpass');
        Get.offAndToNamed(Names.pageLogin);
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getData();
  }
}
