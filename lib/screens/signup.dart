import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:handgesture/screens/login.dart';
import 'package:handgesture/utils/labels.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

bool value = true;
bool value1 = false;
final name = TextEditingController();
final username = TextEditingController();
final password = TextEditingController();
final email = TextEditingController();
final phone = TextEditingController();
final address = TextEditingController();

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    sign_up() async {
      try {
        setState(() {
          value1=true;
        });
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text);
        FirebaseAuth auth = FirebaseAuth.instance;
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("users/${userCredential.user!.uid}");
        await ref.set({
          "status":"rider",
          "name": name.text,
          "username": username.text,
          "email": email.text,
          "phone": phone.text,
          "address": address.text,
          "uid":userCredential.user!.uid,
          "gestures":{
            "audio":0,
            "emailupdated":0,
            "gps":0,
            "image":0,
            "iru":0,
            "ppemailupdated":0,
            "sms":0,
            "video":0,
          }
        });
        setState(() {
          value1=false;
        });
        email.clear();
        password.clear();
        name.clear();
        username.clear();
        address.clear();
        phone.clear();
         Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LogIn()));
      }on FirebaseAuthException catch (e) {
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: GestureDetector(
                          onTap: (){
                            
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
                      ),
                      Labels(
                          label: "Sign Up",
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
                    children: [
                      SizedBox(
                        height: 20.h,
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
                        height: 10.h,
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
                                    controller: name,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Icon(
                                            CupertinoIcons.person,
                                            color: Color(0xff2C599D),
                                          ),
                                        ),
                                        labelText: "Name",
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
                                        hintText: "Your Full Name"),
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
                                    controller: username,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Icon(CupertinoIcons.person,
                                              color: Color(0xff2C599D)),
                                        ),
                                        labelText: "Username",
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
                                        hintText: "User Name"),
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
                                    controller: address,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Icon(Icons.home_outlined,
                                              color: Color(0xff2C599D)),
                                        ),
                                        labelText: "Address",
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
                                        hintText: "address"),
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
                                    inputFormatters: <TextInputFormatter>[
                                      // for below version 2 use this
                                      FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9]')),
                                      // for version 2 and greater youcan also use this
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: phone,
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.only(right: 5.w),
                                          child: Icon(Icons.phone_outlined,
                                              color: Color(0xff2C599D)),
                                        ),
                                        labelText: "Contact",
                                        labelStyle:
                                            TextStyle(color: Color(0xff2C599D)),
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
                                        hintText: "Phone Number"),
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
                                              ? Icon(
                                                  Icons.visibility_off,
                                                  color: Color(0xff2C599D),
                                                )
                                              : Icon(
                                                  Icons.visibility,
                                                  color: Color(0xff2C599D),
                                                ),
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                     value1==false? Container(
                          height: 48.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              sign_up();
                            },
                            child: Text("Sign Up"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff161513)),
                            ),
                          )):CircularProgressIndicator(color: Colors.black,)
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
