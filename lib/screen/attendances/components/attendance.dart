import 'package:flutter/material.dart';

import '../../globalcomponents/build_tile.dart';
import '../controller.dart';

class Attendance extends StatelessWidget{
  Attendance({
    Key? key,
    required this.data,
  }):super(key:key);

  final List<Map<String, String>> data;
  final AttendanceController controller = AttendanceController();

  @override
  Widget build(BuildContext context){
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final String status = data[index]["status"].toString();
              return BuildTile(
                title: data[index]["day"].toString(),
                subtitle: data[index]["date"],
                trailing: status,
                leading: controller.buildLeadingIcon(status),
                color: controller.genColor(status),
              );
            }),
      ),
    );
  }
}