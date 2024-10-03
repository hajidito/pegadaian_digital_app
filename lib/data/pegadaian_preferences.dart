import 'package:shared_preferences/shared_preferences.dart';

class PegadaianPreferences {
  SharedPreferences preferences;

  PegadaianPreferences({required this.preferences});

  String IS_LOGGED_IN = "isLogged";
  String TOKEN = "token";
  String USER_ID = "user_id";

  bool isUserLoggedIn() {
    return preferences.getBool(IS_LOGGED_IN) ?? false;
  }

  setUserLoggedIn(bool isLogged) async {
    preferences.setBool(IS_LOGGED_IN, isLogged);
  }

  String? getUserToken() {
    return preferences.getString(TOKEN);
  }

  setUserToken(String token) async {
    preferences.setString(TOKEN, token);
  }

  String? getUserId() {
    return preferences.getString(USER_ID);
  }

  setUserId(String userId) async {
    preferences.setString(USER_ID, userId);
  }
}
