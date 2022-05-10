import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test/api/api_url.dart';
import 'dart:convert';

import 'package:test/models/user.dart';
import 'package:test/preference/user_peference.dart';

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
  Status _loggedOutStatus = Status.LoggedIn;
  Status get loggedOutStatus => this._loggedOutStatus;

  set loggedOutStatus(Status value) => this._loggedOutStatus = value;
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
    Response response = await post(Uri.parse(ApiUrl.signupUrl),
        body: json.encode(apiBodyData),
        headers: {'Content-Type': 'application/json'});
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);
    if (response.statusCode == 200) {
      // UserPreference().saveUser(authUser);
      if (responseData['success']) {
        result = {
          'status': true,
          'message': 'Successfully Signup',
          'data': responseData
        };
      } else {
        result = {
          'status': false,
          'message': 'Account already exists',
        };
      }
    } else {
      _loggedInStatus = Status.NotSignedUp;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  notify() {
    notifyListeners();
  }

  // static Future<Map<String, dynamic>> onValue(Response response) async {
  //   var result;

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> responseData = json.decode(response.body);
  //     User authUser = User.fromJson(responseData);
  //     // UserPreference().saveUser(authUser);
  //     if (responseData['success']) {
  //       result = {
  //         'status': true,
  //         'message': 'Successfully Signup',
  //         'data': authUser
  //       };
  //     } else {
  //       result = {
  //         'status': false,
  //         'message': 'error',
  //       };
  //     }
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': 'Successfully Signup',
  //       // 'data': responseData
  //     };
  //   }
  //   return result;
  // }

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
        });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['success']) {
        User authUser = User.fromJson(responseData);
        UserPreference().saveUser(authUser);
        _loggedInStatus = Status.LoggedIn;
        notifyListeners();

        result = {'status': true, 'message': 'Successful', 'user': authUser};
      } else
        result = {
          'status': false,
          'message': 'Your account or password is incorrect!'
        };
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

  Future<Map<String, dynamic>> logout(String token) async {
    var result;
    notifyListeners();

    Response response = await get(Uri.parse(ApiUrl.logoutUrl),
        headers: {'Authorization': 'Bearer +${token}'});
    if (response.statusCode == 200) {
      UserPreference().removeUser();
      _loggedOutStatus = Status.LoggedOut;
      notifyListeners();

      result = {'status': true, 'message': 'Logout Successfully '};
    } else {
      result = {'status': false, 'message': 'Logout Error'};
    }
    return result;
  }

  // static onError(error) {
  //   print('the error is ${error.detail}');
  //   return {
  //     'status': false,
  //     'message': 'UnSuccessfully Request',
  //     'data': error
  //   };
  // }
}
