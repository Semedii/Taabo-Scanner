part of 'parcel_cubit.dart';

@immutable
sealed class ParcelState {}

final class ParcelInitial extends ParcelState {}

final class ParcelLoaded extends ParcelState {
  final List<Parcel> parcels;
  final Map<Parcel, bool> selectedParcels;
  final String? flightNumber;

  ParcelLoaded(
      {required this.parcels,
      required this.selectedParcels,
      this.flightNumber});

  ParcelLoaded copyWith({String? flightNumber}) {
    return ParcelLoaded(
      parcels: parcels,
      selectedParcels: selectedParcels,
      flightNumber: flightNumber ?? this.flightNumber,
    );
  }
}

final class ParcelLoading extends ParcelState {}
