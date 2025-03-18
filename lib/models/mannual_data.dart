class ManualData {
  String? name;
  String? quantity;
  String? code;
  int? price;

  ManualData({this.name, this.quantity, this.code, this.price});

  ManualData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    code = json['code'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['code'] = this.code;
    data['price'] = this.price;
    return data;
  }
}
