import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:handgesture/utils/square.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:dio/dio.dart';
import 'package:handgesture/utils/squares2.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';


class ShowData extends StatelessWidget {
  String? uid;
  ShowData({super.key, required uid});

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView.builder(
            itemCount: provider.images.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        provider.images[index].img.toString(),
                        height: 200.h,
                        width: 200.w,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Labels(
                                  label: "Date",
                                  color: Colors.black,
                                  size: 12,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                              SizedBox(
                                width: 10.w,
                              ),
                              Labels(
                                  label:
                                      "${provider.images[index].date.toString()}",
                                  color: Colors.black,
                                  size: 12,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Labels(
                                  label: "Time",
                                  color: Colors.black,
                                  size: 12,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                              SizedBox(
                                width: 10.w,
                              ),
                              Labels(
                                  label:
                                      "${provider.videos[index].date.toString().substring(11, 16)}",
                                  color: Colors.black,
                                  size: 10,
                                  weight: FontWeight.bold,
                                  align: TextAlign.center),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.black,
                  )
                ],
              );
            }),
      ),
    ),
    );
  }
}
