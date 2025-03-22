import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:taabo/model/package.dart';

part 'package_state.dart';

class PackageCubit extends Cubit<PackageState> {
  PackageCubit() : super(PackageInitial());

  void loadPackages(List<Package> packages) {
    final selectedPackages = Map<Package, bool>.fromIterable(
      packages,
      key: (package) => package,
      value: (package) => false,
    );
    emit(PackageLoaded(packages: packages, selectedPackages: selectedPackages));
  }

  void togglePackageSelection(Package package) {
    final state = this.state;
    if (state is PackageLoaded) {
      final updatedSelections = Map<Package, bool>.from(state.selectedPackages)
        ..update(package, (isSelected) => !isSelected);
      emit(PackageLoaded(
          packages: state.packages, selectedPackages: updatedSelections));
    }
  }
}
