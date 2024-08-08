import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String _baseUrl = 'http://192.168.100.44:5000';

  Future<Map<String, dynamic>> translateText(String text) async {
    final url = Uri.parse('$_baseUrl/translate');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'text': text}),
      );

      if (response.statusCode == 200) {
        final String audioUrl =
            response.headers['content-disposition']!.split('filename=')[1];
        return {'success': true, 'audioUrl': audioUrl};
      } else {
        return {'success': false, 'message': 'Translation Failed'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
