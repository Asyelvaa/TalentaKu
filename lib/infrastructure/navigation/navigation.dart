import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const ProfilePageScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => const HomePageScreen(),
      binding: HomePageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_PAGE,
      page: () => const ProfilePageScreen(),
      binding: ProfilePageControllerBinding(),
    ),
    GetPage(
      name: Routes.LAPORAN_HARIAN,
      page: () => const LaporanHarianScreen(),
      binding: LaporanHarianControllerBinding(),
    ),
    GetPage(
      name: Routes.GRADE,
      page: () => const GradeScreen(),
      binding: GradeControllerBinding(),
    ),
    GetPage(
      name: Routes.CLASS_DETAIL,
      page: () => const ClassDetailScreen(),
      binding: ClassDetailControllerBinding(),
    ),
  ];
}
