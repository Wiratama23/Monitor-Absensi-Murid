import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    Key? key,
    required this.hintText,
    this.obsecureText = false,
    this.controller
  }) : super(key: key);

  final String hintText;
  final bool obsecureText;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obsecureText,
      decoration: InputDecoration(
        suffixIcon: obsecureText ? const Icon(Icons.remove_red_eye) : const Icon(Icons.person),
        // focusedBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15),
        //   borderSide: const BorderSide(color: Colors.greenAccent),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(15),
        //   borderSide: const BorderSide(color: Colors.blueAccent),
        // ),
        // border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.5
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12
        )
      ),
    );
  }
}
