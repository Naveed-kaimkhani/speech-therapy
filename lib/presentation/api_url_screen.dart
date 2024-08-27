import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/presentation/navigation_bar.dart';
import 'package:speech_therapy/presentation/urdu_translation.dart';
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
        final apiUrlProvider = Provider.of<ApiUrlProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Styling.lightBlue,
      appBar: AppBar(
        title: Text("Enter API URL"),
        backgroundColor: Styling.darkBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
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
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                 final url = _urlController.text;
                if (url.isNotEmpty) {
                  apiUrlProvider.setApiUrl(url);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()), // Replace with the next screen
                  );
                }
              },
              child: Text("Proceed"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Styling.darkBlue,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                textStyle: TextStyle(fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
