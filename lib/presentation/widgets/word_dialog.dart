import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/network/urdu_translation_api.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/provider/language_provider.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';

void showWordDialog(BuildContext context, String url, String word) {
  final FlutterTts _flutterTts = FlutterTts();
  final LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  final NetworkService networkService = NetworkService();

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage(languageProvider.language);
    await _flutterTts.setPitch(1);
    await _flutterTts.speak(text);
  }

  Future<void> _translateText(BuildContext context, String text) async {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    final result = await networkService.translateText(text);

    Navigator.of(context).pop(); // Close the loading dialog

    if (result['success']) {
      final String audioUrl = result['audioUrl'];
      // Display success message or play audio
      // You can implement the audio playback logic here
    } else {
      // Display failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'])),
      );
    }
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Styling.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              url,
              height: 160.h,
              width: 160.w,
            ),
            SizedBox(height: 20.h),
            Text(
              word,
              style: CustomTextStyle.font_20,
            ),
            SizedBox(height: 18.h),
            IconButton(
              icon: Icon(
                Icons.play_circle_outline_sharp,
                color: Styling.darkBlue,
                size: 40.w,
              ),
              onPressed: () {
                if (languageProvider.language == 'ur-PK') {
                  _translateText(context, word);
                } else {
                  _speak(word);
                }
              },
            ),
            SizedBox(height: 10.h),
            AuthButton(
              text: "Close",
              func: () {
                Navigator.of(context).pop();
              },
              color: Styling.darkBlue,
            ),
          ],
        ),
      );
    },
  );
}
