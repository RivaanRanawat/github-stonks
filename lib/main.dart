import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:github_stonks/screens/login_screen.dart';
import 'package:github_stonks/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider())
          ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SignupScreen(),
          debugShowCheckedModeBanner: false,
        ),
      ),
      designSize: const Size(360, 640),
    );
  }
}
