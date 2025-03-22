import 'package:flutter/material.dart';
import 'package:taabo/components/package_card.dart';
import 'package:taabo/model/package.dart';
import 'package:taabo/pages/scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Package> availablePackages = [
      Package(
        trackingNumber: "1232123212321232123",
        name: "Abdisamad Ibrahim",
        weight: 12,
        store: "Shein",
      ),
      Package(
        trackingNumber: "1232123212321232123",
        name: "Abdisamad Ibrahim",
        weight: 12,
      ),
      Package(
        trackingNumber: "1232123212321232123",
        weight: 12,
        store: "AMAZON",
      ),
      Package(
        trackingNumber: "1232123212321232123",
        weight: 10,
      ),
      Package(
        trackingNumber: "1232123212321232123",
        name: "Abdisamad Yusuf",
        weight: 12,
        store: "ALIBABA",
      ),
    ];
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
        backgroundColor: const Color(0xFF1e78c1), // Primary color
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...availablePackages.map(
              (package) => PackageCard(package: package),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScannerPage()),
          );
        },
        backgroundColor: const Color(0xFF1e78c1),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
