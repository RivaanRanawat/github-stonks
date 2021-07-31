import 'package:flutter/material.dart';
import 'package:github_stonks/screens/signup_screen.dart';
import 'package:github_stonks/universal_variables.dart';
import 'package:github_stonks/widgets/text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
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
                "Login to GitHub Stonks",
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
                    "Don't have an account? ",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: lightTextColor,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    ),
                    child: Text(
                      "Sign Up",
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
              // getTextField(hint: "Email"),
              // SizedBox(
              //   height: 16.h,
              // ),
              // getTextField(hint: "Password"),
              SizedBox(
                height: 16.h,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(purpleColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(vertical: 14.h)),
                      textStyle: MaterialStateProperty.all(TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                      ))),
                  child: Text("Login to Account"),
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
                    "or login via",
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
                    // Login WITH GOOGLE
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
