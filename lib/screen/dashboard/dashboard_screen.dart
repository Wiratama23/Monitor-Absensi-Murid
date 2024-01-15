import 'package:absensi_sd/dummyData.dart';
import 'package:absensi_sd/main.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/globalcomponents/build_button.dart';
import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class DashboardSiswa extends StatelessWidget {
  const DashboardSiswa({super.key});
  static const String _nama = Dummy.nama;
  static const String _kelas = Dummy.kelas;
  static const String _nis = Dummy.nis;
  static const String _images = Dummy.image;
  static const List<Map<String, String>> presensi = Dummy.presensi;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvoked: (bool didpop){Get.toNamed(Names.pageLogin);},
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,top: 8.0),
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(Names.pageLogin);
                },
                child: const SizedBox(
                  width: 50,
                  height: 20,
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 2.0,
                  left: 16.0,
                  right: 16.0
              ),
              child: Card(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0,left: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                            height: 150,
                            width: 150,
                            child: Image.asset(_images, fit: BoxFit.fill)
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                    const Column(
                      children: [
                        Text(_nama),
                        SizedBox(height: 10),
                        Text("Kelas - $_kelas"),
                        SizedBox(height: 10),
                        Text(_nis)
                      ],
                    )
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 2),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: presensi.length,
                    itemBuilder: (context, index) {
                      final String status = presensi[index]["status"].toString();
                      return BuildTile(
                        title: presensi[index]["day"].toString(),
                        subtitle: presensi[index]["date"],
                        trailing: status,
                        leading: buildLeadingIcon(status),
                        color: genColor(status),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }


}
