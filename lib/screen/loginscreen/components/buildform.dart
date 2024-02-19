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
          loginController: controller,
          suffixIcon: const Icon(Icons.person),
        ),
        const SizedBox(height: 40),
        const Text("Password"),
        Obx(() =>
            BuildTextField(
              hintText: "pass",
              loginController: controller,
              controller: controller.pass,
              hide: controller.isSecure.value,
            ),
        ),
        const SizedBox(height: 40),
        BuildButton(
            text: "Login",
            onPressed: () {
              FocusScope.of(context).unfocus();
              controller.Login(controller.id.text, controller.pass.text);
            }
        ),
      ],
    );
  }
}