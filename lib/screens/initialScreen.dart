import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/admin/login.dart';
import 'package:handgesture/screens/login.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:handgesture/utils/square.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  height: 100.h,
                  width: 100.w,
                  child: Image.asset("assets/logo.png"),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LogIn()));
                        },
                      child: Text("Proceed as User"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff161513)),
                      ),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LogInAdmin()));
                      },
                      child: Text("Proceed as Admin"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff161513)),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
