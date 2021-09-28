import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ecommerce_sample/domain/service/auth_service.dart';
import 'package:flutter_ecommerce_sample/domain/service/database_service.dart';

class ServiceProvider {
  final Completer<AuthService> _authCompleter = Completer();
  final Completer<DatabaseServiceBase> _databaseCompleter = Completer();

  Future<AuthService> get authService => _authCompleter.future;
  Future<DatabaseServiceBase> get databaseService => _databaseCompleter.future;

  Future<void> initialize() async {
    await Firebase.initializeApp();

    _authCompleter.complete(AuthService());
    _databaseCompleter.complete(FirebaseDatabaseService());
  }
}
