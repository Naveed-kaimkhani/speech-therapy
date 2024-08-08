import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dart_levenshtein/dart_levenshtein.dart';


class WordProgress extends StatefulWidget {
  final String targetWord;

  const WordProgress({super.key, required this.targetWord});
  @override
  _WordProgressState createState() => _WordProgressState();
}

class _WordProgressState extends State<WordProgress> {
  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _recognizedText = 'Press the button and start speaking';
  // final String _targetText = 'apple';
  Future<double> _score = Future.value(0);

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print(""),
        onError: (val) => print(""),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(onResult: (val) => setState(() {
              _recognizedText = val.recognizedWords;
              _score = _calculateScore(_recognizedText, widget.targetWord);
            }));
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }
 Future<double> _calculateScore(String recognized, String target) async{
  //  print('kitten'.levenshteinDistance('sitten'));
  int distance = await levenshteinDistance(recognized,target);
  int maxLength = target.length > recognized.length ? target.length : recognized.length;
  return 1 - (distance / maxLength);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speech Recognition')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Target Word: $widget.targetWord'),
            Text('Recognized: $_recognizedText'),
            // Text('Score: ${(_score * 100).toStringAsFixed(2)}%'),
            FutureBuilder<double>(
              future: _score,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Calculating score...');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  return Text('Score: ${(snapshot.data! * 100).toStringAsFixed(2)}%');
                } else {
                  return Text('Score: 0%');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening ? Icons.mic : Icons.mic_none),
      ),
    );
  }
}

