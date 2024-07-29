
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/model/word.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/widgets/word_dialog.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';

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
                  showWordDialog(
                      context, widget.word.imageUrl, widget.word.name);
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
