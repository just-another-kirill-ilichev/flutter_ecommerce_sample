import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/page/account_page/widget/user_tile.dart';

class AuthenticatedLayout extends StatelessWidget {
  final User user;

  const AuthenticatedLayout({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          UserTile(
            user: user,
            onSignOutPressed: () => _signOut(context),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.history_outlined),
                  title: const Text('История заказов'),
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRouter.orderHistory),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _signOut(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
}
