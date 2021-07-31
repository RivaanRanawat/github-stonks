import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:github_stonks/screens/home_screen.dart';
import 'package:github_stonks/screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(
    MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;

  @override
  void initState() {
    getUserData(context);
    super.initState();
  }

  void getUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("x-auth-token");
    if (token == null) {
      prefs.setString("x-auth-token", "");
      token = "";
    }
    var tokenCheckUri = Uri.parse("http://localhost:3001/tokenIsValid");
    var tokenRes = await http.post(tokenCheckUri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "x-auth-token": token!
    });

    var response = convert.jsonDecode(tokenRes.body);
    if (response == true) {
      http.Response userRes =
          await http.get(Uri.parse("http://localhost:3001/"), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "x-auth-token": token!,
      });
      var userData = convert.jsonDecode(userRes.body);
      Provider.of<UserProvider>(context, listen: false).setUserData(
          userData["budget"],
          userData["email"],
          userData["fullName"],
          userData["id"],
          token!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).getUserData();
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: user.token != "" ? HomeScreen() : SignupScreen(),
        debugShowCheckedModeBanner: false,
      ),
      designSize: const Size(360, 640),
    );
  }
}
