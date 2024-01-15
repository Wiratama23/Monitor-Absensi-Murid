import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/globalcomponents/build_button.dart';
import 'package:absensi_sd/screen/globalcomponents/build_textfield.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        const Align(
          alignment: Alignment.center,
          child: Text(
            "Absensi Siswa",
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 32,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(height: 60),
        const Text("Silahkan Login Terlebih Dahulu"),
        const SizedBox(height: 10),
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
              // Get.offAndToNamed(Names.pageDashboard);
              controller.Login(controller.id.text, controller.pass.text);
            }
        ),
      ],
    );
  }
}