import 'package:flutter/material.dart';
import 'package:github_stonks/models/User.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User user = new User(budget: 0, email: '', fullName: '', id: '', token: '');

  void setUserData(int budget, String email, String fullName, String id, String token) {
    user.budget = budget;
    user.email = email;
    user.fullName = fullName;
    user.id = id;
    user.token = token;
    notifyListeners();
  }

  User getUserData() {
    return user;
  }
}
