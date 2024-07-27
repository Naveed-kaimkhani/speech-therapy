// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:speech_therapy/presentation/widgets/auth_button.dart';
// import 'package:speech_therapy/style/custom_text_style.dart';
// import 'package:speech_therapy/style/styling.dart';

// void showWordDialog(context, String url, String word) {
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
//           children: [
//             Image.asset(
//               url,
//               // fit: BoxFit.cover,
//               height: 100.h,
//               width: 100.w,
//             ),
//             SizedBox(height: 20.h),
//             Text(
//               // widget.word.name,
//               word,
//               style: CustomTextStyle.font_20,
//             ),
//             SizedBox(height: 20.h),
//             IconButton(
//               icon: Icon(Icons.volume_up, color: Styling.darkBlue),
//               onPressed: () {
//                 // _speak(widget.word.name);
//               },
//             ),
//           ],
//         ),
//         actions: [
//           AuthButton(
//               text: "Close",
//               // style: CustomTextStyle.button_text,
//               func: () {
//                 Navigator.of(context).pop();
//               },
//               color: Styling.darkBlue)

//         ],
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';

void showWordDialog(BuildContext context, String url, String word) {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage("en-US"); // Set language as needed
    await _flutterTts.setPitch(1); // Adjust pitch as needed
    await _flutterTts.speak(text);
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
            SizedBox(height: 20.h),
            IconButton(
              icon: Icon(
                Icons.play_circle_outline_sharp,
                color: Styling.darkBlue,
                size: 30.w,
              ),
              onPressed: () {
                _speak(word);
              },
            ),
          ],
        ),
        actions: [
          AuthButton(
            text: "Close",
            func: () {
              Navigator.of(context).pop();
            },
            color: Styling.darkBlue,
          ),
        ],
      );
    },
  );
}
