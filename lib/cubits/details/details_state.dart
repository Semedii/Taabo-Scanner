part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {
  final double? weight;
  final String? name;
  final String? store;

  DetailsInitial({this.weight, this.name, this.store});

  DetailsInitial copyWith({
    double? weight,
    String? name,
    String? store,
    String? destination,
  }) {
    return DetailsInitial(
      weight: weight ?? this.weight,
      name: name ?? this.name,
      store: store ?? this.store,
    );
  }
}
