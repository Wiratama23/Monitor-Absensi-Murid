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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset("assets/logo.png", fit: BoxFit.fill)
              ),
            ),
          ),
          const Text(
            "SDN 2 Beji Kota Batu",
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
            ),
          ),
        ],
      ),
    );
  }
}