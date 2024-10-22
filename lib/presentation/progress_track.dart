import 'package:flutter/material.dart';
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

  bool _speechEnabled = false; // To track if speech recognition is enabled
  String _wordsSpoken = ""; // To hold the recognized words
  double _confidenceLevel = 0; // To hold the confidence level of recognition
  bool _isLoading = false; // To track loading state

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  // Initialize speech recognition
  void initSpeech() async {
    setState(() {
      _isLoading = true; // Set loading state to true while initializing
    });
    _speechEnabled = await _speechToText.initialize(); // Initialize speech recognition
    setState(() {
      _isLoading = false; // Set loading state to false after initialization
    });
  }

  // Start listening to speech
  void _startListening() async {
    setState(() {
      _isLoading = true; // Set loading state to true while starting listening
    });
    await _speechToText.listen(onResult: _onSpeechResult); // Start listening with result callback
    setState(() {
      _isLoading = false; // Set loading state to false after starting listening
      _confidenceLevel = 0; // Reset confidence level
    });
  }

  // Stop listening to speech
  void _stopListening() async {
    await _speechToText.stop(); // Stop listening
    setState(() {}); // Update state to reflect stopping
  }

  // Handle speech recognition results
  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}"; // Update recognized words
      _confidenceLevel = result.confidence; // Update confidence level
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
              padding: EdgeInsets.all(16.w),
              child: Text(
                _wordsSpoken, // Display recognized words
                style:  TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          if (_speechToText.isNotListening && _confidenceLevel > 0)
            Padding(
              padding:  EdgeInsets.only(
                bottom: 100.h,
              ),
              child: Center(
                child: Text(
                  "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%", // Display confidence level
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
