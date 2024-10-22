import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:speech_therapy/main.dart';
import 'package:speech_therapy/presentation/Progress.dart';
import 'package:speech_therapy/presentation/homepage.dart';
import 'package:speech_therapy/presentation/notepad.dart';
import 'package:speech_therapy/style/styling.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List pages = [
    HomePage(),
    NotePad(translationRepository: getIt(),),
    TabBarScreen(),
    HomePage(),
  ];
  int currentindex = 0;
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Styling.darkBlue,
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 16.h),
        child: GNav(
          backgroundColor: Styling.darkBlue,
          color: Colors.white,
          activeColor: Styling.darkBlue,
          tabBackgroundColor: Colors.white,
          padding: EdgeInsets.all(1.w),
          gap: 8,
          onTabChange: onTap,
          tabs: const [
            GButton(
              icon: Icons.grid_view_rounded,
              text: "Home",
            ),
            GButton(
              icon: Icons.note_alt_rounded,
              text: "Notepad",
            ),
            GButton(
              icon: Icons.hourglass_bottom_rounded,
              text: "Progress",
            ),
            GButton(
              icon: Icons.settings_outlined,
              text: "Setting",
            ),
          ],
        ),
      ),
      body: pages[currentindex],
    );
  }
}
