class Parcel {
  String refNumber;
  String? recipientName;
  double kg;
  String? store;
  int cartoons;

  Parcel({
    required this.refNumber,
    this.recipientName,
    required this.kg,
    required this.cartoons,
    this.store,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      refNumber: json['RefNumber'],
      recipientName: json['RecipientName'],
      kg: json['KG'].toDouble(),
      store: json['Store'],
      cartoons: json['cartoons'],
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
