import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecording extends StatefulWidget {
  @override
  _VideoRecordingState createState() => _VideoRecordingState();
}

class _VideoRecordingState extends State<VideoRecording> {
 late CameraController _controller;
 late List<CameraDescription> cameras;

 late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _controller.initialize();
    availableCameras().then((availableCameras) {
      cameras = availableCameras;
      if (cameras.length > 0) {
        setState(() {
          _controller = CameraController(cameras[0], ResolutionPreset.high);
          _initializeControllerFuture = _controller.initialize();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startVideoRecording() async {
    if (!_controller.value.isInitialized) {
      return;
    }

    final Directory appDirectory = await getApplicationDocumentsDirectory();
    final String videoDirectory = '${appDirectory.path}/Videos';
    await Directory(videoDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$videoDirectory/$currentTime.mp4';

    try {
      await _controller.startVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return;
    }

    try {
      await _controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description.toString());
    print('Error: ${e.code}\n${e.description}');
  }

  void logError(String code, String message) =>
      print('Error: $code\nMessage: $message');

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    floatingActionButton: FloatingActionButton(
  child: Icon(_controller != null && _controller.value.isRecordingVideo
      ? Icons.stop
      : Icons.videocam),
  onPressed: _controller != null &&
          _controller.value.isInitialized
      ? (_controller.value.isRecordingVideo
          ? _stopVideoRecording
          : _startVideoRecording)
      : null,
),);
  }
}