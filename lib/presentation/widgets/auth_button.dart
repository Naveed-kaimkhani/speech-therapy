import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  String? text;
  Function()? func;
  Color? color;
  AuthButton({
    required this.text,
    required this.func,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        width: 121.w,
        height: 47.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
