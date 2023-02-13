import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handgesture/screens/admin/adminLanding.dart';
import 'package:handgesture/screens/forgotPassword.dart';
import 'package:handgesture/screens/landing.dart';
import 'package:handgesture/screens/signup.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../utils/underlinedLabel.dart';
import '../initialScreen.dart';

class LogInAdmin extends StatefulWidget {
  const LogInAdmin({super.key});

  @override
  State<LogInAdmin> createState() => _LogInAdminState();
}

bool value = true;
bool value1 = true;
final password = TextEditingController(text: "123456");
final email = TextEditingController(text: "abdulsamiarain82@gmail.com");

class _LogInAdminState extends State<LogInAdmin> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    Future<List<Data>> getDataList() async {
    List<Data> dataList = [];
    DataSnapshot snapshot =  FirebaseDatabase.instance.ref("users").once() as DataSnapshot;
    Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
    values.forEach((key, value) {
      dataList.add(Data(
        id: key,
        data: value,
      ));
    });
    return dataList;
  }
    log_in() async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text, password: password.text);
        DatabaseReference starCountRef =
            FirebaseDatabase.instance.ref('admin/${userCredential.user!.uid}');
        starCountRef.onValue.listen((DatabaseEvent event) {
          provider.uid = event.snapshot.child("uid").toString();
          provider.name = event.snapshot.child("name").toString();
          provider.username = event.snapshot.child("username").toString();
          provider.email = event.snapshot.child("email").toString();
          provider.address = event.snapshot.child("address").toString();
        });
       DatabaseReference ref = FirebaseDatabase.instance.ref("users");
        email.clear();
        password.clear();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminLanding()));
      } on  FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "$e",
        toastLength: Toast.LENGTH_SHORT,
      );
    }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff161513),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.r),
                      bottomRight: Radius.circular(15.r),
                    )),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                       onTap: (){
                             Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            InitialScreen()));
                          },
                        child: CircleAvatar(
                          radius: 12.r,
                          backgroundColor: Color(0xffFBFCF8),
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xff161513),
                            size: 20.sp,
                          ),
                        ),
                      ),
                      Labels(
                          label: "Log In",
                          color: Color(0xffFBFCF8),
                          size: 15,
                          weight: FontWeight.w700,
                          align: TextAlign.justify),
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 12.r,
                          backgroundColor: Color(0xffFBFCF8),
                          child: Icon(
                            Icons.help_outline,
                            color: Color(0xff161513),
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 100.h,
                            width: 100.w,
                            child: Image.asset("assets/logo.png"),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.white),
                                child: Center(
                                  child: TextFormField(
                                    controller: email,
                                    cursorColor: Colors.black,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter an email';
                                      }
                                      if (!value.contains('@')) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Icon(Icons.mail_outline,
                                              color: Color(0xff2C599D)),
                                        ),
                                        labelText: "Email",
                                        labelStyle:
                                            TextStyle(color: Color(0xff2C599D)),
                                        focusColor: Colors.red,
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                        hintText: "abc@xyz.com"),
                                  ),
                                )),
                            SizedBox(
                              height: 15.h,
                            ),
                            Container(
                                height: 50.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.white),
                                child: Center(
                                  child: TextFormField(
                                    controller: password,
                                    cursorColor: Colors.black,
                                    obscureText: value,
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: value == true
                                              ? Icon(Icons.visibility_off,
                                                  color: Color(0xff2C599D))
                                              : Icon(Icons.visibility,
                                                  color: Color(0xff2C599D)),
                                          onPressed: () {
                                            setState(() {
                                              value = !value;
                                            });
                                          },
                                        ),
                                        suffixIconColor: value == true
                                            ? Colors.blue
                                            : Colors.grey,
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Icon(Icons.key_outlined,
                                              color: Color(0xff2C599D)),
                                        ),
                                        labelText: "Password",
                                        labelStyle: TextStyle(
                                          color: Color(0xff2C599D),
                                        ),
                                        focusColor: Color(0xff2C599D),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                        hintText: "Password"),
                                  ),
                                )),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                GestureDetector(
                                  child: UnderlineLabels(
                                      label: "forgot password?",
                                      color: Color(0xff161513),
                                      size: 10,
                                      weight: FontWeight.w600,
                                      align: TextAlign.right),
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Forgot()));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                          height: 48.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              log_in();
                            },
                            child: Text("Login"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff161513)),
                            ),
                          )),
                      SizedBox(
                        height: 15.h,
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class Data {
  final String? id;
  final dynamic data;

  Data({this.id, this.data});
}