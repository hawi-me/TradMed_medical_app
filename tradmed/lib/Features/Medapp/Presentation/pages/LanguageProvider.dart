import 'package:flutter/material.dart';

class Languageprovider with ChangeNotifier {
  Locale _locale = Locale('en');
  Locale get locale => _locale;

  void switchLanguage(String languageCode) {
    if (languageCode == 'fr') {
      _locale = const Locale('fr');
    } else if (languageCode == 'es') {
      _locale = const Locale('es');
    } else if (languageCode == 'ar') {
      _locale = const Locale('ar');
    } else if (languageCode == 'en') {
      _locale = const Locale('en');
    }
    notifyListeners();
  }
}
