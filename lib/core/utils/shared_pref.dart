import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? prefs;
  static const String authTokenKey = 'authToken';
  static const String hasSeenOnboarding = 'hasSeenOnboarding';

  SharedPrefs() {
    init();
  }
  Future<void> init() async {
    prefs ??= await SharedPreferences.getInstance();
    //debugPrint("SharedPrefs initialized");
  }

  static Future<bool> isFirstTimeLaunch() async {
    return prefs!.containsKey(hasSeenOnboarding);
  }

  // save the auth token
  static Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(authTokenKey, token);
  }

  //  retrieve the auth token
  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(authTokenKey);
    //debugPrint('Token: $token');
    return token;
  }

  //  clear the auth token
  static Future<void> clearAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(authTokenKey);
  }
}
