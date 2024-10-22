import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/presentation/navigation_bar.dart';
import 'package:speech_therapy/provider/api_url_provider.dart';
import 'package:speech_therapy/style/styling.dart';

class ApiUrlScreen extends StatefulWidget {
  @override
  _ApiUrlScreenState createState() => _ApiUrlScreenState();
}

class _ApiUrlScreenState extends State<ApiUrlScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUrlTextField(),
            SizedBox(height: 20.h),
            _buildProceedButton(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Enter API URL"),
      backgroundColor: Styling.darkBlue,
    );
  }

  TextField _buildUrlTextField() {
    return TextField(
      controller: _urlController,
      style: TextStyle(color: Colors.black, fontSize: 20.sp),
      decoration: InputDecoration(
        hintText: "Enter API URL",
        hintStyle: TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  ElevatedButton _buildProceedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleProceed(context),
      child: Text("Proceed"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Styling.darkBlue,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        textStyle: TextStyle(fontSize: 18.sp),
      ),
    );
  }

  void _handleProceed(BuildContext context) {
    final apiUrlProvider = Provider.of<ApiUrlProvider>(context, listen: false);
    final url = _urlController.text;

    if (url.isNotEmpty) {
      apiUrlProvider.setApiUrl(url);
      _navigateToNextScreen(context);
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NavigationPage()),
    );
  }
}
