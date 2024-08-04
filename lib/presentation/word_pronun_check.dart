// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:dart_levenshtein/dart_levenshtein.dart';


// class WordProgress extends StatefulWidget {
//   @override
//   _WordProgressState createState() => _WordProgressState();
// }

// class _WordProgressState extends State<WordProgress> {
//   stt.SpeechToText? _speech;
//   bool _isListening = false;
//   String _recognizedText = 'Press the button and start speaking';
//   String _targetText = 'apple';
//   double _score = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech!.initialize(
//         onStatus: (val) => print('onStatus: $val'),
//         onError: (val) => print('onError: $val'),
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech!.listen(onResult: (val) => setState(() {
//               _recognizedText = val.recognizedWords;
//               _score = _calculateScore(_recognizedText, _targetText);
//             }));
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech!.stop();
//     }
//   }
// void print()
// {
  
//      print( 'kitten'.levenshteinDistance('sitten'));
// }
//   double _calculateScore(String recognized, String target) {
//     int distance = Levenshtein.distance(recognized, target);
//     int maxLength = target.length > recognized.length ? target.length : recognized.length;
//     return 1 - (distance / maxLength);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Speech Recognition')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Target Word: $_targetText'),
//             Text('Recognized: $_recognizedText'),
//             Text('Score: ${(_score * 100).toStringAsFixed(2)}%'),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _listen,
//         child: Icon(_isListening ? Icons.mic : Icons.mic_none),
//       ),
//     );
//   }
// }
