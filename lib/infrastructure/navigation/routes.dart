class NavigationMenu {
  final String route;
  NavigationMenu(this.route);
}

class Routes {
  static Future<String> get initialRoute async {
    return LoginScreen;
  }

  static const ASSIGNMENT_PAGE = '/assignment-page';
  static const PROFILE_USER = '/profile-user';
  static const REPORT_LIST_PAGE = '/report-list-page';
  static const REPORT_LIST_USER_PAGE = '/report-list-user-page';
  static const STUDENT_REPORT_FORM = '/student-report-form';
  static const String ADD_EDIT_POST = '/add-edit-post';
  static const String ALBUM_FORM_PAGE = '/album-form-page';
  static const String CLASS_DETAIL = '/class-detail';
  static const String CLASS_PAGE = '/class';
  static const String DAILY_REPORT = '/daily-report';
  static const String HOME_PAGE = '/home';
  static const String LoginScreen = '/login';
  static const String NAVBAR = '/global_component';
  static const String PICK_IMAGE = '/pickimage';
  static const String PROFILE_PAGE = '/profile';
  static const String STYLE_ALBUM = '/style-album';
  static const TASK_PAGE = '/task-page';
  static const EDIT_REPORT_USER_PAGE = '/edit-report-user-page';
}
