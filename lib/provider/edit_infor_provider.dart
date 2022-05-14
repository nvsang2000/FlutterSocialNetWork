import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/user.dart';
import 'package:test/preference/user_peference.dart';
import 'package:test/provider/user_provider.dart';

class EditInforProvider extends ChangeNotifier {
  Future<User> getUser(String token, String id) async {
    Response response = await get(Uri.parse(ApiUrl.profileUrl + id),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      User authUser = User.fromJson(json.decode(response.body));
      UserPreference().saveUser(authUser);

      print(authUser);
      return authUser;
    } else
      throw Exception('Failed to load.');
  }

  notify() {
    notifyListeners();
  }

  Future<Map<String, dynamic>> editInfor(
      String data, String content, String id, String token) async {
    var result;

    final Map<String, dynamic> map = {'$data': content};
    Response response = await post(Uri.parse(ApiUrl.profileUrl + id),
        body: json.encode(map),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success']) {
        getUser(token, id);
        var user = UserPreference().getUser();
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
}
