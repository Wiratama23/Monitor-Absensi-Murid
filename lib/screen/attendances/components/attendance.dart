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
  // final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      controller.scrollController.animateTo(
        controller.scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    return
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          ListView.builder(
              // controller: controller.scrollController,
              // reverse: controller.reverse(),
              controller: controller.scroll(),
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
                    subtitle: "${date.day} ${controller.months[date.month-1]} ${date.year}",//DateFormat("d MMMM yyyy").format(date).toString(),
                    trailing: status,
                    leading: controller.buildLeadingIcon(status),
                    color: controller.genColor(status),
                  ):SizedBox();
              }),
        ),
      );
  }
}