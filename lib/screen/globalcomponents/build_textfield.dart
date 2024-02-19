import 'package:flutter/material.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({
    Key? key,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.hide,
    this.loginController
  }) : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  bool? hide;
  LoginController? loginController;
  @override
  Widget build(BuildContext context) {
    return
      TextField(
        keyboardType: hintText=="NISN"?TextInputType.visiblePassword:null,
        controller: controller,
        obscureText: hintText=="id"?false:loginController!.isSecure.value,
        decoration: InputDecoration(
          suffixIcon: hintText == "Password" ? IconButton(
              onPressed: () {
                loginController!.passObscure(hide);
              },
              icon: hide! ? const Icon(Icons.visibility_off) : const Icon(
                  Icons.visibility)) : suffixIcon, //suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14.5
          ),
        ),
      );
  }
}
