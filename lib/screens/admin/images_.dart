import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/utils/labels.dart';

import 'adminLanding.dart';

final databaseReference = FirebaseDatabase.instance.ref("images");

class Images extends StatelessWidget {
  String? uid;
  Images({required this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff164584),
          ),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AdminLanding()));
          },
        ),
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
                      color: Color.fromARGB(255, 190, 188, 188),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 120.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        data[keys[index]]['img'].toString()),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Labels(
                                          label: "Date",
                                          color: Colors.black,
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
                                          color: Colors.black,
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
