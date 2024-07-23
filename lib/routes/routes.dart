

import 'package:flutter/material.dart';
import 'package:speech_therapy/presentation/get_started.dart';
import 'package:speech_therapy/presentation/homepage.dart';
import 'package:speech_therapy/presentation/sentence.dart';
import 'package:speech_therapy/presentation/words_screen.dart';
import 'package:speech_therapy/routes/routes_name.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.getStarted:
        return _buildRoute(const GetStarted(), settings);
        
      case RoutesName.homePage:
        return _buildRoute( HomePage(), settings);
        
      case RoutesName.wordScreen:
        return _buildRoute( WordsScreen(), settings);
      
      case RoutesName.sentenceScreen:
        return _buildRoute( SentenceScreen(), settings);
      default:
        return _buildRoute(
            const Scaffold(
              body: Center(
                child: Text("NO Route Found"),
              ),
            ),
            settings);
    }
  }

  static _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
