import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/auth_bloc/auth_event.dart';
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
              children: const [
                ListTile(
                  leading: Icon(Icons.history_outlined),
                  title: Text('История заказов'),
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
