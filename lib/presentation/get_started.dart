import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/presentation/Login/login_screen.dart';
import 'package:speech_therapy/presentation/navigation_bar.dart';
import 'package:speech_therapy/routes/routes_name.dart';
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
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Speech Therapy",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'circe'),
                  ),
                  Text(
                    "Skip",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'circe'),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.png'),
                      fit: BoxFit.contain)),
            ), 
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "WHERE KIDS LOVE LEARNING",
                    style: TextStyle(fontSize: 12.sp, fontFamily: 'circe'),
                  ),
                  Text(
                    "Distant Learning & Home \nSchooling Made Easy",
                    style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'circe'),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Book Filtered Top Rated Professional \nTutors from the comfort \nOf your home in just a few clicks",
                    style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'circe'),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 15.sp,
                            color: Colors.black.withOpacity(0.1),
                          )),
                      child: Container(
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Styling.darkBlue,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
