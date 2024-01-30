import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart' as login;

import '../../routes/routes_name.dart';

class DashboardController extends GetxController {
  SharedPreferences? shared;
  var token;

  RxList<Map<String, dynamic>> data = <Map<String, dynamic>>[].obs;
  late String nama;
  late String image;
  static late String nis;

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
    data.add(jsonResponse);
    print(jsonResponse);
    //nama = data['nama_siswa'];
    //image = data['foto'];

  }

  @override
  Future<void> onInit() async {
    super.onInit();
    shared = await SharedPreferences.getInstance();
    token = shared!.getString('token');
    await getProfileData();
    print("ini share preferences(dashboard) :$token");
  }

 void logout(){
    if(shared!.containsKey('token')){
      shared!.remove('token');
      Get.offAndToNamed('/login');
    }

 }
}
