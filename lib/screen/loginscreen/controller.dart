import 'dart:convert';
import 'package:flutter/material.dart';
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
  Rx<IconData> obscureIcon = Icons.visibility_off.obs;
  RxBool isSecure = true.obs;
  late Size mediaSize;
  static const String url="http://bersekolah.web.id/m_api/login_siswa";

  Future<void> Login(String userId, String userPass) async {
    await shared?.setString('userid', userId);
    await shared?.setString('userpass', userPass);

    var reqBody = {
      "nisn": userId,
      "password": userPass
    };

    var response = await http.post(
        Uri.parse(url),
      headers: {"Content-Type":"application/json"},
      body: jsonEncode(reqBody)
    );
    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 200){
      await shared?.setString('token', jsonResponse['token'].toString());
      getProfileData();
    }
  }
  static const String urlSiswa="http://bersekolah.web.id:8002/m_api/profil_siswa";
  bool fetched = false;
  @override
  Future<void> onInit() async {
    super.onInit();
    fetched = false;
    shared = await SharedPreferences.getInstance();
    if(shared!.getString('token') != null){
      getProfileData();
    }
  }

  Future<void> getProfileData() async {
    try{
      fetched = true;
      token = shared!.getString('token');
      var response = await http.get(
        Uri.parse(urlSiswa),
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer $token'
        },
      );
      var jsonResponse = jsonDecode(response.body);
      Map<String, dynamic> responseData = {
        "foto": jsonResponse['foto'],
        "id_sekolah": jsonResponse['id_sekolah'],
        "nama_siswa": jsonResponse['nama_siswa'],
        "nisn": jsonResponse['nisn'],
        "user_id": jsonResponse['user_id']
      };
      String jsonData = jsonEncode(responseData);
      await shared?.setString('user', jsonData);
      Get.offAndToNamed(Names.pageDashboard);
    }catch (e){
      shared!.remove('token');
      var userid = shared!.getString('userid');
      var userpass = shared!.getString('userpass');
      Login(userid!, userpass!);
    }
  }

  void passObscure(bool? isSecures){
    if(isSecures!){
      isSecure.value=false;
    } else{
      isSecure.value=true;
    }
  }
  @override
  Future<void> onClose() async {
    super.onClose();
    if(fetched == false){
      await getProfileData();
    }
  }
}
