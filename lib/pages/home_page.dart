import 'package:flutter/material.dart';
import 'package:taabo/components/app_button.dart';
import 'package:taabo/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Light background color
      appBar: AppBar(
        title: const Text(
          'TAABO SCANNER',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2563EB), // Primary color
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 200,
            ),
            const SizedBox(height: 40),
            AppButton(
                text: "Scan Package",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScannerPage()),
                  );
                })
          ],
        ),
      ),
    );
  }
}
