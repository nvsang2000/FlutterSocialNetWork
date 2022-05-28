import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/friend.dart';

class FriendProvider extends ChangeNotifier {
  UserFriend? userFriend;
  Future<UserFriend> getUser(String token, String id) async {
    Response response = await get(Uri.parse(ApiUrl.profileUrl + id),
        headers: {'Authorization': 'Bearer ' + token});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      userFriend = UserFriend(
          about: responseData['data']['about'],
          address: responseData['data']['address'],
          avartaImage: responseData['data']['avatar'],
          birthday: responseData['data']['birthday'],
          coverImage: responseData['data']['cover'],
          gender: responseData['data']['gender'],
          username: responseData['data']['username']);

      notifyListeners();
      return userFriend!;
    } else {
      throw Exception('Failed to load.');
    }
  }

  get friendInfo {
    return userFriend;
  }
}
