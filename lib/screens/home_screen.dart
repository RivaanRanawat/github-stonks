import 'package:flutter/material.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data =
        Provider.of<UserProvider>(context, listen: false).getUserData();
    print("data + ${data.fullName}");
    return Scaffold(
      body: Center(
        child: Text(data.fullName),
      ),
    );
  }
}
