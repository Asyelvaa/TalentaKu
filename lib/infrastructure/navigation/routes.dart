class NavigationMenu {
  final String route;
  NavigationMenu(this.route);
}

class Routes {
  static Future<String> get initialRoute async {
    return LoginScreen;
  }

  static const String LoginScreen = '/login';
  static const String HOME_PAGE = '/home';
  static const String PROFILE_PAGE = '/profile';
  static const String DAILY_REPORT = '/daily-report';
  static const String CLASS_PAGE = '/class';
  static const String CLASS_DETAIL = '/class-detail';
  static const String STYLE_ALBUM = '/style-album';
  static const String ADD_EDIT_POST = '/add-edit-post';
  static const String NAVBAR = '/global_component';
}
