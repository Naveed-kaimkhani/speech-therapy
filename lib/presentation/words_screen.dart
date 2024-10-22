import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_therapy/constant/words_list.dart';
import 'package:speech_therapy/presentation/widgets/word_card.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

import 'widgets/clipper.dart';

class WordsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: LowerCurveClipper(),
              child: Container(
                // color: Styling.darkBlue, // Adjust color as needed
                width: double.infinity,
                height: 130.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Styling.darkBlue,
                      Styling.lightBlue
                    ], // Define your gradient colors here
                    begin: Alignment
                        .topLeft, // Define the start point of the gradient
                    end: Alignment
                        .bottomRight, // Define the end point of the gradient
                  ),
                ),
                // Adjust height as needed
                child: Stack(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 220.w),
                    child: Lottie.asset(
                      Images.book,
                      height: 180.w, // Adjust height as needed
                      // width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w, top: 40.h),
                    child: Text(
                      '  Expand Your World,\n  One Word at a Time.',
                      style: GoogleFonts.lora(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
                height: 4.h), // Space between the container and the GridView
            Text(
              '  Explore Words',
              style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.h,
                ),
                itemCount: commonWords.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: WordCard(word: commonWords[index],listen: true,),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}



