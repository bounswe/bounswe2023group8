import 'package:flutter/material.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/enigma_user.dart';

class ProfileColumn extends StatelessWidget {
  final EnigmaUser user;
  final void Function()? onTap;
  const ProfileColumn({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(Assets.profilePlaceholder),
          ),
          const SizedBox(height: 4),
          Text(
            user.name,
            style: TextStyle(
              color: ThemePalette.light,
              fontSize: 10,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.15,
            ),
          ),
          Text(
            '@${user.username}',
            style: TextStyle(
              color: ThemePalette.light,
              fontSize: 8,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.15,
            ),
          ),
        ],
      ),
    );
  }
}
