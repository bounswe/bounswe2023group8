import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/interest_area.dart';

class BunchWidget extends StatelessWidget {
  final InterestArea ia;
  final void Function()? onTap;
  const BunchWidget({
    super.key,
    required this.ia,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: BackgroundPalette.regular,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Get.width - 88,
              ),
              child: Text(
                ia.name,
                style: TextStyle(
                  color: ThemePalette.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.31,
                ),
                overflow: TextOverflow.ellipsis,
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
