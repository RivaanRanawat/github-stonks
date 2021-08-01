import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        required this.stockPrice,
        required this.stars,
        required this.id,
        required this.name,
        required this.image,
    });

    int stockPrice;
    int stars;
    String id;
    String name;
    String image;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        stockPrice: json["stockPrice"],
        stars: json["stars"],
        id: json["_id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "stockPrice": stockPrice,
        "stars": stars,
        "_id": id,
        "name": name,
        "image": image,
    };
}