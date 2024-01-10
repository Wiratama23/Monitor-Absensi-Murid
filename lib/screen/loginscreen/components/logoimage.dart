import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget {
  const LogoImage({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
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
}