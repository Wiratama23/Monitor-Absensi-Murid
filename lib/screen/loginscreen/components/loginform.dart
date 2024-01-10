import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:flutter/material.dart';

import 'buildform.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
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
          child: BuildForm(controller: controller),
        ),
      ),
    );
  }
}