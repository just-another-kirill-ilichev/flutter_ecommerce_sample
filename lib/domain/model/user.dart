import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecommerce_sample/domain/model/entity.dart';

class User extends Entity<String> {
  final String name;
  final String email;
  final String? photoUrl;
  final List<DocumentReference> orders;

  User(
    String? id, {
    required this.name,
    required this.email,
    this.photoUrl,
    required this.orders,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'orders': orders,
    };
  }

  factory User.fromMap(String id, Map<String, dynamic> map) {
    return User(
      id,
      name: map['name'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      orders: map['orders'].cast<DocumentReference>(),
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoUrl,
    List<DocumentReference>? orders,
  }) {
    return User(
      id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      orders: orders ?? this.orders,
    );
  }
}
