part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {
  final String? trackingNumber;
  final double? weight;
  final String? name;
  final String? store;
  final int? cartoons;

  DetailsInitial({
    this.trackingNumber,
    this.cartoons,
    this.weight,
    this.name,
    this.store,
  });

  DetailsInitial copyWith({
    String? trackingNumber,
    double? weight,
    String? name,
    String? store,
    String? destination,
    int? cartoons,
  }) {
    return DetailsInitial(
      trackingNumber: trackingNumber ?? this.trackingNumber,
      weight: weight ?? this.weight,
      name: name ?? this.name,
      store: store ?? this.store,
      cartoons: cartoons ?? this.cartoons,
    );
  }
}

final class DetailsLoading extends DetailsState {}

final class DetailsSuccess extends DetailsState {}

final class DetailsFailure extends DetailsState {}
