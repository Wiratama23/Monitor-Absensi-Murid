import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:absensi_sd/screen/loginscreen/login_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final pages = [
    GetPage(
      name: Names.pageLogin,
      page: () => const LoginScreen(),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      })
    ),
  ];
}