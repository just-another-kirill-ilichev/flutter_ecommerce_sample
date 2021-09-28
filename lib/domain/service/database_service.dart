import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/domain/repository/document_serializer.dart';
import 'package:flutter_ecommerce_sample/domain/repository/firebase_repository.dart';
import 'package:flutter_ecommerce_sample/domain/repository/repository_base.dart';

abstract class DatabaseServiceBase {
  RepositoryBase<User, String> get userRepository;
  RepositoryBase<Order, String> get orderRepository;
  RepositoryBase<Product, String> get productRepository;
}

class FirebaseDatabaseService implements DatabaseServiceBase {
  @override
  final userRepository = FirebaseRepository<User>(
      '/users', DocumentSerializer((id, data) => User.fromMap(id, data)));
  @override
  final orderRepository = FirebaseRepository<Order>(
      '/orders', DocumentSerializer((id, data) => Order.fromMap(id, data)));
  @override
  final productRepository = FirebaseRepository<Product>(
      '/products', DocumentSerializer((id, data) => Product.fromMap(id, data)));
}
