import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/domain/repository/repository_base.dart';
import 'package:flutter_ecommerce_sample/domain/service/auth_service.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

part 'auth_event.dart';
part 'auth_state.dart';

typedef SignInAction = Future<auth.UserCredential> Function();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ServiceProvider serviceProvider;
  late AuthService _authService;
  late RepositoryBase<User, String> _repository;

  StreamSubscription? _userSubscription;

  AuthBloc(this.serviceProvider) : super(Initial()) {
    on<AppStarted>(_onAuthProviderInitialized);
    on<UserChanged>(_onUserChanged);
    on<UserDataRecieved>(_onUserDataReceived);
    on<UserDataLoadingFailed>(_onUserDataLoadingFailed);
    on<UserDataEdited>(_onUserDataEdited);
    on<SignOutRequested>((_, __) => _authService.signOut());
    on<SignInWithGoogleRequested>(
      (_, emit) => _onSignIn(_authService.signInWithGoogle, emit),
    );
    on<SignInWithAppleRequested>(
      (_, emit) => _onSignIn(_authService.signInWithApple, emit),
    );
  }

  factory AuthBloc.started(ServiceProvider servicesProvider) {
    return AuthBloc(servicesProvider)..add(AppStarted());
  }

  Future<void> _onAuthProviderInitialized(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    _authService = await serviceProvider.authService;

    var databaseService = await serviceProvider.databaseService;
    _repository = databaseService.userRepository;

    _authService.authStateChanges.listen((user) => add(UserChanged(user?.uid)));
  }

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    _userSubscription?.cancel();

    if (event.uid == null) {
      emit(Unauthenticated());
      return;
    }

    emit(UserDataLoadInProgress());
    _userSubscription = _repository
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

        await _repository.save(user);
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
    await _repository.save(event.user);
  }
}
