import 'package:decimal/decimal.dart';
import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

class Product extends Entity<String> {
  final String title;
  final String description;
  final Decimal price;

  Product(
    String? id, {
    required this.title,
    required this.description,
    required this.price,
  }) : super(id);

  Product copyWith({
    String? id,
    String? title,
    String? description,
    Decimal? price,
  }) {
    return Product(
      id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price.toString(),
    };
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id,
      title: map['title'],
      description: map['description'],
      price: Decimal.parse(map['price']),
    );
  }
}
