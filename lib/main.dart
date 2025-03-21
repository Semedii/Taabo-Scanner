import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taabo/authentication/auth_provider.dart';
import 'package:taabo/pages/login_page.dart';
import 'package:taabo/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.isAuthenticated) {
            return HomePage();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
