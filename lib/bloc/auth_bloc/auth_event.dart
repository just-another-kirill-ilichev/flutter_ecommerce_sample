import 'package:flutter_ecommerce_sample/domain/model/user.dart';

abstract class AuthEvent {}

class AuthServiceInitialized extends AuthEvent {}

class UserChanged extends AuthEvent {
  final String? uid;

  UserChanged(this.uid);
}

class UserDataChanged extends AuthEvent {
  final User user;

  UserDataChanged(this.user);
}

class SignInWithGoogleRequested extends AuthEvent {}

class SignInWithAppleRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
