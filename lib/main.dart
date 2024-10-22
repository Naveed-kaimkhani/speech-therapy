import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/Data/translation_repository_impl.dart';
import 'package:speech_therapy/domain/translation_repo.dart';
import 'package:speech_therapy/presentation/fruits.dart';
import 'package:speech_therapy/presentation/Login/login_screen.dart';
import 'package:speech_therapy/presentation/Progress.dart';
import 'package:speech_therapy/presentation/Signup/signup_screen.dart';
import 'package:speech_therapy/presentation/api_url_screen.dart';
import 'package:speech_therapy/presentation/get_started.dart';
import 'package:speech_therapy/presentation/homepage.dart';
import 'package:speech_therapy/presentation/hospital_screen.dart';
import 'package:speech_therapy/presentation/navigation_bar.dart';
import 'package:speech_therapy/presentation/notepad.dart';
import 'package:speech_therapy/presentation/progress_track.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/sindhi_translation.dart';
import 'package:speech_therapy/presentation/urdu_translation.dart';
import 'package:speech_therapy/presentation/word_pronun_check.dart';
import 'package:speech_therapy/presentation/words_screen.dart';
import 'package:speech_therapy/provider/api_url_provider.dart';
import 'package:speech_therapy/provider/language_provider.dart';
import 'package:speech_therapy/routes/routes.dart';
import 'presentation/word_speak.dart';

late Size mq;
// GetIt is a package used for service locator or to manage dependency injection
GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  servicesLocator(); // Initializing service locator for dependency injection

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
            
            ChangeNotifierProvider(create: (_) => ApiUrlProvider()),
    

          ],
          child: MaterialApp(
            title: 'Speach Buddy',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:GetStarted(),
            // home: AudioPlayerExample(),
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      },
      // child:
    );
  }
}
void servicesLocator() {
  getIt.registerLazySingleton<TranslationRepository>(() =>
      TranslationRepositoryImpl()); // Registering as a lazy singleton for dependency injection

}