import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerExample extends StatefulWidget {
  @override
  _AudioPlayerExampleState createState() => _AudioPlayerExampleState();
}

class _AudioPlayerExampleState extends State<AudioPlayerExample> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  Future<void> playOpusAudio() async {
    try {
      // Load and play the OPUS file from assets
      await _audioPlayer.setUrl('assets/audio/Fever.opus');
      _audioPlayer.play();
      setState(() {
        isPlaying = true;
      });
    } catch (e) {
      print("Error playing audio: $e");
    }
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OPUS Audio Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: isPlaying ? stopAudio : playOpusAudio,
              child: Text(isPlaying ? "Stop Audio" : "Play Audio"),
            ),
          ],
        ),
      ),
    );
  }
}
