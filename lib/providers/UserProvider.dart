import 'package:flutter/material.dart';
import 'package:github_stonks/models/User.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User _user = new User(budget: 0, email: '', fullName: '', id: '', token: '');

  void setUserData(double budget, String email, String fullName, String id, String token) {
    _user.budget = budget;
    _user.email = email;
    _user.fullName = fullName;
    _user.id = id;
    _user.token = token;
    notifyListeners();
  }

  User getUserData() {
    return _user;
  }
}
