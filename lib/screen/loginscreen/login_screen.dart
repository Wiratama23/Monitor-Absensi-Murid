import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/loginform.dart';
import 'components/logoimage.dart';

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
            child: LogoImage(controller: controller)
          ),
          Positioned(
            bottom: 0,
            child: LoginForm(controller: controller)
          )
        ],
      ),
    );
  }
}
