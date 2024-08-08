import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_therapy/model/word.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/widgets/word_card.dart';
import 'package:speech_therapy/presentation/widgets/word_dialog.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class WordsScreen extends StatelessWidget {
  final List<Word> words = [
    Word('Thank you', 'assets/images/thank.png'),
    Word('Please', 'assets/images/please.png'),
    Word('Eat', 'assets/images/eat.png'),
    Word('Sleep', 'assets/images/sleep.png'),
  ];

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
                itemCount: words.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: WordCard(word: words[index],listen: true,),
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

class UpperCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20.h);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 20.h);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 40.h);
    var secondEndPoint = Offset(size.width, size.height - 20.h);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LowerCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 20.h);
    var firstControlPoint = Offset(size.width / 4, size.height - 40.h);
    var firstEndPoint = Offset(size.width / 2, size.height - 20.h);
    var secondControlPoint = Offset(size.width * 3 / 4, size.height);
    var secondEndPoint = Offset(size.width, size.height - 20.h);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
