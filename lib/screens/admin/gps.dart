import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/admin/map.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:url_launcher/url_launcher.dart';

import 'adminLanding.dart';

final databaseReference = FirebaseDatabase.instance.ref("gps");

class GPS extends StatelessWidget {
  String? uid;
  GPS({required this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Labels(
            label: "Locations Update",
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
                               Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Labels(
                                      label: "Location no:",
                                      color: Color(0xff164584),
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                  Labels(
                                      label:
                                          "${index+1}",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                
                                ],
                              ),
                              SizedBox(height: 15.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Labels(
                                      label: "Altitude:",
                                      color: Color(0xff164584),
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                  Labels(
                                      label:
                                          "${data[keys[index]]['altitude']}",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Labels(
                                      label: "Longitude:",
                                      color: Color(0xff164584),
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                  Labels(
                                      label:
                                          "${data[keys[index]]['longitude']} ",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Labels(
                                      label: "Latitude:",
                                      color: Color(0xff164584),
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                  Labels(
                                      label:
                                          "${data[keys[index]]['latitude']}",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                
                                ],
                              ),
                           
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Labels(
                                      label: "Date:",
                                      color: Color(0xff164584),
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                  Labels(
                                      label:
                                          "${data[keys[index]]['dt'].toString().substring(0, 11)}",
                                      color: Colors.black,
                                      size: 15,
                                      weight: FontWeight.bold,
                                      align: TextAlign.center),
                                
                                ],
                              ),
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Labels(
                                          label: "Time",
                                          color: Color(0xff164584),
                                          size: 15,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                      Labels(
                                          label:
                                              "${data[keys[index]]['dt'].toString().substring(11, 16)}",
                                          color: Colors.black,
                                          size: 15,
                                          weight: FontWeight.bold,
                                          align: TextAlign.center),
                                    ],
                                  ),
                                   Container(
                          height: 48.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Map1(lat: double.parse(data[keys[index]]['latitude'].toString()), lon: double.parse(data[keys[index]]['longitude'].toString()),)));
                            },
                            child: Text("Locate"),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff161513)),
                            ),
                          )),
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
