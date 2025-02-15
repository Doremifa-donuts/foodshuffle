import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  final String _JWT_KEY = 'token';
  Future<String?> GetJWT() async => await SharedPreferences.getInstance()
      .then((pref) => pref.getString(_JWT_KEY));

  Future<void> SetJWT(String token) async =>
      await SharedPreferences.getInstance()
          .then((pref) => pref.setString(_JWT_KEY, token));
}
