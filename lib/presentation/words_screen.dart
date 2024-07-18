import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WordsScreen extends StatelessWidget {
  final List<Word> words = [
    Word('Thank you', 'asset/images/thank.png'),
    Word('Please ', 'asset/images/sleep.png'),
    Word('Eat ', 'asset/images/eat.png'),
    Word('Sleep', 'asset/images/sleep.png'),
    // Add more words here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Words'),
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
          itemCount: words.length,
          itemBuilder: (context, index) {
            return WordCard(word: words[index]);
          },
        ),
      ),
    );
  }
}

class Word {
  final String name;
  final String imageUrl;

  Word(this.name, this.imageUrl);
}

class WordCard extends StatefulWidget {
  final Word word;

  WordCard({required this.word});

  @override
  _WordCardState createState() => _WordCardState();
}

class _WordCardState extends State<WordCard>
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
                widget.word.imageUrl,
                height: 100.h,
                width: 100.w,
              ),
              // SizedBox(height: 8.h),
              Text(
                widget.word.name,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
