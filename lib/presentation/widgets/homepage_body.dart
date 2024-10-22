import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/presentation/fruits.dart';
import 'package:speech_therapy/presentation/hospital_screen.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/widgets/tutor_widget.dart';
import 'package:speech_therapy/presentation/words_screen.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: [
                _buildTopCategoriesHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (_visible) ...[
                          TutorWidget(
                            img: Images.thinking,
                            name: "Words",
                            subj: "Daily word learning is fun.",
                            grade: "1-100",
                            color: Styling.lightBlue.withOpacity(0.5),
                            route: WordsScreen(),
                          ),
                          TutorWidget(
                            img: Images.sent,
                            name: "Sentences",
                            subj: "Improve language fluency daily",
                            grade: "1-10",
                            color: const Color.fromARGB(255, 206, 246, 214),
                            route: SentenceScreen(),
                          ),
                          TutorWidget(
                            img: Images.hospital,
                            name: "Hospital",
                            subj: "Hospital",
                            grade: "1-100",
                            color: const Color.fromARGB(255, 245, 232, 203),
                            route: HospitalScreen(),
                          ),
                          TutorWidget(
                            img: Images.fruits,
                            name: "Fruits",
                            subj: "Fruits",
                            grade: "1-100",
                            color: const Color.fromARGB(255, 224, 220, 235),
                            route: FruitScreen(),
                          ),
                        ],
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/searchBg.png"))),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello",
              style: TextStyle(fontSize: 16.sp, fontFamily: 'circe'),
            ),
            Text(
              "Shiza",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'circe',
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5.h),
            Expanded(child: Container()),
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.w)),
                  color: Colors.white),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: 20.w,
                    ),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      style: TextStyle(fontSize: 16.sp, fontFamily: 'circe'),
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "Search "),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopCategoriesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Top Categories",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        const Text(
          "See all",
          style: TextStyle(color: Colors.blueAccent, fontSize: 13),
        )
      ],
    );
  }
}
