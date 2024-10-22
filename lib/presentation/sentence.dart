import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_therapy/constant/words_list.dart';
import 'package:speech_therapy/presentation/widgets/word_card.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

import 'widgets/clipper.dart';

class SentenceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with curved bottom edge
            ClipPath(
              clipper: LowerCurveClipper(),
              child: Container(
                width: double.infinity,
                height: 130.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Styling.darkBlue,
                      Styling.lightBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Back button to navigate to the previous screen
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    // Lottie animation on the right side of the header
                    Padding(
                      padding: EdgeInsets.only(left: 260.w),
                      child: Lottie.asset(
                        Images.book,
                        height: 180.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Title text in the header
                    Padding(
                      padding: EdgeInsets.only(left: 12.w, top: 40.h),
                      child: Text(
                        '  Success in Learning Sentences Comes from \n  Daily Small Efforts.',
                        style: GoogleFonts.lora(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 4.h), // Space between the header and the GridView
            // Title for the GridView section
            Text(
              '  Explore Sentences',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // GridView to display a list of sentences
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.h,
                ),
                itemCount: sentence.length, // Number of items in the GridView
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: WordCard(
                      word: sentence[index],
                      listen: true, // Indicates that this card should have a listening feature
                    ),
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


