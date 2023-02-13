import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:url_launcher/url_launcher.dart';

import 'adminLanding.dart';

final databaseReference = FirebaseDatabase.instance.ref("sms_update");

class SMS extends StatelessWidget {
  String? uid;
  SMS({required this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Labels(
            label: "Email Updates",
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
                MaterialPageRoute(builder: (context) => AdminLanding()));
          },
        ),
        backgroundColor: Color(0xff161513),
      ),

      body: StreamBuilder(
        stream: databaseReference.child("${uid}").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            // Access the data in the snapshot
            Map<dynamic, dynamic> data =
                snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
            List keys = data.keys.toList();

            return ListView.builder(
              itemCount: keys.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 224, 224),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Labels(label: "${data[keys[index]]['message'].toString()}", color: Color.fromARGB(255, 20, 44, 63), size: 12, weight: FontWeight.bold, align: TextAlign.justify),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Labels(
                                          label: "Date",
                                          color: Color(0xff164584),
                                          size: 20,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                      Labels(
                                          label:
                                              "${data[keys[index]]['dt'].toString().substring(0, 11)}",
                                          color: Colors.black,
                                          size: 22,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Column(
                                    children: [
                                      Labels(
                                          label: "Time",
                                          color: Color(0xff164584),
                                          size: 20,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                      Labels(
                                          label:
                                              "${data[keys[index]]['dt'].toString().substring(11, 16)}",
                                          color: Colors.black,
                                          size: 22,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                // return ListTile(
                //   title: Text(keys[index]),
                //   subtitle: Text(data[keys[index]]['dt'].toString()),
                // );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
