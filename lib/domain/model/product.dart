import 'dart:convert';

import 'package:decimal/decimal.dart';

class Product {
  final int? id;
  final String title;
  final String description;
  final Decimal price;

  Product({
    this.id,
    required this.title,
    required this.description,
    required this.price,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    Decimal? price,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price.toString(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      price: Decimal.parse(map['price']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ description.hashCode ^ price.hashCode;
  }
}
