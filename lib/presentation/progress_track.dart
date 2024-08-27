import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_therapy/style/styling.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ProgressTrack extends StatefulWidget {
  const ProgressTrack({super.key});

  @override
  State<ProgressTrack> createState() => _ProgressTrackState();
}

class _ProgressTrackState extends State<ProgressTrack> {
  final SpeechToText _speechToText = SpeechToText();

  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    setState(() {
      _isLoading = true;
    });
    _speechEnabled = await _speechToText.initialize();
    setState(() {
      _isLoading = false;
    });
  }

  void _startListening() async {
    setState(() {
      _isLoading = true;
    });
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      _isLoading = false;
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            '  Speech Translation',
            style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: _isLoading
                ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                : Text(
                    _speechToText.isListening
                        ? "listening..."
                        : _speechEnabled
                            ? "Tap the microphone to start listening..."
                            : "Speech not available",
                    style: TextStyle(fontSize: 20.0),
                  ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                _wordsSpoken,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          if (_speechToText.isNotListening && _confidenceLevel > 0)
            Padding(
              padding: const EdgeInsets.only(
                bottom: 100,
              ),
              child: Center(
                child: Text(
                  "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        tooltip: 'Listen',
        backgroundColor: Styling.darkBlue,
        child: Icon(
          _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
          color: Colors.white,
        ),
      ),
    );
  }
}
