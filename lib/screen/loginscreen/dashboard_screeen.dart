import 'package:flutter/material.dart';
import 'package:absensi_sd/dummyData/dummy.dart';
import 'package:absensi_sd/screen/components/build_list.dart';

import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  final String _namaSiswa = DummyData.nama;
  final String _nisSiswa = DummyData.nis;
  final String _kelasSiswa = DummyData.kelas;
  final String _imageSiswa = DummyData.imagePath;
  final List<Map<String, String>> _data = DummyData.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          automaticallyImplyLeading: false,
        ),
        body: BuildList(data: _data));
  }
}
