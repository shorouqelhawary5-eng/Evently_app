import 'package:evently_app/prefs_manager/prefs_manager.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.dark;

  void updateTheme(ThemeMode newTheme) {
    currentTheme = newTheme;
    PrefsManager.saveTheme(currentTheme);
    notifyListeners();
  }

  Future<void> getSavedTheme() async {
    final savedTheme = await PrefsManager.getTheme();

    currentTheme = (savedTheme == ThemeMode.dark)
        ? ThemeMode.dark
        : ThemeMode.light;

    notifyListeners();
  }
}
