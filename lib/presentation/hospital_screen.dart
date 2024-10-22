import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_therapy/constant/words_list.dart';
import 'package:speech_therapy/presentation/widgets/word_card.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';
import 'widgets/clipper.dart';

class HospitalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 4.h), // Space between the header and GridView
            _buildTitle(),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  mainAxisSpacing: 2.h,
                ),
                itemCount: hospitalWords.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: WordCard(word: hospitalWords[index], listen: true),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ClipPath(
      clipper: LowerCurveClipper(),
      child: Container(
        width: double.infinity,
        height: 130.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Styling.darkBlue, Styling.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.only(left: 240.w),
              child: Lottie.asset(
                Images.book,
                height: 180.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 40.h),
              child: Text(
                'Understanding Hospital Vocabulary\nBridges the Gap Between Patients and Providers.',
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
    );
  }

  Widget _buildTitle() {
    return Text(
      'Explore Words',
      style: GoogleFonts.aBeeZee(
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
