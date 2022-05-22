import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

import 'package:test/api/api_url.dart';
import 'package:test/models/user.dart';
import 'package:test/preference/user_peference.dart';

class EditInforProvider extends ChangeNotifier {
  Future<User> getUser(String token, String id) async {
    Response response = await get(Uri.parse(ApiUrl.profileUrl + id),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      User authUser = User.fromJson(json.decode(response.body), token);
      UserPreference().saveUser(authUser);

      return authUser;
    } else {
      throw Exception('Failed to load.');
    }
  }

  Future<Map<String, dynamic>> editInfor(
      String data, String content, String id, String token) async {
    var result;
    Map<String, dynamic>? map;
    if (data == "gender") {
      map = {'$data': int.parse(content)};
    } else {
      map = {'$data': content};
    }

    Response response = await post(Uri.parse(ApiUrl.profileUrl + id),
        body: json.encode(map),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        });
    print(response.statusCode);
    print(response.headers);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success']) {
        result = {
          'status': true,
          'message': responseData['message'],
        };
      } else {
        result = {'status': false, 'message': responseData['message']};
      }
    } else {
      result = {
        'status': false,
      };
    }

    return result;
  }

  notify() {
    notifyListeners();
  }
}
