import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taabo/model/package.dart';
import 'package:taabo/services/parcel_service.dart';

part 'parcel_state.dart';

class ParcelCubit extends Cubit<ParcelState> {
  ParcelCubit() : super(ParcelInitial());

  Future<void> loadParcels() async {
    emit(ParcelLoading());
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

  void onFlightNumberChanged(String? flightNumber) {
    var lastState = state as ParcelLoaded;
    emit(lastState.copyWith(flightNumber: flightNumber));
  }

  void onShipConfirm() async {
    var currentState = state as ParcelLoaded;
    List<int> selectedIds = [];
    var selectedParcelsToShip = currentState.selectedParcels.entries
        .where((entry) => entry.value == true)
        .map((entry) => entry.key)
        .toList();

    for (var parcel in selectedParcelsToShip) {
      selectedIds.add(parcel.id!);
    }
    await ParcelService().updateParcels(
      ids: selectedIds,
      status: "Shipped",
      location: "onAir",
      flightNumber: currentState.flightNumber!,
    );
    loadParcels();
  }

  int getTotalSelectedParcels() {
    final state = this.state;
    if (state is ParcelLoaded) {
      return state.selectedParcels.entries
          .where((entry) => entry.value == true)
          .length;
    }
    return 0;
  }

  int getTotalSelectedCartoons() {
    final state = this.state;
    if (state is ParcelLoaded) {
      return state.selectedParcels.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key.cartoons)
          .fold(0, (sum, cartoons) => sum + cartoons);
    }
    return 0;
  }

  double getTotalSelectedWeight() {
    final state = this.state;
    if (state is ParcelLoaded) {
      return state.selectedParcels.entries
          .where((entry) => entry.value == true)
          .map((entry) => entry.key.kg)
          .fold(0.0, (sum, kg) => sum + kg);
    }
    return 0.0;
  }
}
