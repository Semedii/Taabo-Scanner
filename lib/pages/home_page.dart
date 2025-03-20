import 'package:flutter/material.dart';
import 'package:taabo/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Light background color
      appBar: AppBar(
        title: const Text(
          'TAJMEX SCANNER',
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
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScannerPage()),
          );
        },
        backgroundColor: const Color(0xFF2563EB),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
