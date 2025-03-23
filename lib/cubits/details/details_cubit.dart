import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taabo/model/package.dart';
import 'package:taabo/services/parcel_service.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  onNameChanged(String? name) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(name: name));
  }

  onWeightChanged(double? weight) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(weight: weight));
  }

  onCartoonsChanged(int? cartoons) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(cartoons: cartoons));
  }

  onStoreChanged(String? store) {
    var lastState = state as DetailsInitial;
    emit(lastState.copyWith(store: store));
  }

  onSubmitButton(String trackingNumber) async {
    var lastState = state as DetailsInitial;
    emit(DetailsLoading());
    try {
      Parcel newParcel = Parcel(
        refNumber: trackingNumber,
        recipientName: lastState.name,
        store: lastState.store,
        kg: lastState.weight!,
        cartoons: lastState.cartoons!,
      );
      await ParcelService().addNewParcel(newParcel);
      emit(DetailsSuccess());
    } catch (e, stackTrace) {
      print('Error while submitting parcel: $e');
      print('Stack trace: $stackTrace');
      emit(DetailsFailure());
      emit(lastState);
    }
  }
}
