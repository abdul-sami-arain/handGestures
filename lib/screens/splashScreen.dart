import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/forgotPassword.dart';
import 'package:handgesture/screens/initialScreen.dart';
import 'package:handgesture/screens/landing.dart';
import 'package:handgesture/screens/login.dart';
import 'package:handgesture/screens/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => InitialScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Scaffold(
          backgroundColor: Color(0xff161513),
          body: SafeArea(
            child: Center(
              child: Container(
                child: Image.asset(
                "assets/logo.jpeg",
                fit: BoxFit.contain,
                height: double.infinity,
                      ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
