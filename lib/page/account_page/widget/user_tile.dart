import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/domain/model/user.dart';
import 'package:flutter_ecommerce_sample/page/account_page/widget/user_avatar.dart';

class UserTile extends StatelessWidget {
  final User user;
  final VoidCallback onSignOutPressed;

  const UserTile({
    Key? key,
    required this.user,
    required this.onSignOutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: [
        UserAvatar(
          photoUrl: user.photoUrl,
          name: user.name,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user.name,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                user.email,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSignOutPressed,
          icon: const Icon(Icons.logout_outlined),
        ),
      ]),
    );
  }
}
