import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveUserData({
    required String email,
    required String name,
    required String gender,
    required String favoriteGenre,
  }) async {
    await _prefs?.setString('user_email', email);
    await _prefs?.setString('user_name', name);
    await _prefs?.setString('gender', gender);
    await _prefs?.setString('favoriteGenre', favoriteGenre);
  }

  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'email': prefs.getString('user_email') ?? "",
      'name': prefs.getString('user_name') ?? "User",
      'gender': prefs.getString('gender') ?? "Pria",
      'favoriteGenre': prefs.getString('favoriteGenre') ?? "",
    };
  }

  static Future<void> clearUserData() async {
    await _prefs?.remove('user_name');
    await _prefs?.remove('gender');
    await _prefs?.remove('favoriteGenre');
  }
}
