import 'package:evently_app/features/home/home.dart';
import 'package:flutter/material.dart';

import '../../features/auth/login/login.dart';
import '../../features/auth/register/register.dart';

class RoutesManager {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      default:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
    }
  }
}
