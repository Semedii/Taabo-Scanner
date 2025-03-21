import 'package:flutter/material.dart';
import 'package:taabo/pages/home_page.dart';
import 'package:taabo/pages/login_page.dart';
import 'package:taabo/services/secure_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureStorage = SecureStorageService();
  final token = await secureStorage.read('auth_token');

  runApp(
    MaterialApp(
      home: token != null ? HomePage() : LoginPage(),
    ),
  );
}
