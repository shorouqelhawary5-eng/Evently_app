import 'package:evently_app/prefs_manager/prefs_manager.dart';
import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String currentLang = "en";

  void updateLang(String newLang) {
    currentLang = newLang;
    PrefsManager.saveLanguage(newLang);
    notifyListeners();
  }

  Future<void> getLang() async {
    final savedLang = await PrefsManager.getLanguage();
    currentLang = savedLang ?? "en";
    notifyListeners();
  }
}
