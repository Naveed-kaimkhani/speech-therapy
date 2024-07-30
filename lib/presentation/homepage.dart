import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/fruits.dart';
import 'package:speech_therapy/presentation/hospital_screen.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/words_screen.dart';
import 'package:speech_therapy/routes/routes_name.dart';
import 'package:speech_therapy/style/images.dart';
import 'package:speech_therapy/style/styling.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homePage(),
    );
  }
}

// ignore: must_be_immutable
class homePage extends StatefulWidget {
  homePage({super.key});
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Set the visibility to true after a short delay to trigger the animation
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styling.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.black,
            size: 30.w,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 30.w,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/searchBg.png"))),
            child: Container(
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
                  SizedBox(
                    height: 5.h,
                  ),
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
                            style:
                                TextStyle(fontSize: 16.sp, fontFamily: 'circe'),
                            decoration: const InputDecoration(
                                border: InputBorder.none, hintText: "Search "),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 30.h,
                  // )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 12.w, right: 12.w),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Top Categories",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "See all",
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 13),
                      )
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: const Duration(seconds: 1),
                            child: tutorWidget(
                                Images.thinking,
                                "Words",
                                "Daily word learning is fun.",
                                "1-100",
                                "",
                                Styling.lightBlue.withOpacity(0.5),
                                WordsScreen()),
                          ),
                          AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: const Duration(seconds: 1),
                            child: tutorWidget(
                                Images.sent,
                                "Sentences",
                                "Improve language fluency daily",
                                "1-10",
                                "",
                                const Color.fromARGB(255, 206, 246, 214),
                                SentenceScreen()),
                          ),
                          AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: const Duration(seconds: 1),
                            child: tutorWidget(
                              Images.hospital,
                              "Hospital",
                              "Hospital",
                              "1-100",
                              "",
                              const Color.fromARGB(255, 245, 232, 203),
                              HospitalScreen(),
                            ),
                          ),
                          AnimatedOpacity(
                            opacity: _visible ? 1.0 : 0.0,
                            duration: const Duration(seconds: 1),
                            child: tutorWidget(
                              Images.fruits,
                              "Fruits",
                              "Fruits",
                              "1-100",
                              "",
                              Color.fromARGB(255, 224, 220, 235),
                              FruitScreen(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InkWell tutorWidget(String img, String name, String subj, String grade,
      String price, Color color, Widget route) {
    return InkWell(
      onTap: () {
        // Navigator.pushNamed(context, route);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );

        // Navigator.pushNamed(context, routeName)
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
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(30.h)),
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
              child: Container(
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
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 19.sp, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '$subj',
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
