import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String? photoUrl;
  final String? name;

  const UserAvatar({
    Key? key,
    this.photoUrl,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
      child: _buildName(),
    );
  }

  Widget _buildName() {
    if (name == null || photoUrl != null) {
      return const SizedBox();
    }

    var parts = name!.split(' ');
    var text = parts.first[0];

    if (parts.length > 1) {
      text += parts.last[0];
    }

    return Text(text);
  }
}
