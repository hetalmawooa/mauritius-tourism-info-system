import 'package:flutter/foundation.dart';
import '../data/translations.dart';

enum Language { en, fr, cr }

class LanguageProvider with ChangeNotifier {
  Language _currentLanguage = Language.en;

  Language get currentLanguage => _currentLanguage;

  String get languageCode {
    switch (_currentLanguage) {
      case Language.en:
        return 'en';
      case Language.fr:
        return 'fr';
      case Language.cr:
        return 'cr';
    }
  }

  Map<String, String> get translate {
    switch (_currentLanguage) {
      case Language.en:
        return Translations.en;
      case Language.fr:
        return Translations.fr;
      case Language.cr:
        return Translations.cr;
    }
  }

  void setLanguage(Language language) {
    _currentLanguage = language;
    notifyListeners();
  }

  void toggleLanguage() {
    if (_currentLanguage == Language.en) {
      _currentLanguage = Language.fr;
    } else if (_currentLanguage == Language.fr) {
      _currentLanguage = Language.cr;
    } else {
      _currentLanguage = Language.en;
    }
    notifyListeners();
  }
}