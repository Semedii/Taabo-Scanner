import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:taabo/services/secure_storage_service.dart';

class AuthService {
  final SecureStorageService _secureStorage = SecureStorageService();
  final String baseUrl = "https://tajmexapp.onrender.com";

  login(String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }));
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return responseData['token'] as String;
    } else {
      throw Exception(responseData['message'] ?? 'Login failed');
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete('auth_token');
  }
}
