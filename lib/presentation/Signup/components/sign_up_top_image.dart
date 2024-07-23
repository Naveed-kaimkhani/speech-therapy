import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:speech_therapy/style/images.dart';

class SignUpScreenTopImage extends StatelessWidget {
  const SignUpScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sign Up".toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              // child: SvgPicture.asset("assets/images/signup.svg"),
              child: Image.asset(Images.login_icon),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
