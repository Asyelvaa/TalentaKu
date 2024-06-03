import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_talentaku/presentation/album_page/album_detail_page.screen.dart';

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
        name: Routes.DAILY_REPORT,
        page: () => const DailyReportScreen(),
        binding: DailyReportControllerBinding(),
      ),
      GetPage(
        name: Routes.CLASS_PAGE,
        page: () => ClassScreen(),
        binding: GradeControllerBinding(),
      ),
      GetPage(
        name: Routes.CLASS_DETAIL,
        page: () => const ClassDetailScreen(),
        binding: ClassDetailControllerBinding(),
      ),
      GetPage(
        name: Routes.STYLE_ALBUM,
        page: () => const StyleAlbumScreen(),
        binding: StyleAlbumControllerBinding(),
      ),
      GetPage(
        name: Routes.ADD_EDIT_POST,
        page: () => const AddEditPostScreen(),
        binding: AddEditPostControllerBinding(),
      ),
    ];
  }
