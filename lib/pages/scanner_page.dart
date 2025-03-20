import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taabo/cubits/scanner/scanner_cubit.dart';
import 'package:taabo/pages/details_page.dart';

class ScannerPage extends StatelessWidget {
  ScannerPage({super.key});

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Scan Package',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1e78c1), // Primary color
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocProvider(
        create: (context) => ScannerCubit(),
        child: BlocListener<ScannerCubit, ScannerState>(
          listener: (context, state) {
            if (state is ScannerInitial && state.trackingNumber != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsPage(
                    trackingNumber: state.trackingNumber!,
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<ScannerCubit, ScannerState>(
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated:
                          BlocProvider.of<ScannerCubit>(context).scanQR,
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF1e78c1), // Primary color
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Scanning, please hold...',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(
                                  255, 0, 0, 0), // Light gray text
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
