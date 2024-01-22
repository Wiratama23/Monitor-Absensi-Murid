import 'package:absensi_sd/routes/routes_name.dart';
import 'package:absensi_sd/screen/attendances/attendance_screen.dart';
import 'package:absensi_sd/screen/attendances/controller.dart';
import 'package:absensi_sd/screen/dashboard/dashboard_screen.dart';
import 'package:absensi_sd/screen/loginscreen/controller.dart';
import 'package:absensi_sd/screen/loginscreen/login_screen.dart';
import 'package:get/get.dart';

class Routes {
  static final pages = [
    GetPage(
      name: Names.pageLogin,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(seconds: 1),
      binding: BindingsBuilder(() {
        Get.put(LoginController());
      })
    ),
    GetPage(
        name: Names.pageDashboard,
        transition: Transition.circularReveal,
        transitionDuration: const Duration(seconds: 1),
        page: () => const DashboardSiswa(),
        // binding: BindingsBuilder(() {
        //   Get.put(LoginController());
        // })
    ),
    GetPage(
      name: Names.pageAttendance,
      transition: Transition.circularReveal,
      transitionDuration: const Duration(seconds: 1),
      page: () => const AttendanceSiswa(),
      binding: BindingsBuilder(() {
        Get.put(AttendanceController());
      })
    ),
  ];
}