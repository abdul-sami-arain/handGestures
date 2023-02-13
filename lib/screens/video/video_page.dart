import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/screens/done.dart';
import 'package:handgesture/screens/landing.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';


import 'package:video_player/video_player.dart';

import '../../provider/provider.dart';

class VideoPage extends StatefulWidget {
  final String filePath;

  const VideoPage({Key? key, required this.filePath}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  bool val=false;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: ()async {
              setState(() {
                val=true;
              });
             print("${File(widget.filePath)} this is video path");
               var uuid = Uuid();
              FirebaseFirestore db = FirebaseFirestore.instance;
        final storageRef = FirebaseStorage.instance.ref("${uuid.v4()}");
        File file = File(widget.filePath);
        await  storageRef.putFile(file);
        print("File Uploaded Successfully");
        String downloadURL =  await storageRef.getDownloadURL();
        DatabaseReference ref = FirebaseDatabase.instance.ref("videos/${provider.uid}");
        await ref.push().update({
        "vid" : downloadURL,
        "dt": DateTime.now().toString()
        });
        setState(() {
          val=false;
        });
        
          Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LandingPage()));
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body:val==false? FutureBuilder(
        future: _initVideoPlayer(),
        builder: (context, state) {
          if (state.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return VideoPlayer(_videoPlayerController);
          }
        },
      ):Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            height: 100.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5.r)
            ),
            child: CircularProgressIndicator(color: Colors.white,),
          ),
        ),
      ),
    );
  }
}