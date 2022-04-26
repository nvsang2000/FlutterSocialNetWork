import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/user.dart';

class UserPreference {
  Future<bool> saveUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var us = user.username;
    if (us != null) {
      pref.setString('email', us);
      print(us);
    }
    var tk = user.token;
    if (tk != null) {
      pref.setString('token', user.token!);
      print(tk);
    }

    return pref.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? username = pref.getString("email");
    String? token = pref.getString("token");

    return User(username: username, token: token);
  }

  void removeUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.remove('email');
    // pref.remove('token');
    // pref.remove('username');
    pref.clear();
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    return token;
  }
}
