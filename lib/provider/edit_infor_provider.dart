import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:test/api/api_url.dart';
import 'package:test/models/user.dart';
import 'package:test/preference/user_peference.dart';

class EditInforProvider extends ChangeNotifier {
  Future<User> getUser(String token, String id) async {
    http.Response response = await http.get(Uri.parse(ApiUrl.profileUrl + id),
        headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      User authUser = User.fromJson(json.decode(response.body), token);
      UserPreference().saveUser(authUser);

      return authUser;
    } else {
      throw Exception('Failed to load.');
    }
  }

  Future<void> uploadImage(String file, String token) async {
    print("file name $file");
    var result;
    var request = http.MultipartRequest('PATCH', Uri.parse(ApiUrl.updateImage));
    request.files.add(await http.MultipartFile.fromPath("upload_avatar", file));
    http.Response responses = await http.patch(Uri.parse(ApiUrl.updateImage),
        body: {
          'upload_avatar': file
        },
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'multipart/form-data'
        });
    // request.headers.addAll({
    //   'Authorization': 'Bearer ' + token,
    //   'Content-Type': 'multipart/form-data'
    // });
    // var response = await request.send();
    if (responses.statusCode == 200) {
      print("upload ok");
    } else {
      print("connect fail");
    }
    return result;
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

    http.Response response = await http.post(Uri.parse(ApiUrl.profileUrl + id),
        body: json.encode(map),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(response.headers);
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
