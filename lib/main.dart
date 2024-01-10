import 'package:absensi_sd/routes/router.dart';
import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/loginscreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      popGesture: false,
      title: 'Absensi App',
      // home: const LoginScreen(),
      initialRoute: Names.pageLogin,
      getPages: Routes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}


