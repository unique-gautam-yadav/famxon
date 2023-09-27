import 'dart:convert';

class ProductModel {
  final int id;
  String title;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String category;
  String thumbnail;
  List<String> images;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      title: map['title'] as String,
      price: double.parse("${map['price']}"),
      discountPercentage: double.parse("${map['discountPercentage']}"),
      rating: double.parse("${map['rating']}"),
      stock: map['stock'] as int,
      brand: map['brand'] as String,
      category: map['category'] as String,
      thumbnail: map['thumbnail'] as String,
      images: List<String>.from((map['images'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
