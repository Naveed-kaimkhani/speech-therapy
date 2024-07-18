import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SentenceScreen extends StatelessWidget {
  final List<Sentence> Sentences = [
    Sentence('I am walking', 'asset/images/thank.png'),
    Sentence('I am Eating ', 'asset/images/sleep.png'),
    Sentence('I am Playing', 'asset/images/eat.png'),
    Sentence('I am Drinking', 'asset/images/sleep.png'),
    // Add more Sentences here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sentences'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
          ),
          itemCount: Sentences.length,
          itemBuilder: (context, index) {
            return SentenceCard(sentence: Sentences[index]);
          },
        ),
      ),
    );
  }
}

class Sentence {
  final String name;
  final String imageUrl;

  Sentence(this.name, this.imageUrl);
}

class SentenceCard extends StatefulWidget {
  final Sentence sentence;

  SentenceCard({ required this.sentence});

  @override
  _SentenceCardState createState() => _SentenceCardState();
}

class _SentenceCardState extends State<SentenceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Card(
        color: Colors.lightBlue.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: InkWell(
          onTap: () {
            // Add any additional interactions here
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.sentence.imageUrl,
                height: 60.h,
                width: 60.w,
              ),
              SizedBox(height: 8.h),
              Text(
                widget.sentence.name,
                style: TextStyle(
                  fontSize: 50.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
