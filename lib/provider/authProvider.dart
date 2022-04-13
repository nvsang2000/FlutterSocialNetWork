import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test/api/apiUrl.dart';
import 'dart:convert';

import 'package:test/models/user.dart';
import 'package:test/preference/userPreference.dart';

enum Status {
  NotLoggedIn,
  NotSignedUp,
  LoggedIn,
  SignedUp,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _signedUpStatus = Status.NotSignedUp;
  Status get loggedInStatus => this._loggedInStatus;

  set loggedInStatus(Status value) => this._loggedInStatus = value;

  get signedUpStatus => this._signedUpStatus;

  set signedUpStatus(value) => this._signedUpStatus = value;
  Future<Map<String, dynamic>> signup(String username, String password) async {
    final Map<String, dynamic> apiBodyData = {
      'email': username,
      'password': password,
      'confirmPassword': password,
      'username': username
    };

    _signedUpStatus = Status.Registering;
    return await post(Uri.parse(ApiUrl.signupUrl),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static Future<Map<String, dynamic>> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      var userData = responseData['data'];
      print(userData);
      User authUser = User.fromJson(responseData);
      // UserPreference().saveUser(authUser);
      print(responseData);
      result = {
        'status': true,
        'message': 'Successfully Signup',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Successfully Signup',
        'data': responseData
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    var result;
    final Map<String, dynamic> loginData = {
      'email': username,
      'password': password
    };
    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    Response response = await post(Uri.parse(ApiUrl.loginUrl),
        body: json.encode(loginData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic ZGlzYXBpdXNlcjpkaXMjMTIz',
          'X-ApiKey': 'ZGlzIzEyMw=='
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData);

      var userData = responseData['data'];
      print(userData);
      User authUser = User.fromJson(responseData);

      UserPreference().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print('the error is ${error.detail}');
    return {
      'status': false,
      'message': 'UnSuccessfully Request',
      'data': error
    };
  }
}
