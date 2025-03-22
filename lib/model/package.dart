class Package {
  String trackingNumber;
  String? name;
  double weight;
  String? store;

  Package({
    required this.trackingNumber,
    this.name,
    required this.weight,
    this.store,
  });
}
