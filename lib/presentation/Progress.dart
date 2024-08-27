import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_therapy/constant/words_list.dart';
import 'package:speech_therapy/model/word.dart';
import 'package:speech_therapy/presentation/progress_track.dart';
import 'package:speech_therapy/presentation/widgets/word_card.dart';
import 'package:speech_therapy/presentation/word_speak.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Styling.darkBlue,
          centerTitle: true,
          title: Text(
            'Test Your Learning',
            style: GoogleFonts.pacifico(
              textStyle: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop,
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          bottom: const TabBar(
            indicatorColor: Colors.white, // Indicator color
            labelColor: Colors.white, // Text color when active
            unselectedLabelColor: Colors.white60, // Text color when inactive
            tabs: [
              Tab(text: 'Word Speak'),
              Tab(text: 'Progress Track'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WordSpeak(),
            const ProgressTrack(),
          ],
        ),
      ),
    );
  }
}
