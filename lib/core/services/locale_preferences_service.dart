import 'package:flutter_app/core/constants/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Reads and writes the chosen language on the device.
/// Storage errors are swallowed on purpose: failing to remember the
/// language must never crash the app, it just falls back to English.
class LocalePreferencesService {
  Future<String?> readLanguageCode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(StorageKeys.selectedLanguage);
    } catch (_) {
      return null;
    }
  }

  Future<void> saveLanguageCode(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageKeys.selectedLanguage, code);
    } catch (_) {
      // Ignored: see the class comment.
    }
  }
}