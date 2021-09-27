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
    on<AuthProviderInitialized>(_onAuthProviderInitialized);
    on<UserChanged>(_onUserChanged);
    on<UserDataRecieved>(_onUserDataReceived);
    on<UserDataLoadingFailed>(_onUserDataLoadingFailed);
    on<UserDataEdited>(_onUserDataEdited);
    on<SignOutRequested>((_, __) => authService.signOut());
    on<SignInWithGoogleRequested>(
      (_, emit) => _onSignIn(authService.signInWithGoogle, emit),
    );
    on<SignInWithAppleRequested>(
      (_, emit) => _onSignIn(authService.signInWithApple, emit),
    );
  }

  void _onAuthProviderInitialized(
    AuthProviderInitialized event,
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
        .listen((user) => add(UserDataRecieved(user)))
      ..onError((err) => add(UserDataLoadingFailed(err.toString())));
  }

  void _onUserDataReceived(UserDataRecieved event, Emitter<AuthState> emit) =>
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
          id: uid,
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

  void _onUserDataLoadingFailed(
    UserDataLoadingFailed event,
    Emitter<AuthState> emit,
  ) {
    emit(UserDataLoadError(event.errorMessage));
  }

  Future<void> _onUserDataEdited(
    UserDataEdited event,
    Emitter<AuthState> emit,
  ) async {
    await userRepository.save(event.user);
  }
}
