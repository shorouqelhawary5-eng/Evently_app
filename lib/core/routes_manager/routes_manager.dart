import 'package:evently_app/features/add_event/add_event.dart';
import 'package:evently_app/features/home/home.dart';
import 'package:evently_app/features/on_boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';

import '../../features/auth/login/login.dart';
import '../../features/auth/register/register.dart';

class RoutesManager {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addEvent = '/add_event';
  static const String onBoarding = '-on_boarding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case addEvent:
        return MaterialPageRoute(builder: (_) => AddEvent());
      case onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());

      default:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
    }
  }
}
