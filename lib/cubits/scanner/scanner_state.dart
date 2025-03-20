part of 'scanner_cubit.dart';

@immutable
sealed class ScannerState {}

final class ScannerInitial extends ScannerState {
  final String? trackingNumber;

  ScannerInitial({this.trackingNumber});

  ScannerInitial copyWith({String? trackingNumber}) {
    return ScannerInitial(
      trackingNumber: trackingNumber ?? this.trackingNumber,
    );
  }
}
