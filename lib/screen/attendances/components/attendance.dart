import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../globalcomponents/build_tile.dart';
import '../controller.dart';

class Attendance extends StatelessWidget {
  Attendance({
    Key? key,
    required this.data,
    required this.controller,
    required this.count
  }) :super(key: key);

  int count;
  List<dynamic> data;
  final AttendanceController controller;

  @override
  Widget build(BuildContext context) {
    print("data on attendance.dart : $data");
    // print("controller.itemCount.value on attendance : ${controller.itemCount
    //     .value}");
    // controller.currentDataIndex.value = 0;
    return
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: count, //data.length,
              itemBuilder: (context, index) {
                String status = controller.cekStatus(index);
                print("index on attendance = $index");
                DateTime date = DateTime(controller.currentYear.value,controller.currentMonthIndex.value + 1,index + 1);
                print("day : ${date.weekday}");
                return
                  date.weekday<6?BuildTile(
                    title: controller.days[date.weekday-1],//DateFormat('EEEE').format(date),
                    subtitle: "${index + 1} ${controller.months[controller.currentMonthIndex.value]} ${controller.currentYear.value}",//DateFormat("d MMMM yyyy").format(date).toString(),
                    trailing: status,
                    leading: controller.buildLeadingIcon(status),
                    color: controller.genColor(status),
                  ):SizedBox();
              }),
        ),
      );
  }
}