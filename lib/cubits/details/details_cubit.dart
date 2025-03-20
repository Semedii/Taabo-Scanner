import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  onWeightChanged(String? weight) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(weight: weight));
  }

  onNameChanged(String? name) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(name: name));
  }

  onStoreChanged(String? store) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(store: store));
  }

  onSubmitButton(String trackingNumber) {
    var lastState = state as DetailsInitial;
    print(
        "tracking number: $trackingNumber,  \n Weight : ${lastState.weight},  \n name : ${lastState.name}, \n store: ${lastState.store},");
  }
}
