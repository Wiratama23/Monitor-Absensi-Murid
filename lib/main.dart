import 'package:absensi_sd/routes/router.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      popGesture: false,
      title: 'Absensi App',
      initialRoute: Names.pageLogin,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}


