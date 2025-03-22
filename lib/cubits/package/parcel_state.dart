part of 'parcel_cubit.dart';

@immutable
sealed class ParcelState {}

final class ParcelInitial extends ParcelState {}

final class ParcelLoaded extends ParcelState {
  final List<Parcel> parcels;
  final Map<Parcel, bool> selectedParcels;

  ParcelLoaded({required this.parcels, required this.selectedParcels});
}
