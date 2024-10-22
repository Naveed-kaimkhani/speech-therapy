import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/style/styling.dart';

class TutorWidget extends StatelessWidget {
  final String img;
  final String name;
  final String subj;
  final String grade;
  final Color color;
  final Widget route;

  const TutorWidget({
    Key? key,
    required this.img,
    required this.name,
    required this.subj,
    required this.grade,
    required this.color,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 20.h),
        height: 150.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30.r)),
          color: color,
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.h)),
                  child: Container(
                    height: 125.h,
                    width: 150.w,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/iconBgNew.png'),
                            fit: BoxFit.contain)),
                  ),
                ),
                Positioned(
                  left: 4.w,
                  child: Hero(
                    tag: img,
                    child: Container(
                      width: 100.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(img), fit: BoxFit.cover)),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Limit $grade",
                          style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 19.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      subj,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Styling.darkBlue,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "5 words/day",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
