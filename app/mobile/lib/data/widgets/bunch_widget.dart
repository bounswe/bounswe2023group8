import 'package:flutter/material.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/interest_area.dart';

class BunchWidget extends StatelessWidget {
  final InterestArea ia;
  final void Function()? onTap;
  const BunchWidget({super.key, required this.ia, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: BackgroundPalette.regular,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              ia.name,
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.25,
              ),
            ),
            const SizedBox(width: 8),
            Image.asset(
              ia.accessLevel == 'PUBLIC' ? Assets.public : Assets.private,
              width: 16,
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
