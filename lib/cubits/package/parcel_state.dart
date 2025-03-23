part of 'parcel_cubit.dart';

@immutable
sealed class ParcelState {}

final class ParcelInitial extends ParcelState {}

final class ParcelLoaded extends ParcelState {
  final List<Parcel> parcels;
  final Map<Parcel, bool> selectedParcels;
  final String? flightNumber;
  final bool isSelectAll;

  ParcelLoaded({
    required this.parcels,
    required this.selectedParcels,
    this.flightNumber,
    this.isSelectAll = false,
  });

  ParcelLoaded copyWith({String? flightNumber, bool? isSelectAll}) {
    return ParcelLoaded(
      parcels: parcels,
      selectedParcels: selectedParcels,
      flightNumber: flightNumber ?? this.flightNumber,
      isSelectAll: isSelectAll ?? this.isSelectAll,
    );
  }
}

final class ParcelLoading extends ParcelState {}
