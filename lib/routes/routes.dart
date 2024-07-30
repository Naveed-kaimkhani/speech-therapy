import 'package:flutter/material.dart';
import 'package:speech_therapy/presentation/get_started.dart';
import 'package:speech_therapy/presentation/words_screen.dart';
import 'package:speech_therapy/routes/routes_name.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.getStarted:
        return _buildRoute(const GetStarted(), settings);
      case RoutesName.wordScreen:
        return _buildRoute(WordsScreen(), settings);
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

  static Route<dynamic> _buildRoute(Widget widget, RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => widget, settings: settings);
  }
}
