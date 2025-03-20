import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final FocusNode focusNode = FocusNode();
  DetailsCubit() : super(DetailsInitial());

  onKgChanged(String? kg) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(kg: kg));
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
        "tracking number: $trackingNumber,  \n kg : ${lastState.kg},  \n name : ${lastState.name}, \n store: ${lastState.store},");
  }

  @override
  Future<void> close() {
    focusNode.dispose();
    return super.close();
  }
}
