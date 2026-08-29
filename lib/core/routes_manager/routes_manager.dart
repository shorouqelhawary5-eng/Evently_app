import 'package:evently_app/features/add_event/add_event.dart';
import 'package:evently_app/features/event_details/event_details_screen.dart';
import 'package:evently_app/features/home/home.dart';
import 'package:evently_app/features/on_boarding/on_boarding_screen.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:flutter/material.dart';

import '../../features/auth/login/login.dart';
import '../../features/auth/register/register.dart';

class RoutesManager {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addEvent = '/add_event';
  static const String onBoarding = '-on_boarding';
  static const String details = '/details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case addEvent:
        final EventModel? event = settings.arguments as EventModel?;

        return MaterialPageRoute(
          builder: (_) => AddEvent(event: event),
          settings: settings,
        );

      case onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());
      case details:
        return MaterialPageRoute(
          builder: (_) => EventDetailsScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
    }
  }
}
