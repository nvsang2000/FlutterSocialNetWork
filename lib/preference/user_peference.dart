// ignore_for_file: deprecated_member_use

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/user.dart';

class UserPreference {
  Future<bool> saveUser(User user) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (user.username != null) {
      pref.setString('username', user.username!);
    }
    if (user.followers != null) {
      pref.setStringList('followers', user.followers!);
    }
    if (user.following != null) {
      pref.setStringList('following', user.following!);
    }
    // pref.setInt('gender', user.gender!);
    if (user.iduser != null) {
      pref.setString('_id', user.iduser!);
    }
    if (user.about != null) {
      pref.setString('about', user.about!);
    }
    if (user.gender != null) {
      pref.setInt('gender', user.gender!);
    }
    if (user.address != null) {
      pref.setString('address', user.address!);
    }
    if (user.birthday != null) {
      pref.setString('birthday', user.birthday!.toString());
    }
    if (user.avatarImage != null) {
      pref.setString('avatar', user.avatarImage!);
    }
    if (user.coverImage != null) {
      pref.setString('cover', user.coverImage!);
    }

    return pref.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? username = pref.getString("username");
    int? gender = pref.getInt('gender');
    String? token = pref.getString("token");
    String? iduser = pref.getString("_id");
    List<String>? following = pref.getStringList("following");
    List<String>? followers = pref.getStringList("followers");
    String? about = pref.getString("about");
    String? address = pref.getString("address");
    String? birthday = pref.getString("birthday");
    String? avatar = pref.getString("avatar");
    String? cover = pref.getString("cover");
    return User(
        // gender: gender,
        username: username,
        followers: followers,
        following: following,
        gender: gender,
        iduser: iduser,
        about: about,
        token: token,
        address: address,
        birthday: birthday,
        avatarImage: avatar,
        coverImage: cover);
  }

  void removeUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // pref.remove('email');
    // pref.remove('token');
    // pref.remove('username');
    await pref.clear();
  }

  Future<bool> saveToken(String token) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('token', token);

    return pref.commit();
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final String? token = await pref.getString('token');
    print("ss" + token!);
    return token;
  }

  Future<String?> getId() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? id = pref.getString('_id');
    print(id);
    return id;
  }
}
