import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class GetData extends StatefulWidget {
  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  final titleController = TextEditingController();
  final messageController = TextEditingController();
  String? date;

  void showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Center(child: Text(title, style: const TextStyle(fontSize: 30))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cancel, color: Colors.red, size: 130),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void showSuccessDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              Center(child: Text(title, style: const TextStyle(fontSize: 30))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 130),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void saveData() {
    if (titleController.text.isEmpty && messageController.text.isEmpty) {
      showErrorDialog('Error', 'Enter Some Data Before Saving');
    } else {
      // Simulate saving data
      Navigator.pop(context);
      showSuccessDialog('Data Saved', 'Your Data has been saved Successfully');
    }
  }

  void updateData() {
    if (titleController.text.isEmpty && messageController.text.isEmpty) {
      showErrorDialog('Error', 'Update Some Data Before Updating');
    } else {
      // Simulate updating data
      Navigator.pop(context);
      showSuccessDialog(
        'Data Updated',
        'Your Data has been Updated Successfully',
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Setting an initial date for display purposes
    date = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      body: Column(
        children: [
          Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: Styling.darkBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(34.r),
                bottomRight: Radius.circular(34.r),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  // child: Image.asset(Images.login_icon),
                  child: SvgPicture.asset(
                Images.write,
                height: 100.h,
              )),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                date!,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Styling.darkBlue, // Brighter color for kids
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: "Enter message....",
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize:
                              20), // Changed text color for better visibility
                    ),
                  ),
                  Positioned(
                    right: -20, // Adjust the position to ensure overlap
                    top: -20, // Adjust the position to ensure overlap
                    child: Container(
                      height: 100, // Adjust height as needed
                      width: 100, // Adjust width as needed
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Match the text box radius
                        child: Image.asset(
                          Images.bird, // Replace with the actual image path
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Convert"),
          ),
        ],
      ),
    );
  }
}
