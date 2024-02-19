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
    this.hide,
    this.loginController
  }) : super(key: key);

  final String hintText;
  // bool obsecureText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  bool? hide;


  LoginController? loginController ;

  @override
  Widget build(BuildContext context) {
    return
          TextField(
            controller: controller,
            obscureText: loginController!.isSecure.value,
            decoration: InputDecoration(
              suffixIcon: hintText == "pass" ? IconButton(
                  onPressed: () {
                    loginController!.passObscure(hide);
                  },
                  icon: hide! ? const Icon(Icons.visibility_off): const Icon(Icons.visibility)) : suffixIcon, //suffixIcon,
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14.5
              ),
            ),
          );

  }
}
