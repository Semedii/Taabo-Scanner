class Parcel {
  String refNumber;
  String? recipientName;
  double kg;
  String? store;

  Parcel({
    required this.refNumber,
    this.recipientName,
    required this.kg,
    this.store,
  });
}
