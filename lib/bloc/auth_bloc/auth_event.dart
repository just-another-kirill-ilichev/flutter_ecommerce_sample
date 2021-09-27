import 'package:flutter_ecommerce_sample/domain/model/user.dart';

abstract class AuthEvent {}

/// Auth provider has been initialized and we're able to listen auth events now
class AuthProviderInitialized extends AuthEvent {}

/// Auth state stream has returned new user
class UserChanged extends AuthEvent {
  final String? uid;

  UserChanged(this.uid);
}

/// Current user's data has been received from Firestore
class UserDataRecieved extends AuthEvent {
  final User user;

  UserDataRecieved(this.user);
}

// An error occured while loading user data from Firestore
class UserDataLoadingFailed extends AuthEvent {
  final String errorMessage;

  UserDataLoadingFailed(this.errorMessage);
}

// Current user's data has been edited locally
// and needs to be uploaded to Firestore
class UserDataEdited extends AuthEvent {
  final User user;

  UserDataEdited(this.user);
}

/// User requested to sign in with Google
class SignInWithGoogleRequested extends AuthEvent {}

/// User requested to sign in with Apple
class SignInWithAppleRequested extends AuthEvent {}

/// User requested to sign out
class SignOutRequested extends AuthEvent {}
