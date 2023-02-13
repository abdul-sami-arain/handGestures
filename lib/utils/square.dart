import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handgesture/utils/labels.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class Square extends StatelessWidget {
  String title;
  String imgAddress;
   Square({super.key,required this.title,required this.imgAddress});
  
  @override
  Widget build(BuildContext context) {
    AppState provider = Provider.of<AppState>(context);
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
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
            radius: 35.r,
            backgroundColor: Colors.white,  
            child: Image.asset("${imgAddress}",height: 50.h,width: 50.w,),    
          ),
          SizedBox(width: 5.w,),
          Container(child: Labels(label: "${title}", color: Colors.white, size: 15, weight: FontWeight.w700, align: TextAlign.center)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.forward_outlined,color: Colors.white,),
                  
                ],
              ),
            ],
          )
        ],
      ),
    ),
    );
  }
}