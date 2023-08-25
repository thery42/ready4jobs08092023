import 'package:shared_preferences/shared_preferences.dart';

class StayConnectedManager {
  static Future<void> setStayLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('stayLoggedIn', value);
  }

  static Future<bool> getStayLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('stayLoggedIn') ?? false;
  }
}
