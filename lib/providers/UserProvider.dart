import 'package:flutter/material.dart';
import 'package:github_stonks/models/User.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User user = new User(budget: 0, email: '', fullName: '', id: '', );

  void setUserData(int budget, String email, String fullName, String id) {
    user.budget = budget;
    user.email = email;
    user.fullName = fullName;
    user.id = id;
    notifyListeners();
  }

  User getUserData() {
    return user;
  }
}