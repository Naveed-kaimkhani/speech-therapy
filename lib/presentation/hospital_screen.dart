import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalScreen extends StatelessWidget {
  final List<Hospital> Hospitals = [
    Hospital('Fever', 'asset/images/thank.png'),
    Hospital('First Aid ', 'asset/images/sleep.png'),
    Hospital('Doctor', 'asset/images/eat.png'),
    Hospital('Medicines', 'asset/images/sleep.png'),
    // Add more Hospitals here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospitals'),
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
          itemCount: Hospitals.length,
          itemBuilder: (context, index) {
            return HospitalCard(hospital: Hospitals[index]);
          },
        ),
      ),
    );
  }
}

class Hospital {
  final String name;
  final String imageUrl;

  Hospital(this.name, this.imageUrl);
}

class HospitalCard extends StatefulWidget {
  final Hospital hospital;

  HospitalCard({required this.hospital});

  @override
  _HospitalCardState createState() => _HospitalCardState();
}

class _HospitalCardState extends State<HospitalCard>
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
                widget.hospital.imageUrl,
                height: 60.h,
                width: 60.w,
              ),
              SizedBox(height: 8.h),
              Text(
                widget.hospital.name,
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
