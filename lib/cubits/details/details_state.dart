part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {
  final double? weight;
  final String? name;
  final String? store;
  final int? cartoons;

  DetailsInitial({this.cartoons, this.weight, this.name, this.store});

  DetailsInitial copyWith({
    double? weight,
    String? name,
    String? store,
    String? destination,
    int? cartoons,
  }) {
    return DetailsInitial(
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
