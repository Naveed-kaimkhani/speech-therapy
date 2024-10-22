import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_therapy/constant/words_list.dart';
import 'package:speech_therapy/presentation/widgets/word_card.dart';
import 'package:speech_therapy/style/styling.dart';

class WordSpeak extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 12.h), // Space between the container and the GridView
            Text(
              '  Speach Recognition',
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
                    child: WordCard(
                      word: words[index],
                      listen: false,
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



