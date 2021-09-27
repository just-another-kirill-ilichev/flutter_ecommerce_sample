import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

class User extends Entity<String> {
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> orders;

  User({
    String? id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.orders,
  }) : super(id);

  factory User.fromMap(String id, Map<String, dynamic> map) {
    return User(
      id: id,
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      orders: map['orders'].cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'orders': orders,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    List<String>? orders,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      orders: orders ?? this.orders,
    );
  }
}
