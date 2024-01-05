import 'package:absensi_sd/screen/components/build_textfield.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 80,
            child: logoImage()
          ),
          Positioned(
            bottom: 0,
            child: loginForm()
          )
        ],
      ),
    );
  }

  Widget logoImage() {
    return SizedBox(
      width: controller.mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_sharp,
            size: 100,
            color: Colors.blue,
          ),
          Text(
            "data",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              letterSpacing: 2
            ),
          ),
        ],
      ),
    );
  }

  Widget loginForm() {
    return SizedBox(
      width: controller.mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
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
          hintText: "kick",
          controller: controller.id,
        ),
        const SizedBox(height: 40),
        const Text("Password"),
        BuildTextField(
          hintText: "pass",
          obsecureText: controller.isSecure,
          controller: controller.pass,
        ),
      ],
    );
  }
}
