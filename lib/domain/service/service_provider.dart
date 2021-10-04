import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_ecommerce_sample/domain/service/auth_service.dart';
import 'package:flutter_ecommerce_sample/domain/service/database_service.dart';
import 'package:flutter_ecommerce_sample/domain/service/intl_service.dart';
import 'package:intl/date_symbol_data_local.dart';

class ServiceProvider {
  final Completer<AuthService> _authCompleter = Completer();
  final Completer<DatabaseServiceBase> _databaseCompleter = Completer();
  final Completer<IntlService> _intlCompleter = Completer();

  Future<AuthService> get authService => _authCompleter.future;
  Future<DatabaseServiceBase> get databaseService => _databaseCompleter.future;
  Future<IntlService> get intlService => _intlCompleter.future;

  Future<void> initialize() async {
    try {
      await Firebase.initializeApp();
      initializeDateFormatting();

      _authCompleter.complete(AuthService());
      _databaseCompleter.complete(FirebaseDatabaseService());
      _intlCompleter.complete(IntlService());
    } catch (e, stacktrace) {
      _authCompleter.completeError(e, stacktrace);
      _databaseCompleter.completeError(e, stacktrace);
      _intlCompleter.completeError(e, stacktrace);
    }
  }
}
