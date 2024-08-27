import 'package:flutter/foundation.dart';

class ApiUrlProvider with ChangeNotifier {
  String _apiUrl = '';

  String get apiUrl => _apiUrl;

  void setApiUrl(String url) {
    _apiUrl = url;
    notifyListeners(); // Notifies listeners about the change
  }
}
