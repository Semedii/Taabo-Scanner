import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

part 'scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(ScannerInitial());

  void scanQR(QRViewController controller) async {
    controller.scannedDataStream.listen((scanData) {
      emit(ScannerInitial(trackingNumber: scanData.code));
      controller.stopCamera();
    });
  }
}
