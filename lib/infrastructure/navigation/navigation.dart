import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter_talentaku/presentation/submission_page/submission_complete_page.screen.dart';

import '../../config.dart';
import '../../presentation/common_widget/navigation_menu.dart';
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
      name: Routes.LoginScreen,
      page: () => LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.PICK_IMAGE,
      page: () => PickImageScreen(),
      binding: PickimageControllerBinding(),
    ),
    GetPage(name: Routes.NAVBAR, page: () => NavbarMenu(), bindings: [
      HomePageControllerBinding(),
      ProfilePageControllerBinding(),
      ClassDetailControllerBinding(),
    ]),
    GetPage(
      name: Routes.HOME_PAGE,
      page: () => HomePageScreen(),
      binding: HomePageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_PAGE,
      page: () => ProfilePageScreen(),
      binding: ProfilePageControllerBinding(),
    ),
    GetPage(
      name: Routes.DAILY_REPORT,
      page: () => DailyReportScreen(),
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
      name: Routes.ALBUM_FORM_PAGE,
      page: () => const AlbumFormScreen(),
      binding: AlbumFormControllerBinding(),
    ),
    GetPage(
      name: Routes.ASSIGNMENT_PAGE,
      page: () => const AssignmentPageScreen(),
      binding: AssignmentPageControllerBinding(),
    ),
    GetPage(
      name: Routes.STUDENT_REPORT_FORM,
      page: () => const StudentReportFormScreen(),
      binding: StudentReportFormControllerBinding(),
    ),
    GetPage(
      name: Routes.SUBMISSION_PAGE,
      page: () => const SubmissionCompletePageScreem(),
      binding: SubmissionPageControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE_USER,
      page: () => ProfileUserScreen(),
      binding: ProfileUserControllerBinding(),
    ),
    GetPage(
      name: Routes.REPORT_LIST_PAGE,
      page: () => const ReportListPageScreen(),
      binding: ReportListPageControllerBinding(),
    ),
    GetPage(
      name: Routes.REPORT_LIST_USER_PAGE,
      page: () => const ReportListUserPageScreen(),
      binding: ReportListUserPageControllerBinding(),
    ),
    GetPage(
      name: Routes.EDIT_REPORT_USER_PAGE,
      page: () => const EditReportUserPageScreen(),
      binding: EditReportUserPageControllerBinding(),
    ),
  ];
}
