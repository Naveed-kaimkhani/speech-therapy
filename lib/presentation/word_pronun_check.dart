// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:dart_levenshtein/dart_levenshtein.dart';

// // class WordProgress extends StatefulWidget {
// //   final String targetWord;

// //   const WordProgress({super.key, required this.targetWord});
// //   @override
// //   _WordProgressState createState() => _WordProgressState();
// // }

// // class _WordProgressState extends State<WordProgress> {
// //   stt.SpeechToText? _speech;
// //   bool _isListening = false;
// //   String _recognizedText = 'Press the button and start speaking';
// //   // final String _targetText = 'apple';
// //   Future<double> _score = Future.value(0);

// //   @override
// //   void initState() {
// //     super.initState();
// //     _speech = stt.SpeechToText();
// //   }

// //   void _listen() async {
// //     if (!_isListening) {
// //       bool available = await _speech!.initialize(
// //         onStatus: (val) => print(""),
// //         onError: (val) => print("errorrrrrrrrrrr"),
// //       );
// //       if (available) {
// //         setState(() => _isListening = true);
// //         _speech!.listen(
// //             onResult: (val) => setState(() {
// //                   _recognizedText = val.recognizedWords;
// //                   _score = _calculateScore(_recognizedText, widget.targetWord);
// //                 }));
// //       }
// //     } else {
// //       setState(() => _isListening = false);
// //       _speech!.stop();
// //     }
// //   }

// //   Future<double> _calculateScore(String recognized, String target) async {
// //     //  print('kitten'.levenshteinDistance('sitten'));
// //     int distance = await levenshteinDistance(recognized, target);
// //     int maxLength =
// //         target.length > recognized.length ? target.length : recognized.length;
// //     return 1 - (distance / maxLength);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Speech Recognition')),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text('Target Word: ${widget.targetWord}'),
// //             Text('Recognized: $_recognizedText'),
// //             // Text('Score: ${(_score * 100).toStringAsFixed(2)}%'),
// //             FutureBuilder<double>(
// //               future: _score,
// //               builder: (context, snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.waiting) {
// //                   return Text('Calculating score...');
// //                 } else if (snapshot.hasError) {
// //                   return Text('Error: ${snapshot.error}');
// //                 } else if (snapshot.hasData) {
// //                   return Text(
// //                       'Score: ${(snapshot.data! * 100).toStringAsFixed(2)}%');
// //                 } else {
// //                   return Text('Score: 0%');
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _listen,
// //         child: Icon(_isListening ? Icons.mic : Icons.mic_none),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:dart_levenshtein/dart_levenshtein.dart';
// import 'package:speech_therapy/style/custom_text_style.dart';
// import 'package:speech_therapy/style/styling.dart';

// class WordProgress extends StatefulWidget {
//   final String targetWord;
//   final String imageUrl;

//   const WordProgress({super.key, required this.targetWord, required this.imageUrl});

//   @override
//   _WordProgressState createState() => _WordProgressState();
// }

