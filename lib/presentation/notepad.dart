import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class NotePad extends StatefulWidget {
  @override
  State<NotePad> createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  // String? date;

  @override
  void initState() {
    super.initState();
    // Setting an initial date for display purposes
    // date = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      body: Column(
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
                // child: Image.asset(Images.login_icon),
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
                        fontSize: 20.sp,
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
            )),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Styling.darkBlue, // Brighter color for kids
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: TextField(
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: "Enter message....",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize:
                              20), // Changed text color for better visibility
                    ),
                  ),
                  Positioned(
                    right: -10.w, // Adjust the position to ensure overlap
                    top: -10.h, // Adjust the position to ensure overlap
                    child: Container(
                      height: 100.h, // Adjust height as needed
                      width: 100.w, // Adjust width as needed
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20.r), // Match the text box radius
                        child: Image.asset(
                          Images.bird, // Replace with the actual image path
                          fit: BoxFit.cover,
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
            func: () {
              // Add the conversion logic here
            },
            color: Styling.darkBlue,
          )
        ],
      ),
    );
  }
}
