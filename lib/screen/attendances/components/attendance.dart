import 'package:flutter/material.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.scrollController.animateTo(
        controller.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    return
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          ListView.builder(
              controller: controller.scroll(),
              scrollDirection: Axis.vertical,
              itemCount: count,
              itemBuilder: (context, index) {
                String status = controller.cekStatus(index);
                DateTime date = DateTime(controller.currentYear.value,controller.currentMonthIndex.value + 1,index + 1);
                return
                  date.weekday<6?BuildTile(
                    title: controller.days[date.weekday-1],
                    subtitle: "${date.day} ${controller.months[date.month-1]} ${date.year}",
                    trailing: status,
                    leading: controller.buildLeadingIcon(status),
                    color: controller.genColor(status),
                  ):const SizedBox();
              }),
        ),
      );
  }
}