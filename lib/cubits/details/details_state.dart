part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {
  final String? fullName;
  final String? phoneNumber;
  final String? status;
  final String? destination;

  DetailsInitial({
    this.fullName,
    this.phoneNumber,
    this.status,
    this.destination,
  });

  DetailsInitial copyWith({
    String? fullName,
    String? phoneNumber,
    String? status,
    String? destination,
  }) {
    return DetailsInitial(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      destination: destination ?? this.destination,
    );
  }
}
