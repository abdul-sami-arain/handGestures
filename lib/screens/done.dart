import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/forgotPassword.dart';
import 'package:handgesture/screens/initialScreen.dart';
import 'package:handgesture/screens/landing.dart';
import 'package:handgesture/screens/login.dart';
import 'package:handgesture/screens/signup.dart';
import 'package:handgesture/utils/labels.dart';

class Done extends StatefulWidget {
  String? status;
  Done({super.key, required this.status});

  @override
  State<Done> createState() => _DoneState();
}

class _DoneState extends State<Done> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LandingPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 120.h,
              width: 120.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/check.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Labels(
              label:
                  "Your Response of ${widget.status}\n has been sent to supervisor",
              color: Color(0xff2C599D),
              size: 20,
              weight: FontWeight.bold,
              align: TextAlign.center)
        ],
      ),
    );
  }
}
