import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/domain/translation_repo.dart';
import 'package:speech_therapy/presentation/widgets/auth_button.dart';
import 'package:speech_therapy/provider/language_provider.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class NotePad extends StatefulWidget {
  final TranslationRepository translationRepository;

  const NotePad({super.key, required this.translationRepository});

  @override
  State<NotePad> createState() => _NotePadState();
}

class _NotePadState extends State<NotePad> {
  final TextEditingController _messageController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _flutterTts.setLanguage("ur-PK");
    _flutterTts.setPitch(1);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  Future<void> _translateText(BuildContext context, String text) async {
    _showLoadingDialog(context);

    try {
      final filePath = await widget.translationRepository.translateText(text, context);
      Navigator.of(context).pop(); // Close the loading dialog

      if (filePath != null) {
        _playAudio(filePath);
      } else {
        _showErrorSnackBar('Translation failed.');
      }
    } catch (e) {
      Navigator.of(context).pop(); // Close the loading dialog
      _showErrorSnackBar('Error: ${e.toString()}');
    }
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  Future<void> _playAudio(String filePath) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Translation successful! Playing audio...')),
    );
    final audioPlayer = AudioPlayer();
    await audioPlayer.play(DeviceFileSource(filePath));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LanguageProvider languageProvider = Provider.of<LanguageProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Styling.lightBlue,
        body: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                SizedBox(height: 16.h),
                _buildTextInput(),
                _buildActionButton(languageProvider.language),
                SizedBox(height: 14.h),
              ],
            ),
            _buildHeroImage(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
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
                'Start\nWriting\nToday',
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
    );
  }

  Widget _buildTextInput() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Styling.darkBlue,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: SingleChildScrollView(
            child: TextField(
              controller: _messageController,
              style: TextStyle(color: Colors.white, fontSize: 20),
              cursorColor: Colors.white,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Start Writing...",
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(String language) {
    return AuthButton(
      text: "Convert",
      func: () {
        if (language == 'ur-PK') {
          _translateText(context, _messageController.text);
        } else {
          _speak(_messageController.text);
        }
      },
      color: Styling.darkBlue,
    );
  }

  Widget _buildHeroImage() {
    return Positioned(
      top: 160.h,
      right: 8.w,
      child: Hero(
        tag: 'hero-tag',
        child: Image.asset(
          Images.bird, // Replace with your image path
          width: 100.w,
          height: 100.h,
        ),
      ),
    );
  }
}
