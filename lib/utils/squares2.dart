import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class Square2 extends StatelessWidget {
  String title;
  String imgAddress;
   Square2({super.key,required this.title,required this.imgAddress});
  
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Container(
      height: 55.h,
      width: 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
         boxShadow: [
                  BoxShadow(
                    color: Color(0xff2C599D),
                    blurRadius: 6.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 0.0),
                    // Shadow position
                  ),
                ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5],
          colors: [
            Color(0xff2C599D),
            Color(0xff193A6F)
          ],
        ),
      ),
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.white,  
            child: Center(child: Image.asset("${imgAddress}",height: 27.h,width: 27.w,)),    
          ),
          SizedBox(width: 5.w,),
          Container(child: Labels(label: "${title} time(s)", color: Colors.white, size: 15, weight: FontWeight.w700, align: TextAlign.center)),
        ],
      ),
    ),
    );
  }
}