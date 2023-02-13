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


class ABC extends StatelessWidget {
  String? min;
   ABC({super.key,required this.min});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Text("this is area ${min}"));
  }
}