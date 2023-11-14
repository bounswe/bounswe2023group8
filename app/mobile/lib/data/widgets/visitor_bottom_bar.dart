import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/assets.dart';
import '../constants/palette.dart';
import 'custom_button.dart';

class VisitorBottomBar extends StatelessWidget {
  final Function() onLoginPressed;
  final Function() onSignUpPressed;
  const VisitorBottomBar({
    super.key,
    required this.onLoginPressed,
    required this.onSignUpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: Palette.lightColor,
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(Assets.explore),
          Row(
            children: [
              CustomButton(
                width: 100,
                text: 'Login',
                textColor: Colors.white,
                fontSize: 16,
                onPressed: onLoginPressed,
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                width: 100,
                text: 'Sign Up',
                secondaryColor: true,
                fontSize: 16,
                onPressed: onSignUpPressed,
              ),
            ],
          ),
          SvgPicture.asset(Assets.settings)
        ],
      ),
    );
  }
}
