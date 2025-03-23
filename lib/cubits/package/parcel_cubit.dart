import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taabo/model/package.dart';
import 'package:taabo/services/parcel_service.dart';

part 'parcel_state.dart';

class ParcelCubit extends Cubit<ParcelState> {
  ParcelCubit() : super(ParcelInitial());

  void loadParcels(List<Parcel> ss) async {
    List<Parcel> parcels = await ParcelService().getAllParcels();
    final selectedParcels = Map<Parcel, bool>.fromIterable(
      parcels,
      key: (parcel) => parcel,
      value: (parcel) => false,
    );
    emit(ParcelLoaded(parcels: parcels, selectedParcels: selectedParcels));
  }

  void togglePackageSelection(Parcel parcel) {
    final state = this.state;
    if (state is ParcelLoaded) {
      final updatedSelections = Map<Parcel, bool>.from(state.selectedParcels)
        ..update(parcel, (isSelected) => !isSelected);
      emit(ParcelLoaded(
          parcels: state.parcels, selectedParcels: updatedSelections));
    }
  }
}
