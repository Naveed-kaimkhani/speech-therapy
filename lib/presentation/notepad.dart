import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class NotePad extends StatefulWidget {
  @override
  State<NotePad> createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  final messageController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _flutterTts.setLanguage("ur-PK");
    _flutterTts.setPitch(1);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Styling.darkBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34.r),
                      bottomRight: Radius.circular(34.r),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w, top: 4.h),
                          child: Text(
                            'Start\nWriting\nToday',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pacifico(
                              textStyle: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          Images.write,
                          height: 150.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Styling.darkBlue,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: SingleChildScrollView(
                              child: TextField(
                                controller: messageController,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                cursorColor: Colors.white,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Start Writing...",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AuthButton(
                  text: "Convert",
                  func: () async {
                    await _speak(messageController.text);
                  },
                  color: Styling.darkBlue,
                ),
                SizedBox(
                  height: 14.h,
                )
              ],
            ),
            Positioned(
              top: 160.h, // Adjust as needed
              right: 8.w, // Adjust as needed
              child: Hero(
                tag: 'hero-tag',
                child: Image.asset(
                  Images.bird, // Replace with your image path
                  width: 100.w, // Adjust size as needed
                  height: 100.h, // Adjust size as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
