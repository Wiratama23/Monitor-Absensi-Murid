import 'package:absensi_sd/screen/globalcomponents/build_button.dart';
import 'package:absensi_sd/screen/globalcomponents/build_textfield.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:flutter/material.dart';

class BuildForm extends StatelessWidget {
  const BuildForm({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome",
          style: TextStyle(
              color: Colors.greenAccent,
              fontSize: 32,
              fontWeight: FontWeight.w500
          ),
        ),
        const Text("Login"),
        const SizedBox(height: 60),
        const Text("Student ID"),
        BuildTextField(
          hintText: "id",
          controller: controller.id,
        ),
        const SizedBox(height: 40),
        const Text("Password"),
        BuildTextField(
          hintText: "pass",
          obsecureText: controller.isSecure,
          controller: controller.pass,
        ),
        const SizedBox(height: 40),
        BuildButton(
            text: "Login",
            onPressed: (){
              debugPrint("Login Clicked");
            }
        ),
      ],
    );
  }
}