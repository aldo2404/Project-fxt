import 'package:flutter/material.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/screens/forgotpasspage.dart';
import 'package:fx_project/screens/loginpage.dart';

class ScreenRouteGenerator {
  static Route<dynamic> routeGenerator(RouteSettings settings) {
    settings.arguments;

    switch (settings.name) {
      case '/loginpage':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/passwordforgotpage':
        return MaterialPageRoute(builder: (_) => PasswordForgotPage());
      case '/environmentpage':
        return MaterialPageRoute(builder: (_) => EnvironmentPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
