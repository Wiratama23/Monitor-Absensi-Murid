import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes_name.dart';

class LoginController extends GetxController {
  TextEditingController id = TextEditingController();
  TextEditingController pass = TextEditingController();
  SharedPreferences? shared;
  var token;
  bool userlog = false;

  final bool isSecure = true;
  late Size mediaSize;
  static const String url="http://bersekolah.web.id/m_api/login_siswa";

  Future<void> Login(String userId, String userPass) async {

    var reqBody = {
      "nisn": userId,
      "password": userPass
    };

    var response = await http.post(
        Uri.parse(url),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(reqBody)
    );
    // jsonResponse['status'] == 200
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if(jsonResponse.containsKey('token')){
      var token = jsonResponse['token'].toString();
      print(jsonResponse);
      await shared?.setString('token', jsonResponse['token'].toString());
      Get.offAndToNamed(Names.pageDashboard);
      print("Token : $token");
    } else {
      print(response.statusCode);
      // Get.offAndToNamed(Names.pageDashboard);
      print("ape $jsonResponse");
    }

  }
  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    if(token != null){
      Get.offAndToNamed(Names.pageDashboard);
    }
    print("ini share preferences(login) :$token");
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   shared!.remove('token');
  // }

}
