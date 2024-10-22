import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/presentation/Login/login_screen.dart';
import 'package:speech_therapy/style/styling.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(), // Header containing the title and skip button
            SizedBox(height: 30.h),
            _buildImage(context), // Central image for the splash screen
            _buildContent(context), // Text and button content
          ],
        ),
      ),
    );
  }

  /// Builds the header with the app title and skip button.
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText("Speach Buddy", 14.sp, FontWeight.w500),
          _buildText("Skip", 14.sp, FontWeight.w500),
        ],
      ),
    );
  }

  /// Builds the main image in the center of the splash screen.
  Widget _buildImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash.png'),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  /// Builds the content section with three text blocks and a circular button.
  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildText("WHERE KIDS LOVE LEARNING", 12.sp, FontWeight.normal),
          _buildText(
            "Distant Learning & Home \nSchooling Made Easy",
            26.sp,
            FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          _buildText(
            "Design and Development of Speech Therapist Mobile App for Children with Speech Impediment",
            15.sp,
            FontWeight.w300,
            textAlign: TextAlign.center,
          ),
          _buildForwardButton(context), // Circular button for navigation
        ],
      ),
    );
  }

  /// Builds a styled text widget with custom font size, weight, and alignment.
  Widget _buildText(String text, double fontSize, FontWeight fontWeight,
      {TextAlign textAlign = TextAlign.left}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontFamily: 'circe',
      ),
      textAlign: textAlign,
    );
  }

  /// Builds the circular forward button for navigation to the login screen.
  Widget _buildForwardButton(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 15.sp,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Styling.darkBlue,
          ),
          child: IconButton(
            onPressed: () => _navigateToLogin(context),
            icon: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the LoginScreen.
  void _navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
