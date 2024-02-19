import 'package:flutter/material.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:get/get.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({
    Key? key,
    required this.hintText,
    // this.obsecureText = false,
    this.controller,
    this.suffixIcon,
  }) : super(key: key);

  final String hintText;
  // bool obsecureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return
      Obx(() =>
          TextField(
            controller: controller,
            obscureText: loginController.isSecure.value,
            decoration: InputDecoration(
              suffixIcon: hintText == "pass" ? IconButton(
                  onPressed: () => loginController.passObscure(),
                  icon: suffixIcon!) : suffixIcon, //suffixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.5
              ),
            ),
          )
      );
  }
}
