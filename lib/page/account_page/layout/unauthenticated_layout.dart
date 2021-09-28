import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart';

class UnauthenticatedLayout extends StatelessWidget {
  const UnauthenticatedLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Войти в аккаунт',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(height: 24),
            // TODO: style buttons
            ElevatedButton(
              onPressed: () => _signInWithApple(context),
              child: const Text('Войти с помощью Apple ID'),
            ),
            ElevatedButton(
              onPressed: () => _signInWithGoogle(context),
              child: const Text('Войти с помощью Google'),
            )
          ],
        ),
      ),
    );
  }

  void _signInWithApple(BuildContext context) =>
      _emitEvent(context, SignInWithAppleRequested());

  void _signInWithGoogle(BuildContext context) =>
      _emitEvent(context, SignInWithGoogleRequested());

  void _emitEvent(BuildContext context, AuthEvent event) {
    var bloc = BlocProvider.of<AuthBloc>(context, listen: false);

    bloc.add(event);
  }
}
