import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/prefs_manager/prefs_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    await Future.delayed(const Duration(milliseconds: 1200));

    final isOnBoardingCompleted = await PrefsManager.isOnBoardingCompleted();
    if (!mounted) return;

    if (!isOnBoardingCompleted) {
      Navigator.pushReplacementNamed(context, RoutesManager.onBoardingIntro);
      return;
    }

    final nextRoute = FirebaseAuth.instance.currentUser == null
        ? RoutesManager.login
        : RoutesManager.home;

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: FlutterLogo(size: 120)));
  }
}
