import 'package:flutter/material.dart';
import 'package:mobile/data/constants/palette.dart';

class SelectCircle extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onTap;
  const SelectCircle({super.key, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (value) {
      return InkWell(
        onTap: () {
          if (onTap != null) onTap!(!value);
        },
        child: CircleAvatar(
          radius: 8,
          backgroundColor: Palette.primaryColor,
          child: const CircleAvatar(
            radius: 4,
            backgroundColor: Colors.white,
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          if (onTap != null) onTap!(!value);
        },
        child: Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            border: Border.all(
              color: Palette.primaryColor,
              width: 1,
            ),
          ),
        ),
      );
    }
  }
}
