import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handgesture/provider/provider.dart';
import 'package:handgesture/screens/splashScreen.dart';
import 'package:provider/provider.dart';


class Labels extends StatelessWidget {
  String label;
  Color color;
  double size;
  FontWeight weight;
  TextAlign align;
  Labels({super.key,required this.label,required this.color,required this.size,required this.weight,required this.align});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("$label",
       style: GoogleFonts.montserrat(
    textStyle: TextStyle(
      color: color, letterSpacing: .5,fontSize: size.sp,fontWeight:  weight),
  ),
  textAlign: align,),
    );
  }
}