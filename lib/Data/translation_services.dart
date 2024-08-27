// // lib/services/translation_service.dart
// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:speech_therapy/provider/api_url_provider.dart';
// import 'package:speech_therapy/provider/language_provider.dart';

// class TranslationService {
//   Future<String?> translateText(String text, context) async {
    
//   final ApiUrlProvider urlProvider =
//       Provider.of<ApiUrlProvider>(context, listen: false);
//     final url = Uri.parse(urlProvider.apiUrl);

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'text': text}),
//       );

//       if (response.statusCode == 200) {
//         final String filePath = await _getFilePath('translated_speech.mp3');
//         final file = File(filePath);
//         await file.writeAsBytes(response.bodyBytes);
//         return filePath;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       throw Exception('Failed to translate text: $e');
//     }
//   }

//   Future<String> _getFilePath(String fileName) async {
//     final directory = await getApplicationDocumentsDirectory();
//     return '${directory.path}/$fileName';
//   }
// }

// lib/data/repositories/translation_repository_impl.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:speech_therapy/domain/translation_repo.dart';
import 'package:speech_therapy/provider/api_url_provider.dart';

class TranslationRepositoryImpl implements TranslationRepository {
  // final BuildContext context;

  TranslationRepositoryImpl();

  @override
  Future<String?> translateText(String text,context) async {
    final ApiUrlProvider urlProvider = Provider.of<ApiUrlProvider>(context, listen: false);
    final url = Uri.parse(urlProvider.apiUrl);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final String filePath = await _getFilePath('translated_speech.mp3');
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to translate text: $e');
    }
  }

  Future<String> _getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$fileName';
  }
}
