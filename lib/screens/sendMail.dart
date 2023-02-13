import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/provider/provider.dart';
import 'package:handgesture/screens/done.dart';
import 'package:handgesture/screens/landing.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:handgesture/utils/underlinedLabel.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class SendMail extends StatefulWidget {
  const SendMail({super.key});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    Future send(String message) async {
      try {
        final Email email = Email(
          body: message,
          subject: message,
          recipients: ['abdulsamiarain82@gmail.com'],
          isHTML: false,
        );
        DatabaseReference ref = FirebaseDatabase.instance.ref();
        await ref.child("email_update").child("${provider.uid}").push().update({
        "message" :message,
        "dt": DateTime.now().toString()
        });   
        await FlutterEmailSender.send(email);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => Done(status: "email")));
      } catch (e) {}
    }

    return Scaffold(
      appBar: AppBar(
        title: Labels(
            label: "Email Update",
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
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 48.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    send("Parcel Has been Delieverd!");
                  },
                  child: Text("Parcel Has been Delieverd!"),
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
                    send("Parcel not Delieverd!");
                  },
                  child: Text("Parcel not Delieverd!"),
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
                    send("No One was there at delievery point!");
                  },
                  child: Text("No One was there at delievery point!"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff161513)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
