import 'package:date_utilities/date_utilities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../globalcomponents/build_tile.dart';
import '../controller.dart';

class Attendance extends StatelessWidget{
  Attendance({
    Key? key,
    required this.data,
    required this.controller
  }):super(key:key);

  int i=0;
  final List<dynamic> data;
  final AttendanceController controller;

  @override
  Widget build(BuildContext context){
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          Obx(
             () =>
                  ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.itemCount.value, //data.length,
                itemBuilder: (context, index) {
                  // var dataPresensi = data[i];
                  // print("dataPresensi : $dataPresensi");
                  // DateTime extractedDatang =
                  //     controller.extractDate(dataPresensi['datang'])!;
                  // print("extractedDatang : $extractedDatang");
                  // DateTime extractedPulang =
                  //     controller.extractDate(dataPresensi['pulang'])!;
                  // print("extractedPulang : $extractedPulang");
                  // final String status =
                  //     controller.cekStatus(extractedDatang, extractedPulang);
                  // print("Status : $status");
                  // if (status == "Hadir") i++;
                  return BuildTile(
                    title: DateFormat('EEEE','id').format(DateTime(
                        controller.currentYear.value,
                        controller.currentMonthIndex.value + 1,
                        index + 1)),
                    //data[0][index]["day"].toString(),
                    subtitle: DateFormat("d MMMM yyyy").format(DateTime(controller.currentYear.value,
                            controller.currentMonthIndex.value + 1, index + 1))
                        .toString(),
                    // trailing: status,
                    // leading: controller.buildLeadingIcon(status),
                    // color: controller.genColor(status),
                  );
                }),
          ),
        ),
      );
  }
}