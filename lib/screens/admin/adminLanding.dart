import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/admin/audio.dart';
import 'package:handgesture/screens/admin/emailUpdated1.dart';
import 'package:handgesture/screens/admin/gps.dart';
import 'package:handgesture/screens/admin/images_.dart';
import 'package:handgesture/screens/admin/images.dart';
import 'package:handgesture/screens/admin/inventoryPage.dart';
import 'package:handgesture/screens/admin/videos.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:handgesture/utils/square.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:dio/dio.dart';
import 'package:handgesture/utils/squares2.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import 'SMS.dart';

class AdminLanding extends StatelessWidget {
  AdminLanding({super.key});
  final ref = FirebaseDatabase.instance.ref("users");
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    final databaseReference = FirebaseDatabase.instance.ref();
    final dataRef = databaseReference.child('users');
    final dataStream = dataRef.onValue;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff161513),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Labels(
                      label: "Name",
                      color: Color(0xff161513),
                      size: 15,
                      weight: FontWeight.w600,
                      align: TextAlign.center),
                  Labels(
                      label: "Phone",
                      color: Color(0xff161513),
                      size: 15,
                      weight: FontWeight.w600,
                      align: TextAlign.center),
                  Labels(
                      label: "Details",
                      color: Color(0xff161513),
                      size: 15,
                      weight: FontWeight.w600,
                      align: TextAlign.center),
                ],
              ),
              SizedBox(height: 5.h),
              Divider(
                thickness: 1.w,
                color: Color(0xff161513),
              ),
              Flexible(
                child: StreamBuilder(
                    stream: ref.onValue,
                    builder:
                        ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.hasData) {
                        Map<dynamic, dynamic> map =
                            snapshot.data!.snapshot.value as dynamic;
                        List<dynamic> list = [];
                        list.clear();
                        list = map.values.toList();
                        return ListView.builder(
                            itemCount:
                                snapshot.data!.snapshot.children.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {},
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Labels(
                                            label: "${list[index]['name']}",
                                            color: Color(0xff161513),
                                            size: 15,
                                            weight: FontWeight.w600,
                                            align: TextAlign.center),
                                        Labels(
                                            label: "${list[index]['phone']}",
                                            color: Color(0xff161513),
                                            size: 15,
                                            weight: FontWeight.w600,
                                            align: TextAlign.center),
                                        Container(
                                            height: 20.h,
                                            width: 70.w,
                                            child: ElevatedButton(
                                              onPressed: () {
                                               
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Profile(
                                                              address:
                                                                  '${list[index]['address']}',
                                                              email:
                                                                  '${list[index]['email']}',
                                                              name:
                                                                  '${list[index]['name']}',
                                                              phone:
                                                                  '${list[index]['phone']}',
                                                              status:
                                                                  '${list[index]['status']}',
                                                              uid:
                                                                  '${list[index]['uid']}',
                                                              username:
                                                                  '${list[index]['username']}',
                                                            )));
                                              },
                                              child: Text("Profile"),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xff161513)),
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 5.h),
                                    Divider(
                                      thickness: 1.w,
                                      color: Color(0xff161513),
                                    )
                                  ],
                                ),
                              );
                            }));
                      }
                      return CircularProgressIndicator();
                    })),
              ),
            ],
          ),
        )),
    );
  }
}

class Profile extends StatelessWidget {
  String? name;
  String? username;
  String? email;
  String? address;
  String? uid;
  String? phone;
  String? status;
  Profile(
      {super.key,
      required this.name,
      required this.username,
      required this.email,
      required this.address,
      required this.uid,
      required this.phone,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff164584),
          ),
          onTap: () {
              Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AdminLanding()));
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.w),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            child: Image.asset("assets/logo.png"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.person_alt_circle,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "NAME",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$name",
                                  color: Color(0xff161513),
                                  size: 13,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.person_alt_circle,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "USERNAME",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$username",
                                  color: Color(0xff161513),
                                  size: 13,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.mail_solid,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "EMAIL",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$email",
                                  color: Color(0xff161513),
                                  size: 13,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.house,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "ADDRESS",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$address",
                                  color: Color(0xff161513),
                                  size: 13,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.phone_circle,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "PHONE",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$phone",
                                  color: Color(0xff161513),
                                  size: 13,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.briefcase,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "STATUS",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$status",
                                  color: Color(0xff161513),
                                  size: 13,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.key_rounded,
                                    color: Colors.black,
                                    size: 25.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Labels(
                                      label: "USER ID",
                                      color: Color(0xff161513),
                                      size: 13,
                                      weight: FontWeight.w700,
                                      align: TextAlign.center),
                                ],
                              ),
                              Labels(
                                  label: "$uid",
                                  color: Color(0xff161513),
                                  size: 10,
                                  weight: FontWeight.w700,
                                  align: TextAlign.center),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
          
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 10.w),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 5.h,),
                        Labels(label: "Gestures Perfomance Details", color: Colors.black, size: 12, weight: FontWeight.bold, align: TextAlign.justify),
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Audio(uid: uid,)));
                                      },
                                      child: Square2(
                                          title: "0", imgAddress: "assets/call.png")),
                                  GestureDetector(
                                       onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Videos(uid: uid,)));
                                      },
                                    child: GestureDetector(
                                       onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmailUpdated1(uid: uid,)));
                                      },
                                      child: Square2(title: "0", imgAddress: "assets/dislike.png"))),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                     onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InventorySys(uid: uid,)));
                                      },
                                    child: Square2(title: "0", imgAddress: "assets/like.png")),
                                  GestureDetector(
                                      onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EmailUpdated1(uid: uid,)));
                                      },
                                    child: Square2(title: "0", imgAddress: "assets/ok.png")
                                    ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SMS(uid: uid,)));
                                      },
                                    child: Square2(title: "0", imgAddress: "assets/peace.png")),
                                  GestureDetector(
                                     onTap: () {
                                          Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Videos(uid: uid,)));
                                      },
                                    child: Square2(title: "0", imgAddress: "assets/rock.png")),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                     onTap: () {
                                   
                                     Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            GPS(uid: uid,)
                                                            ));
                                    },
                                    child: Square2(title: "0", imgAddress: "assets/salute.png")),
                                  GestureDetector(
                                    child: Square2(
                                        title: "0", imgAddress: "assets/stop.png"),
                                    onTap: () {
                                  
                                     Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Images(uid: uid,)
                                                            ));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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


