class Parcel {
  int? id;
  String refNumber;
  String? recipientName;
  double kg;
  String? store;
  int cartoons;
  String? courierDate;

  Parcel({
    this.id,
    required this.refNumber,
    this.recipientName,
    required this.kg,
    required this.cartoons,
    this.store,
    this.courierDate,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json["ID"],
      refNumber: json['RefNumber'],
      recipientName: json['RecipientName'],
      kg: json['KG'].toDouble(),
      store: json['Store'],
      cartoons: json['cartoons'],
      courierDate: json['CourierDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'RefNumber': refNumber,
      'RecipientName': recipientName,
      'KG': kg.toString(),
      'Store': store,
      'qty': cartoons,
    };
  }
}
