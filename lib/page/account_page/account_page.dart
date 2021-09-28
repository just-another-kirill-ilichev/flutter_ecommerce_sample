import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_sample/page/account_page/layout/authenticated_layout.dart';
import 'package:flutter_ecommerce_sample/page/account_page/layout/unauthenticated_layout.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(listener: (ctx, state) {
      if (state is UserDataLoadError) {
        BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
      }

      if (state is SignInError || state is UserDataLoadError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка входа')),
        );
      }
    }, builder: (_, state) {
      if (state is Unauthenticated ||
          state is SignInError ||
          state is UserDataLoadError) {
        return const UnauthenticatedLayout();
      }
      if (state is Authenticated) {
        return AuthenticatedLayout(user: state.user);
      }
      return const Center(child: CircularProgressIndicator.adaptive());
    });
  }
}
