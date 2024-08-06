class NavigationMenu {
  final String route;
  NavigationMenu(this.route);
}

class Routes {
  static Future<String> get initialRoute async {
    return LoginScreen;
  }

  static const String ADD_EDIT_POST = '/add-edit-post';
  static const String ALBUM_FORM_PAGE = '/album-form-page';
  static const String ASSIGNMENT_PAGE = '/assignment-page';
  static const String CLASS_DETAIL = '/class-detail';
  static const String CLASS_PAGE = '/class-page';
  static const String DAILY_REPORT = '/daily-report';
  static const String EDIT_REPORT_USER_PAGE = '/edit-report-user-page';
  static const String HOME_PAGE = '/home-page';
  static const String LoginScreen = '/login';
  static const String NAVBAR = '/navbar';
  static const String PICK_IMAGE = '/pick-image';
  static const String PROFILE_PAGE = '/profile-page';
  static const String PROFILE_USER = '/profile-user';
  static const String REPORT_LIST_PAGE = '/report-list-page';
  static const String REPORT_LIST_USER_PAGE = '/report-list-user-page';
  static const String STUDENT_REPORT_FORM = '/student-report-form';
  static const String STYLE_ALBUM = '/style-album';
  static const String SUBMISSION_PAGE = '/submission-page';
  static const String TASK_PAGE = '/task-page';
  static const SPLASHSCREEN = '/splashscreen';
}
