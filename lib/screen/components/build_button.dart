import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({
    Key? key,
    required this.text,
    required this.onPressed
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          backgroundColor: Colors.tealAccent,
          elevation: 20,
          shadowColor: Colors.black12,
          minimumSize: const Size.fromHeight(60)
        ),
        child: Text(text)
    );
  }
}
