import 'package:google_fonts/google_fonts.dart';
import 'package:speech_therapy/style/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextStyle {
  static final font_20 = GoogleFonts.lora(
      textStyle: TextStyle(
          color: Colors.black, fontSize: 20.sp, fontWeight: FontWeight.bold));
  static final font_18 = TextStyle(
    color: Colors.white,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
  );
  static final word_style = GoogleFonts.lora(
      textStyle: TextStyle(
          color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold));
}
