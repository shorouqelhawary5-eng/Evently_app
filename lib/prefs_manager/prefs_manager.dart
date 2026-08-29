import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static Future<void> saveTheme(ThemeMode newTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('theme', newTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  static Future<ThemeMode?> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString('theme');
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
    await prefs.setString('lang', language);
  }

  static Future<String?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLang = prefs.getString('lang');
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
}
