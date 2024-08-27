
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:audioplayers/audioplayers.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:speech_therapy/presentation/widgets/auth_button.dart';
// import 'package:speech_therapy/style/images.dart';
// import 'package:speech_therapy/style/styling.dart';

// class UrduTranslation extends StatefulWidget {
//   @override
//   _UrduTranslationState createState() => _UrduTranslationState();
// }

// class _UrduTranslationState extends State<UrduTranslation> {
//   final TextEditingController _textController = TextEditingController();
//   final TextEditingController _urlController =
//       TextEditingController(); // New controller for URL
//   bool _isLoading = false;
//   String? _translatedText;
//   String? _audioUrl;
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   Future<void> _translateText() async {
//     final String text = _textController.text;
//     final String urlInput = _urlController.text.isNotEmpty
//         ? _urlController.text
//         : 'http://192.168.43.135:5000/translate'; // Use entered URL if available

//     final url = Uri.parse(urlInput);

//     setState(() {
//       _isLoading = true;
//       _translatedText = null;
//       _audioUrl = null;
//     });

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'text': text}),
//       );

//       if (response.statusCode == 200) {
//         final String filePath = await _getFilePath('translated_speech.mp3');
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);

//         setState(() {
//           _translatedText = 'Translation Successful';
//           _audioUrl = filePath;
//         });
//         // Show success Snackbar
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//                 'Translation successful! Status code: ${response.statusCode}'),
//             backgroundColor: Colors.green,
//           ),
//         );
//       } else {
//         setState(() {
//           _translatedText = 'Translation Failed';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _translatedText = 'Error: $e';
//       });
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _playAudio() async {
//     if (_audioUrl != null) {
//       await _audioPlayer.play(DeviceFileSource(_audioUrl ?? ''));
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   Future<String> _getFilePath(String fileName) async {
//     final directory = await getApplicationDocumentsDirectory();
//     return '${directory.path}/$fileName';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Styling.lightBlue,
//         body: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   height: 160.h,
//                   decoration: BoxDecoration(
//                     color: Styling.darkBlue,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(34.r),
//                       bottomRight: Radius.circular(34.r),
//                     ),
//                   ),
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(left: 12.w, top: 4.h),
//                           child: Text(
//                             'Urdu Translation',
//                             textAlign: TextAlign.center,
//                             style: GoogleFonts.pacifico(
//                               textStyle: TextStyle(
//                                 fontSize: 26.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                         SvgPicture.asset(
//                           Images.write,
//                           height: 150.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.all(16.w),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(20.w),
//                             decoration: BoxDecoration(
//                               color: Styling.darkBlue,
//                               borderRadius: BorderRadius.circular(20.r),
//                             ),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 children: [
//                                   TextField(
//                                     controller: _textController,
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 20),
//                                     cursorColor: Colors.white,
//                                     maxLines: null,
//                                     decoration: InputDecoration(
//                                       hintText: "Enter text to translate...",
//                                       hintStyle:
//                                           TextStyle(color: Colors.white70),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                   SizedBox(height: 16.h),
//                                   TextField(
//                                     controller:
//                                         _urlController, // New TextField for URL
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 20),
//                                     cursorColor: Colors.white,
//                                     decoration: InputDecoration(
//                                       hintText: "Enter API URL (optional)...",
//                                       hintStyle:
//                                           TextStyle(color: Colors.white70),
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 16.h),
//                         _isLoading
//                             ? CircularProgressIndicator()
//                             : AuthButton(
//                                 text: "Translate",
//                                 func: _translateText,
//                                 color: Styling.darkBlue,
//                               ),
//                         SizedBox(height: 16.h),
//                         GestureDetector(
//                           onTap: _playAudio,
//                           child: Icon(
//                             Icons.play_circle_outline_outlined,
//                             size: 60.w,
//                             color: Styling.darkBlue,
//                           ),
//                         ),
//                         if (_translatedText != null) Text(_translatedText!),
//                         if (_audioUrl != null)
//                           ElevatedButton(
//                             onPressed: _playAudio,
//                             child: Text('Play Translated Audio'),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 14.h),
//               ],
//             ),
//             Positioned(
//               top: 160.h,
//               right: 8.w,
//               child: Hero(
//                 tag: 'hero-tag',
//                 child: Image.asset(
//                   Images.bird,
//                   width: 100.w,
//                   height: 100.h,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:speech_therapy/Data/translation_services.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class UrduTranslation extends StatefulWidget {
  @override
  _UrduTranslationState createState() => _UrduTranslationState();
}

class _UrduTranslationState extends State<UrduTranslation> {
  final TextEditingController _textController = TextEditingController();
  // final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  String? _translatedText;
  String? _audioUrl;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final TranslationService _translationService = TranslationService(); // Initialize the service

  Future<void> _translateText() async {
    final String text = _textController.text;
    // final String? apiUrl = _urlController.text.isNotEmpty ? _urlController.text : null;

    setState(() {
      _isLoading = true;
      _translatedText = null;
      _audioUrl = null;
    });

    try {
      final filePath = await _translationService.translateText(text, context);
      if (filePath != null) {
        setState(() {
          _translatedText = 'Translation Successful';
          _audioUrl = filePath;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Translation successful!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          _translatedText = 'Translation Failed';
        });
      }
    } catch (e) {
      setState(() {
        _translatedText = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _playAudio() async {
    if (_audioUrl != null) {
      await _audioPlayer.play(DeviceFileSource(_audioUrl ?? ''));
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 160.h,
                  decoration: BoxDecoration(
                    color: Styling.darkBlue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(34.r),
                      bottomRight: Radius.circular(34.r),
                    ),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.w, top: 4.h),
                          child: Text(
                            'Urdu Translation',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.pacifico(
                              textStyle: TextStyle(
                                fontSize: 26.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          Images.write,
                          height: 150.h,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Styling.darkBlue,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _textController,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    cursorColor: Colors.white,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: "Enter text to translate...",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        _isLoading
                            ? CircularProgressIndicator()
                            : AuthButton(
                                text: "Translate",
                                func: _translateText,
                                color: Styling.darkBlue,
                              ),
                        SizedBox(height: 16.h),
                       
                        if (_translatedText != null) Text(_translatedText!),
                        if (_audioUrl != null)
                          
                           GestureDetector(
                          onTap: _playAudio,
                          child: Icon(
                            Icons.play_circle_outline_outlined,
                            size: 60.w,
                            color: Styling.darkBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
              ],
            ),
            Positioned(
              top: 160.h,
              right: 8.w,
              child: Hero(
                tag: 'hero-tag',
                child: Image.asset(
                  Images.bird,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
