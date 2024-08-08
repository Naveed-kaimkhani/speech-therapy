import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dart_levenshtein/dart_levenshtein.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';
import 'package:speech_therapy/provider/language_provider.dart';

void showSpeakDialogue(BuildContext context, String targetWord) {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();
  final LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  bool _isListening = false;
  String _recognizedText = 'Press the button and start speaking';
  Future<double> _score = Future.value(0);

  Future<double> _calculateScore(String recognized, String target) async {
    int distance = await levenshteinDistance(recognized, target);
    int maxLength =
        target.length > recognized.length ? target.length : recognized.length;
    return 1 - (distance / maxLength);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage(languageProvider.language);
    await _flutterTts.setPitch(1);
    await _flutterTts.speak(text);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print(""),
        onError: (val) => print(""),
      );
      if (available) {
        _isListening = true;
        _speech.listen(onResult: (val) async {
          _recognizedText = val.recognizedWords;
          _score = _calculateScore(_recognizedText, targetWord);
        });
      }
    } else {
      _isListening = false;
      _speech.stop();
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
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Target Word: $targetWord',
                  style: CustomTextStyle.font_20,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Recognized: $_recognizedText',
                  style: CustomTextStyle.font_18,
                ),
                SizedBox(height: 20.h),
                FutureBuilder<double>(
                  future: _score,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Calculating score...');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Text(
                          'Score: ${(snapshot.data! * 100).toStringAsFixed(2)}%');
                    } else {
                      return Text('Score: 0%');
                    }
                  },
                ),
                SizedBox(height: 20.h),
                IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Styling.darkBlue,
                    size: 40.w,
                  ),
                  onPressed: () {
                    setState(() {
                      _listen();
                    });
                  },
                ),
                SizedBox(height: 10.h),
                // IconButton(
                //   icon: Icon(
                //     Icons.play_circle_outline_sharp,
                //     color: Styling.darkBlue,
                //     size: 40.w,
                //   ),
                //   onPressed: () {
                //     _speak(targetWord);
                //   },
                // ),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styling.darkBlue,
                  ),
                  child: Text("Close"),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}
