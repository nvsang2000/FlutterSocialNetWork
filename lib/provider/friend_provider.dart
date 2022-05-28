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
          followers: List<String>.from(responseData['data']['followers']),
          following: List<String>.from(responseData['data']['following']),
          id: responseData['data']['_id'],
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

  Future<void> follow(String token, String id, bool isFollow) async {
    var url;
    if (isFollow)
      url = ApiUrl.unfollowUrl;
    else
      url = ApiUrl.followUrl;

    Response response = await post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        },
        body: json.encode({'userId': id}));
    if (response.statusCode == 200) {
      print("Ok");
    } else
      ("Not ok");
  }
}
