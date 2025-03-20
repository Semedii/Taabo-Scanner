part of 'details_cubit.dart';

@immutable
sealed class DetailsState {}

final class DetailsInitial extends DetailsState {
  final String? kg;
  final String? name;
  final String? store;

  DetailsInitial({this.kg, this.name, this.store});

  DetailsInitial copyWith({
    String? kg,
    String? name,
    String? store,
    String? destination,
  }) {
    return DetailsInitial(
      kg: kg ?? this.kg,
      name: name ?? this.name,
      store: store ?? this.store,
    );
  }
}
