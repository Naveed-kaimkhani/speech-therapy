// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_therapy/presentation/widgets/auth_button.dart';
// import 'package:speech_therapy/provider/language_provider.dart';
// import 'package:speech_therapy/style/custom_text_style.dart';
// import 'package:speech_therapy/style/styling.dart';

// void showWordDialog(BuildContext context, String url, String word) {
//   final FlutterTts _flutterTts = FlutterTts();
//   final LanguageProvider languageProvider =
//       Provider.of<LanguageProvider>(context, listen: false);

//   Future<void> _speak(String text) async {
//     await _flutterTts.setLanguage(languageProvider.language);
//     await _flutterTts.setPitch(1);
//     await _flutterTts.speak(text);
//   }

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: Styling.lightBlue,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.r),
//         ),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               url,
//               height: 160.h,
//               width: 160.w,
//             ),
//             SizedBox(height: 20.h),
//             Text(
//               word,
//               style: CustomTextStyle.font_20,
//             ),
//             SizedBox(height: 18.h),
//             IconButton(
//               icon: Icon(
//                 Icons.play_circle_outline_sharp,
//                 color: Styling.darkBlue,
//                 size: 40.w,
//               ),
//               onPressed: () {
//                 _speak(word);
//               },
//             ),
//             SizedBox(height: 10.h),
//             AuthButton(
//               text: "Close",
//               func: () {
//                 Navigator.of(context).pop();
//               },
//               color: Styling.darkBlue,
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/provider/language_provider.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void showWordDialog(BuildContext context, String url, String word) {
  final FlutterTts _flutterTts = FlutterTts();
  final LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage(languageProvider.language);
    await _flutterTts.setPitch(1);
    await _flutterTts.speak(text);
  }

  Future<void> _translateText(BuildContext context, String text) async {
    final url = Uri.parse('http://192.168.100.44:5000/translate');

    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      Navigator.of(context).pop(); // Close the loading dialog

      if (response.statusCode == 200) {
        final String audioUrl =
            response.headers['content-disposition']!.split('filename=')[1];
        // Display success message or play audio
        // You can implement the audio playback logic here
      } else {
        // Display failure message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Translation Failed')),
        );
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
