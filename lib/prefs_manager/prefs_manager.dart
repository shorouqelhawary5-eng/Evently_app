import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static const String _themeKey = 'theme';
  static const String _langKey = 'lang';
  static const String _onBoardingCompletedKey = 'onboarding_completed';

  static Future<void> saveTheme(ThemeMode newTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(_themeKey, newTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  static Future<ThemeMode?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString(_themeKey);
    if (mode == null) {
      return null;
    } else {
      if (mode == 'dark') {
        return ThemeMode.dark;
      } else {
        return ThemeMode.light;
      }
    }
  }

  static Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, language);
  }

  static Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLang = prefs.getString(_langKey);
    if (savedLang == null) {
      return null;
    } else {
      if (savedLang == 'en') {
        return "en";
      } else {
        return "ar";
      }
    }
  }

  static Future<void> setOnBoardingCompleted(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBoardingCompletedKey, completed);
  }

  static Future<bool> isOnBoardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onBoardingCompletedKey) ?? false;
  }
}
