import 'package:flutter/material.dart';
import 'package:github_stonks/models/User.dart';
import 'package:github_stonks/providers/UserProvider.dart';
import 'package:github_stonks/screens/home_screen.dart';
import 'package:github_stonks/screens/login_screen.dart';
import 'package:github_stonks/universal_variables.dart';
import 'package:github_stonks/widgets/text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void signUpUser(BuildContext context) async {
    try {
      var uri = Uri.parse("http://localhost:3001/api/signup");
      var res = await http.post(uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: convert.jsonEncode(<String, String>{
            "email": emailController.text,
            "fullName": fullNameController.text,
            "password": passwordController.text,
            "confirmPassword": confirmPasswordController.text
          }));
      var response = convert.jsonDecode(res.body);

      switch (res.statusCode) {
        case 200:
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Account Created!")));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
          break;
        case 400:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response["msg"]),
          ));
          break;
        case 500:
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response["error"]),
          ));
          break;
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52.h,
              ),
              Text(
                "Sign Up to GitHub Stonks",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: darkTextColor,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Wrap(
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: purpleColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24.h,
              ),
              getTextField(hint: "Full Name", controller: fullNameController),
              SizedBox(
                height: 16.h,
              ),
              getTextField(hint: "Email", controller: emailController),
              SizedBox(
                height: 16.h,
              ),
              getTextField(hint: "Password", controller: passwordController),
              SizedBox(
                height: 16.h,
              ),
              getTextField(
                  hint: "Confirm Password",
                  controller: confirmPasswordController),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => signUpUser(context),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(purpleColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14.h)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ))),
                  child: Text("Create Account"),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              Row(
                children: [
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    "or sign up via",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: lightTextColor,
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // SIGNIN WITH GOOGLE
                  },
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(BorderSide(
                        color: borderColor,
                      )),
                      foregroundColor: MaterialStateProperty.all(darkTextColor),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14.h)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/google_logo.png"),
                      SizedBox(width: 10.w),
                      Text("Google"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
