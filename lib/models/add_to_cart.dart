class AddToCartModel {
  String? image;
  String? itemName;
  num? price;
  num? quantity;
  String? description;

  AddToCartModel({this.image, this.itemName, this.price, this.quantity,this.description});

  AddToCartModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    itemName = json['itemName'];
    price = json['price'];
    quantity = json['quantity'];
    description = json["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['itemName'] = this.itemName;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data["description"] = this.description;
    return data;
  }
}
