import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes_name.dart';

class DashboardController extends GetxController {
  SharedPreferences? shared;
  var token;

  final bool isSecure = true;
  late Size mediaSize;
  static const String urlSiswa="http://bersekolah.web.id:8002/m_api/profil_siswa";

  Future<void> getProfileData() async {

    var response = await http.get(
        Uri.parse(urlSiswa),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
    );
    // jsonResponse['status'] == 200
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);

  }


  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    getProfileData();
    print("ini share preferences :$token");
  }

// @override
// void onClose() {
//   super.onClose();
//   shared!.remove('token');
// }

}
