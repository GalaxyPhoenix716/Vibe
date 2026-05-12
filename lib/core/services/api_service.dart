import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {

  static Future<Map<String, dynamic>> login(
      String token) async {

    final response = await http.post(
      Uri.parse(
        '${dotenv.env['BACKEND_URL']}/auth/login',
      ),
      headers: {
        "Authorization": "Bearer $token"
      },
    );

    return jsonDecode(response.body);
  }
}