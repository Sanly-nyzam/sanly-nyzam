import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.31.200:5000';

  /// JSON veya duz metin yaniti guvenli sekilde parse eder
  static dynamic _parseBody(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body.trim();
    }
  }

  /// Kullanici kaydini gerceklestirir
  static Future<Map<String, dynamic>> register({
    required String fullName,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/Users/register');
      debugPrint('[ApiService] REGISTER → POST $url');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'fullName': fullName, 'password': password}),
      );

      debugPrint('[ApiService] REGISTER ← statusCode: ${response.statusCode}');
      debugPrint('[ApiService] REGISTER ← body: ${response.body}');

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,
        'statusCode': response.statusCode,
        'data': _parseBody(response.body),
      };
    } catch (e, stack) {
      debugPrint('[ApiService] REGISTER ✗ Exception: $e');
      debugPrint('[ApiService] REGISTER ✗ StackTrace:\n$stack');
      return {
        'success': false,
        'statusCode': 0,
        'data': 'Baglanyşyk ýalňyşlygy ýüze çykdy.',
      };
    }
  }

  /// Kullanici girisi gerceklestirir
  static Future<Map<String, dynamic>> login({
    required String fullName,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/Users/login');
      debugPrint('[ApiService] LOGIN → POST $url');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'fullName': fullName, 'password': password}),
      );

      debugPrint('[ApiService] LOGIN ← statusCode: ${response.statusCode}');
      debugPrint('[ApiService] LOGIN ← body: ${response.body}');

      return {
        'success': response.statusCode == 200 || response.statusCode == 201,
        'statusCode': response.statusCode,
        'data': _parseBody(response.body),
      };
    } catch (e, stack) {
      debugPrint('[ApiService] LOGIN ✗ Exception: $e');
      debugPrint('[ApiService] LOGIN ✗ StackTrace:\n$stack');
      return {
        'success': false,
        'statusCode': 0,
        'data': 'Baglanyşyk ýalňyşlygy ýüze çykdy.',
      };
    }
  }
}
