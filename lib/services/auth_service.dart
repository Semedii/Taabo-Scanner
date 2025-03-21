import 'dart:convert';

import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://reqres.in";

  login(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['error'] ?? 'Failed to login');
    }
  }
}
