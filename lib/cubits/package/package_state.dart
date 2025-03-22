part of 'package_cubit.dart';

@immutable
sealed class PackageState {}

final class PackageInitial extends PackageState {}

final class PackageLoaded extends PackageState {
  final List<Package> packages;
  final Map<Package, bool> selectedPackages;

  PackageLoaded({required this.packages, required this.selectedPackages});
}
