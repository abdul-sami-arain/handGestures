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
import 'package:handgesture/screens/inventory.dart';
import 'package:handgesture/screens/sendMail.dart';
import 'package:handgesture/screens/sendSMS.dart';
import 'package:handgesture/screens/video/camera_page.dart';
import 'package:handgesture/screens/voice.dart';
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






class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  bool val = false;
  String imgpath = "";
  
  






  
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    Get()async{
       setState(() {
      val= true;
    });
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    FirebaseFirestore db = FirebaseFirestore.instance;
 DatabaseReference ref = FirebaseDatabase.instance.ref();
        await ref.child("gps").child("${provider.uid}").push().update({
        "longitude" :position.longitude ,
        "latitude" :position.latitude,
        "altitude" :position.altitude , 
        "dt": DateTime.now().toString()
        });   
   setState(() {
      val= false;
    }); 
     Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Done(status: 'GPS',)));                    
}




Future<Future<Position>?> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {

    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

    
  return await Get();
}




    void PickImage()async{
      
     try {
      
      var uuid = Uuid();
        final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.camera);
      provider.imgAddress=image!.path;
      setState(() {
        imgpath = image.path;
      });
       setState(() {
      val= true;
    });
      FirebaseFirestore db = FirebaseFirestore.instance;
        final storageRef = FirebaseStorage.instance.ref("${uuid.v4()}");
        File file = File(provider.imgAddress);
        await  storageRef.putFile(file);
        print("File Uploaded Successfully");
        String downloadURL =  await storageRef.getDownloadURL();
        DatabaseReference ref = FirebaseDatabase.instance.ref();
        await ref.child("images").child("${provider.uid}").push().update({
        "img" : downloadURL,
        "dt": DateTime.now().toString()
        });
        print(provider.uid.toString());
         setState(() {
      val= false;
    });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Done(status: 'Image Capturing',)));
     } catch (e) {
       print("${e} error is here");
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
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                           Navigator.of(context);
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
                          label: "Landing Page",
                          color: Color(0xffFBFCF8),
                          size: 15,
                          weight: FontWeight.w700,
                          align: TextAlign.justify),
                      GestureDetector(
                        onTap: (){},
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
            Padding(
                 padding: EdgeInsets.only(top: 50.w),
              
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SingleChildScrollView(
                      child: SingleChildScrollView(
                        child: val==false?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "Audio Track Recording", imgAddress: "assets/call.png"),onTap: (){
                              Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => Voice()));
                             
                            },),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "GPS location String \nto admin Panel", imgAddress: "assets/salute.png"),
                            onTap: (){
                            _determinePosition();
                            } ,
                            ),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "Verification to Admin\n Panel Prior to Email \nUpdate", imgAddress: "assets/ok.png"),
                            onTap: (){
                              Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SendMail()));
                            } ,
                            ),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "SMS Update", imgAddress: "assets/peace.png"),
                            onTap: (){
                                Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SendSMS()));
                            } ,),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "Video Track Recording", imgAddress: "assets/rock.png"),
                            onTap: (){
                              Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => CameraPage()));
                            } ,),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(
                              child: Square(title: "Image Capture", imgAddress: "assets/stop.png"),
                              onTap: (){
                               PickImage();
                            } ,
                            ),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "Inventory Realtime\n Update", imgAddress: "assets/like.png"),
                            onTap: (){
                                Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => InventoryForm()));
                            } ,),
                      
                            SizedBox(height: 10.h,),
                            GestureDetector(child: Square(title: "Email Update", imgAddress: "assets/dislike.png"),
                            onTap: (){
                                Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => SendMail()));
                            } ,),
                            SizedBox(height: 10.h,),
                                 ],
                        ):Container(
                          color: Colors.transparent,
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
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