import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  onFullNameChanged(String? fullName) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(fullName: fullName));
  }

  onPhoneNumberChanged(String? phoneNumber) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(phoneNumber: phoneNumber));
  }

  onStatusChanged(String? status) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(status: status));
  }

  onDestinationChanged(String? destination) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(destination: destination));
  }

  onSubmitButton(String trackingNumber) {
    var lastState = state as DetailsInitial;
    print(
        "tracking number: $trackingNumber,  \n full name: ${lastState.fullName},  \n phone number: ${lastState.phoneNumber}, \n status: ${lastState.status}, \n destination : ${lastState.destination},");
  }
}
