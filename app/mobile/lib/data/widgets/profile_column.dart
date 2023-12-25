import 'package:flutter/material.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/models/enigma_user.dart';

class ProfileColumn extends StatelessWidget {
  final EnigmaUser user;
  final void Function()? onTap;
  const ProfileColumn({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 40,
                backgroundImage: AssetImage(Assets.profilePlaceholder))
        ),
        const SizedBox(height: 4),
        Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        Text(
          '@${user.username}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
