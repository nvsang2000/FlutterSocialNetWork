import 'package:flutter/cupertino.dart';
import 'package:test/models/user.dart';

// ignore_for_file: type=lint
class UserProvider extends ChangeNotifier {
  User _user = User();
  User get user => this._user;

  void setUser(User user) {
    _user = user;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   notifyListeners();
    //   // Add Your Code here.
    // });
  }

  notifyListeners();
}
