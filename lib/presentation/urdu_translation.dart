import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class UrduTranslation extends StatefulWidget {
  @override
  _UrduTranslationState createState() => _UrduTranslationState();
}

class _UrduTranslationState extends State<UrduTranslation> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String? _translatedText;
  String? _audioUrl;

  Future<void> _translateText() async {
    final String text = _controller.text;
    final url = Uri.parse('http://192.168.100.44:5000/translate');

    setState(() {
      _isLoading = true;
      _translatedText = null;
      _audioUrl = null;
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final String audioUrl =
            response.headers['content-disposition']!.split('filename=')[1];
        setState(() {
          _translatedText = 'Translation Successful';
          _audioUrl = audioUrl;
        });
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
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                cursorColor: Colors.white,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Enter text to translate...",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                ),
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
                          ElevatedButton(
                            onPressed: () {
                              // Logic to play the audio from _audioUrl
                            },
                            child: Text('Play Translated Audio'),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 14.h,
                )
              ],
            ),
            Positioned(
              top: 160.h, // Adjust as needed
              right: 8.w, // Adjust as needed
              child: Hero(
                tag: 'hero-tag',
                child: Image.asset(
                  Images.bird, // Replace with your image path
                  width: 100.w, // Adjust size as needed
                  height: 100.h, // Adjust size as needed
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
