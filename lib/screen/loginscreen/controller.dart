import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController id = TextEditingController();
  final TextEditingController pass = TextEditingController();

  final bool isSecure = true;
  late Size mediaSize;


}
