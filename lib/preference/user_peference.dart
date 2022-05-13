// ignore_for_file: deprecated_member_use

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/user.dart';

class UserPreference {
  Future<bool> saveUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (user.username != null) {
      pref.setString('username', user.username!);
    }
    if (user.token != null) {
      pref.setString('token', user.token!);
    }
    if (user.iduser != null) {
      pref.setString('_id', user.iduser!);
    }
    if (user.about != null) {
      pref.setString('about', user.about!);
    }
    if (user.address != null) {
      pref.setString('address', user.address!);
    }
    if (user.birthday != null) {
      pref.setString('birthday', user.birthday!.toString());
    }
    if (user.avartaImage != null) {
      pref.setString('avarta', user.avartaImage!);
    }
    if (user.coverImage != null) {
      pref.setString('cover', user.coverImage!);
    }
    return pref.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? username = pref.getString("username");
    String? token = pref.getString("token");
    String? iduser = pref.getString("_id");
    String? about = pref.getString("about");
    String? address = pref.getString("address");
    String? birthday = pref.getString("birthday");
    String? avarta = pref.getString("avarta");
    String? cover = pref.getString("cover");
    return User(
        username: username,
        token: token,
        iduser: iduser,
        about: about,
        address: address,
        birthday: birthday,
        avartaImage: avarta,
        coverImage: cover);
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

  Future<String?> getId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('_id');
    return id;
  }
}
