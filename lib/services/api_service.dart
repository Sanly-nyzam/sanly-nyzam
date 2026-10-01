import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.31.200:5000';

  /// JSON veya duz metin response'u guvenli sekilde parse eder
  static dynamic _parseBody(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      // Backend duz metin dondurdugunda (ornegin admin mesaji)
      return body.trim();
    }
  }

  /// Kullanici kaydini gerceklestirir
  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/Users/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'fullName': fullName, 'password': password}),
    );
    return {
      'statusCode': response.statusCode,
      'data': _parseBody(response.body),
    };
  }

  /// Kullanici girisi gerceklestirir
  static Future<Map<String, dynamic>> login({
    required String fullName,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/Users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'fullName': fullName, 'password': password}),
    );
    return {
      'statusCode': response.statusCode,
      'data': _parseBody(response.body),
    };
  }
}