// class _WordProgressState extends State<WordProgress> {
//   stt.SpeechToText? _speech;
//   bool _isListening = false;
//   String _recognizedText = 'Press the button and start speaking';
//   Future<double> _score = Future.value(0);
//   final FlutterTts _flutterTts = FlutterTts();

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech!.initialize(
//         onStatus: (val) => print("Status: $val"),
//         onError: (val) => print("Error initializing speech recognition"),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech!.listen(
//             onResult: (val) => setState(() {
//                   _recognizedText = val.recognizedWords;
//                   _score = _calculateScore(_recognizedText, widget.targetWord);
//                 }));
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech!.stop();
//     }
//   }

//   Future<double> _calculateScore(String recognized, String target) async {
//     int distance = await levenshteinDistance(recognized, target);
//     int maxLength =
//         target.length > recognized.length ? target.length : recognized.length;
//     return 1 - (distance / maxLength);
//   }

//   Future<void> _speak(String text) async {
//     await _flutterTts.setLanguage('en-US'); // Adjust language as needed
//     await _flutterTts.setPitch(1);
//     await _flutterTts.speak(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Styling.lightBlue,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Word Progress', style: CustomTextStyle.font_18),
//         backgroundColor: Styling.darkBlue,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset(widget.imageUrl),
//               Text(
//                 'Target Word: ${widget.targetWord}',
//                 style: CustomTextStyle.font_20,
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 'Recognized: $_recognizedText',
//                 style: CustomTextStyle.font_16,
//               ),
//               SizedBox(height: 20.h),
//               FutureBuilder<double>(
//                 future: _score,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Text('Calculating score...',
//                         style: CustomTextStyle.font_18);
//                   } else if (snapshot.hasError) {
//                     return Text('Error: ${snapshot.error}',
//                         style: CustomTextStyle.font_18);
//                   } else if (snapshot.hasData) {
//                     return Text(
//                         'Score: ${(snapshot.data! * 100).toStringAsFixed(2)}%',
//                         style: CustomTextStyle.font_20);
//                   } else {
//                     return Text('Score: 0%', style: CustomTextStyle.font_18);
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _listen,
//         backgroundColor: Styling.darkBlue,
//         child: Icon(
//           _isListening ? Icons.mic : Icons.mic_off_rounded,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dart_levenshtein/dart_levenshtein.dart';
import 'package:speech_therapy/style/custom_text_style.dart';
import 'package:speech_therapy/style/styling.dart';

class WordProgress extends StatefulWidget {
  final String targetWord;
  final String imageUrl;

  const WordProgress({super.key, required this.targetWord, required this.imageUrl});

  @override
  _WordProgressState createState() => _WordProgressState();
}

class _WordProgressState extends State<WordProgress> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  bool _isLoading = false;
  String _recognizedText = 'Press the button and start speaking';
  Future<double> _score = Future.value(0);
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      setState(() => _isLoading = true);
      bool available = await _speech!.initialize(
        onStatus: (val) => print("Status: $val"),
        // onError: (val) => print("Error initializing speech recognition"),
        
        onError: (val) => print(val.toString()),
      );
      setState(() => _isLoading = false);

      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
            onResult: (val) => setState(() {
                  _recognizedText = val.recognizedWords;
                  _score = _calculateScore(_recognizedText, widget.targetWord);
                }));
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }

  Future<double> _calculateScore(String recognized, String target) async {
    int distance = await levenshteinDistance(recognized, target);
    int maxLength =
        target.length > recognized.length ? target.length : recognized.length;
    return 1 - (distance / maxLength);
  }

  Future<void> _speak(String text) async {
    setState(() => _isLoading = true);
    await _flutterTts.setLanguage('en-US'); // Adjust language as needed
    await _flutterTts.setPitch(1);
    await _flutterTts.speak(text);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Word Progress', style: CustomTextStyle.font_18),
        backgroundColor: Styling.darkBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(widget.imageUrl),
              Text(
                'Target Word: ${widget.targetWord}',
                style: CustomTextStyle.font_20,
              ),
              SizedBox(height: 20.h),
              Text(
                'Recognized: $_recognizedText',
                style: CustomTextStyle.font_16,
              ),
              SizedBox(height: 20.h),
              _isLoading
                  ? CircularProgressIndicator()
                  : FutureBuilder<double>(
                      future: _score,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text('Calculating score...',
                              style: CustomTextStyle.font_18);
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}',
                              style: CustomTextStyle.font_18);
                        } else if (snapshot.hasData) {
                          return Text(
                              'Score: ${(snapshot.data! * 100).toStringAsFixed(2)}%',
                              style: CustomTextStyle.font_20);
                        } else {
                          return Text('Score: 0%', style: CustomTextStyle.font_18);
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        backgroundColor: Styling.darkBlue,
        child: Icon(
          _isListening ? Icons.mic : Icons.mic_off_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
