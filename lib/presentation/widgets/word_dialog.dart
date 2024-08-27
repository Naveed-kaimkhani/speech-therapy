import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/Data/translation_services.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/provider/language_provider.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';

void showWordDialog(BuildContext context, String url, String word) {
  final FlutterTts _flutterTts = FlutterTts();
  final LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  final TranslationService translationService = TranslationService();

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

    try {
      final filePath = await translationService.translateText(text,context);

      Navigator.of(context).pop(); // Close the loading dialog

      if (filePath != null) {
        // Play the translated audio using a player package, e.g., audioplayers
        // Example using the audioplayers package:
        final audioPlayer = AudioPlayer();
      await audioPlayer.play(DeviceFileSource(filePath ?? ''));

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Translation successful! Playing audio...')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Translation failed.')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
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
