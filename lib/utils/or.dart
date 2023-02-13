import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handgesture/provider/provider.dart';
import 'package:handgesture/screens/splashScreen.dart';
import 'package:provider/provider.dart';

class OR extends StatelessWidget {
  const OR({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 1.h,
            color: Color(0xff161513),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 2.w),
            child: Text(
              "OR",
              style: TextStyle(  
                color: Color(0xff161513),
                fontSize: 20.sp,
                
              ),
            ),
          ),
           Container(
            width: 80.w,
            height: 1.h,
            color: Color(0xff161513),
          ),
        ],
      ),
    );
  }
}