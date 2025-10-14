import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChanageLanguageProvider extends ChangeNotifier {
  String currentLanguage = 'en';

  ChanageLanguageProvider() {
    _loadLanguage(); // 👈 تحميل اللغة عند تشغيل التطبيق
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLang = prefs.getString('language_code');
    if (savedLang != null) {
      currentLanguage = savedLang;
      notifyListeners();
    }
  }

  Future<void> changeLanguge(String newLanguage) async {
    currentLanguage = newLanguage;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLanguage); // 👈 حفظ اللغة
  }
}
