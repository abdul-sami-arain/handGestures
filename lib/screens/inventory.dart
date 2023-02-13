import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/abc.dart';
import 'package:handgesture/screens/done.dart';
import 'package:handgesture/screens/landing.dart';
import 'package:handgesture/screens/sendMail.dart';
import 'package:handgesture/screens/video/camera_page.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:handgesture/utils/square.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/admin/images_.dart';
import 'package:handgesture/screens/admin/images.dart';
import 'package:handgesture/screens/admin/videos.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:handgesture/utils/square.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:dio/dio.dart';
import 'package:handgesture/utils/squares2.dart';
import 'package:provider/provider.dart';
import '../../provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class InventoryForm extends StatefulWidget {
  const InventoryForm({super.key});

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  final pname = TextEditingController();
final pcode = TextEditingController();
  final pquantity = TextEditingController();
final pprice= TextEditingController();



  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
   InventoryData()async{
     DatabaseReference ref = FirebaseDatabase.instance.ref();
        await ref.child("inventory_update").child("${provider.uid}").push().update({
        "pname" :pname.text,
        "pcode" :pcode.text,
        "pquantity" :pquantity.text,
        "pprice" :pprice.text,
        "dt": DateTime.now().toString()
        });
         Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Done(status: "Inventory Update")));   
   }
     final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar:  AppBar(
        centerTitle: true,
        title: Labels(
            label: "Inventory Management",
            color: Colors.white,
            size: 15,
            weight: FontWeight.bold,
            align: TextAlign.center),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LandingPage()));
          },
        ),
        backgroundColor: Color(0xff161513),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: SingleChildScrollView(
            child:
                Form(
key: _formKey,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  height: 20.h,
                              ),
                              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Labels(
                        label: "Product Name*",
                        color: Colors.black,
                        size: 15,
                        weight: FontWeight.bold,
                        align: TextAlign.left),
                    Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white),
                        child: Center(
                          child: TextFormField(
                             validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                            controller: pname,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: Color(0xff2C599D)),
                                focusColor: Colors.red,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Product name"),
                          ),
                        )),
                  ],
                              ),
                              SizedBox(
                  height: 20.h,
                              ),
                              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Labels(
                        label: "Product Code*",
                        color: Colors.black,
                        size: 15,
                        weight: FontWeight.bold,
                        align: TextAlign.left),
                    Container(
                        height: 50.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white),
                        child: Center(
                          child: TextFormField(
                             validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                            controller: pcode,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                labelStyle: TextStyle(color: Color(0xff2C599D)),
                                focusColor: Colors.red,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: "Product Code"),
                          ),
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Labels(
                                label: "Quantity*",
                                color: Colors.black,
                                size: 15,
                                weight: FontWeight.bold,
                                align: TextAlign.left),
                            Container(
                                height: 50.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white),
                                child: Center(
                                  child: TextFormField(
                                     validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                                    controller: pquantity,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
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
                                        hintText: "Quantity"),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Labels(
                                label: "Price*",
                                color: Colors.black,
                                size: 15,
                                weight: FontWeight.bold,
                                align: TextAlign.left),
                            Container(
                                height: 50.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white),
                                child: Center(
                                  child: TextFormField(
                                     validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Field is empty';
                      }
                      return null;
                    },
                                    controller: pprice,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    cursorColor: Colors.black,
                                    decoration: InputDecoration(
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
                                        hintText: "Price"),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                              ),
                              SizedBox(
                  height: 20.h,
                              ),
                              Container(
                    height: 48.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                           InventoryData();
                }
                       
                      },
                      child: Text("Login"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff161513)),
                      ),
                    )),
                            ]),
                ),
          ),
        ),
      ),
    );
  }
}
