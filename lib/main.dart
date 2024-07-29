import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/fruits.dart';
import 'package:speech_therapy/presentation/Login/login_screen.dart';
import 'package:speech_therapy/presentation/Signup/signup_screen.dart';
import 'package:speech_therapy/presentation/get_started.dart';
import 'package:speech_therapy/presentation/homepage.dart';
import 'package:speech_therapy/presentation/hospital_screen.dart';
import 'package:speech_therapy/presentation/navigation_bar.dart';
import 'package:speech_therapy/presentation/notepad.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/words_screen.dart';
import 'package:speech_therapy/provider/language_provider.dart';
import 'package:speech_therapy/routes/routes.dart';

late Size mq;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    // List<GraphDots> points = [GraphDots(x: 1, y: 2)];
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LanguageProvider()),
          ],
          child: MaterialApp(
            title: 'Speech Therapy',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  FruitScreen(),
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      },
      // child:
    );
  }
}
