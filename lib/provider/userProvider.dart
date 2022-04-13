import 'package:flutter/cupertino.dart';
import 'package:test/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User();
  User get user => this._user;

  void setUser(User user) {
    _user = user;
  }

  notifyListeners();
}
