import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:url_launcher/url_launcher.dart';

import 'adminLanding.dart';


class Map1 extends StatefulWidget {
  double lon;
  double lat;
   Map1({super.key,required this.lon,required this.lat});

  @override
  State<Map1> createState() => _Map1State();
}

class _Map1State extends State<Map1> {
   Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Labels(
            label: "Location Update",
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
      body: GoogleMap(
  onMapCreated: (GoogleMapController controller) {
    _controller.complete(controller);
  },
  initialCameraPosition: CameraPosition(
    target: LatLng(widget.lat, widget.lon),
    zoom: 14.4746,
  ),
  markers: Set.of([
    Marker(
      markerId: MarkerId("1"),
      position: LatLng(widget.lat, widget.lon),
    ),
  ]),
)
,
    );
  }
}