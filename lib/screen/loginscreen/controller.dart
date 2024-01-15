import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../routes/routes_name.dart';

class LoginController extends GetxController {
  TextEditingController id = TextEditingController();
  TextEditingController pass = TextEditingController();

  final bool isSecure = true;
  late Size mediaSize;
  static const String url="http://bersekolah.web.id:8002/m_api/login_siswa";

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

    var jsonResponse = jsonDecode(response.body);
    if(jsonResponse['status'] == 200){
      var token = jsonResponse['token'].toString();
      print("Token : $token");
      Get.offAndToNamed(Names.pageDashboard);
    } else {
      print(jsonResponse);
    }

  }
}
