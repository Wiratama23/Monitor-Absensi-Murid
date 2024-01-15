import 'package:flutter/material.dart';

Widget buildLeadingIcon(String? status) {
  return Icon(
    status == "Hadir" ? Icons.check_box : Icons.check_box_outline_blank,
    color: status == "Hadir" ? Colors.green : Colors.red,
  );
}

Color genColor(String? status) {
  return status == "Hadir" ? Colors.tealAccent : Colors.orange;
}