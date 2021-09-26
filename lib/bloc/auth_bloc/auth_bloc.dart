import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_event.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/domain/repository/firebase_repository.dart';
import 'package:flutter_ecommerce_sample/domain/service/auth_service.dart';

typedef SignInAction = Future<auth.UserCredential> Function();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final FirebaseRepository<User> userRepository;

  StreamSubscription? _userSubscription;

  AuthBloc(this.authService, this.userRepository) : super(AuthUninitialized()) {
    on<AuthServiceInitialized>(_onAuthServiceInitialized);
    on<UserChanged>(_onUserChanged);
    on<UserDataChanged>(_onUserDataChanged);
    on<SignOutRequested>((_, __) => authService.signOut());
    on<SignInWithGoogleRequested>(
      (_, emit) => _onSignIn(authService.signInWithGoogle, emit),
    );
    on<SignInWithAppleRequested>(
      (_, emit) => _onSignIn(authService.signInWithApple, emit),
    );
  }

  void _onAuthServiceInitialized(
    AuthServiceInitialized event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitialized());
    authService.authStateChanges.listen((user) => add(UserChanged(user?.uid)));
  }

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    _userSubscription?.cancel();

    if (event.uid == null) {
      emit(Unauthenticated());
      return;
    }

    emit(UserDataLoadInProgress());
    _userSubscription = userRepository
        .getStreamById(event.uid!)
        .listen((user) => add(UserDataChanged(user)))
      ..onError((err) => emit(UserDataLoadError(err.toString())));
  }

  void _onUserDataChanged(UserDataChanged event, Emitter<AuthState> emit) =>
      emit(Authenticated(event.user));

  Future<void> _onSignIn(
    SignInAction signInAction,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(SignInInProgress());
      var credential = await signInAction();

      // TODO: Use Cloud Functions
      if (credential.additionalUserInfo?.isNewUser ?? false) {
        var uid = credential.user?.uid ?? ''; // TODO
        var user = User(
          uid,
          name: credential.user?.displayName ?? uid,
          email: credential.user?.email ?? '',
          photoUrl: credential.user?.photoURL,
          orders: [],
        );

        await userRepository.save(user);
      }
    } catch (e) {
      emit(SignInError(e.toString()));
    }
  }
}
