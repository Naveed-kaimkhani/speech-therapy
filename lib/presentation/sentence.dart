import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class SentenceScreen extends StatelessWidget {
  final List<Word> words = [
    Word('I’m walking', 'assets/images/walking.png'),
    Word('I’m eating', 'assets/images/eat.png'),
    Word('I’m playing', 'assets/images/playing.png'),
    Word('I’m Drinking', 'assets/images/drinking.png'),
    Word('I’m Drinking', 'assets/images/drinking.png'),
    Word('I’m Drinking', 'assets/images/drinking.png'),
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
                      onPressed: () {},
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
              '  Explore Sentences',
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
                    child: WordCard(word: words[index]),
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

class Word {
  final String name;
  final String imageUrl;

  Word(this.name, this.imageUrl);
}

class WordCard extends StatefulWidget {
  final Word word;

  WordCard({required this.word});

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        color: Styling.darkBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          children: [
            ClipPath(
              clipper: UpperCurveClipper(),
              child: Container(
                height: 40.h,
                color: Styling.lightBlue,
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  // Add any additional interactions here
                  // For example, play a sound or show a popup
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        widget.word.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 6.w),
                      child: Text(widget.word.name,
                          style: CustomTextStyle.word_style),
                    ),
                  ],
                ),
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
