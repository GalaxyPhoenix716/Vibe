import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vibe/core/constants.dart';

class ApiService {
  static Future<Map<String, dynamic>> login(String token) async {
    final response = await http.post(
      Uri.parse('${ServerConstant.serverURL}/auth/login'),
      headers: {"Authorization": "Bearer $token"},
    );

    return jsonDecode(response.body);
  }
}
