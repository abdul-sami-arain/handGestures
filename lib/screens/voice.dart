import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:audioplayers/audioplayers.dart';
import '../provider/provider.dart';
import 'landing.dart';

class Voice extends StatefulWidget {
  const Voice({Key? key}) : super(key: key);

  @override
  State<Voice> createState() => _VoiceState();
}

class _VoiceState extends State<Voice> {
  @override
  void initState() {
    initRecorder();
    super.initState();
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  final recorder = FlutterSoundRecorder();
  

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Permission not granted';
    }
    await recorder.openRecorder();
    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future startRecord() async {
    await recorder.startRecorder(toFile: "audio");
  }

  

final player = FlutterSoundPlayer();

Future playRecording(String filePath) async {
  
}

Future stopPlaying() async {
  await player.stopPlayer();
}
  @override
  Widget build(BuildContext context) {
        AppState provider = Provider.of<AppState>(context);
        Future stopRecorder() async {
    final filePath = await recorder.stopRecorder();
    final file = File(filePath!);
    final player = FlutterSoundPlayer();
    await player.startPlayer(fromURI: filePath);
    await player.stopPlayer();
    print('Recorded file path: $filePath');
     var uuid = Uuid();

        final storageRef = FirebaseStorage.instance.ref("${uuid.v4()}.mp3");
        await  storageRef.putFile(file);
        print("File Uploaded Successfully");
        // String downloadURL =  await storageRef.getDownloadURL();
        // DatabaseReference ref = FirebaseDatabase.instance.ref("voices/${provider.uid}");
        // await ref.push().update({
        // "vid" : downloadURL,
        // "dt": DateTime.now().toString()
        // });        
          Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => LandingPage()));
  }
    return Scaffold(
        backgroundColor: Colors.teal.shade700,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<RecordingDisposition>(
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;

                  String twoDigits(int n) => n.toString().padLeft(2, '0');

                  final twoDigitMinutes =
                      twoDigits(duration.inMinutes.remainder(60));
                  final twoDigitSeconds =
                      twoDigits(duration.inSeconds.remainder(60));

                  return Text(
                    '$twoDigitMinutes:$twoDigitSeconds',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
                stream: recorder.onProgress,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (recorder.isRecording) {
                    await stopRecorder();
                    setState(() {});
                  } else {
                    await startRecord();
                    setState(() {});
                  }
                },
                child: Icon(
                  recorder.isRecording ? Icons.stop : Icons.mic,
                  size: 100,
                ),
              ),
            ],
          ),
        ));
  }
}



