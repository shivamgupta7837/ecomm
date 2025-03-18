class Items {
    Items({
        required this.items,
    });

    final List<Item> items;

    factory Items.fromJson(Map<String, dynamic> json){ 
        return Items(
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "items": items.map((x) => x?.toJson()).toList(),
    };

}

class Item {
    Item({
        required this.description,
        required this.image,
        required this.itemName,
        required this.price,
        required this.quantity,
    });

    final String? description;
    final String? image;
    final String? itemName;
    final num? price;
    final num? quantity;

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            description: json["description"],
            image: json["image"],
            itemName: json["itemName"],
            price: json["price"],
            quantity: json["quantity"],
        );
    }

    Map<String, dynamic> toJson() => {
        "description": description,
        "image": image,
        "itemName": itemName,
        "price": price,
        "quantity": quantity,
    };

}
