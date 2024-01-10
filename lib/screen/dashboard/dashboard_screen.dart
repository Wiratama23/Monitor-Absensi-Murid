import 'package:absensi_sd/screen/globalcomponents/build_tile.dart';
import 'package:flutter/material.dart';

class DashboardSiswa extends StatelessWidget {
  const DashboardSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: const Text("aloha"),
                  ),
                  const Column(
                    children: [
                      Text("suka2 idCard"),
                      SizedBox(height: 10),
                      Text("suka2 idCard"),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return BuildTile();
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
