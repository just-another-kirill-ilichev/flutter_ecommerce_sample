import 'package:decimal/decimal.dart';
import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

class Product extends Entity<String> {
  final String title;
  final String description;
  final String? photoUrl;
  final Decimal price;

  Product({
    String? id,
    required this.title,
    required this.description,
    this.photoUrl,
    required this.price,
  }) : super(id);

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      title: map['title'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      price: Decimal.parse(map['price']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price.toString(),
      'photoUrl': photoUrl,
    };
  }
}
