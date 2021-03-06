part of 'auth_bloc.dart';

abstract class AuthState {}

/// Initial state. AuthService has not been initialized yet
/// or auth state stream doesn't provide any data for now
class Initial extends AuthState {}

/// Awaiting user data from Firestore after auth state stream
/// returned non-null user
class UserDataLoadInProgress extends AuthState {}

/// An error occured while loading data from Firestore
class UserDataLoadError extends AuthState {
  final String errorDescription;

  UserDataLoadError(this.errorDescription);
}

/// Auth state stream returned non-null user and user data
/// was successfully loaded
class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);
}

// Auth state returned null user
class Unauthenticated extends AuthState {}

/// User requested sign in, but auth state stream has not been updated yet
class SignInInProgress extends AuthState {}

/// An error occured while trying to sign in
class SignInError extends AuthState {
  final String errorDescription;

  SignInError(this.errorDescription);
}
