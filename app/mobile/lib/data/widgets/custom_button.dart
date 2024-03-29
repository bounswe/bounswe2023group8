import 'package:flutter/material.dart';
import 'package:mobile/data/constants/palette.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool active;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double disabledOpacity;
  final bool inProgress;
  final bool shadow;
  final bool secondaryColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomButton(
      {this.onPressed,
      required this.text,
      this.width,
      this.height,
      this.active = true,
      this.backgroundColor,
      this.textColor,
      this.disabledOpacity = 0.25,
      this.fontSize,
      this.fontWeight,
      this.secondaryColor = false,
      this.inProgress = false,
      this.shadow = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: shadow
          ? active
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(4, 4),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                )
              : null
          : null,
      child: ElevatedButton(
        onPressed: !active || inProgress ? () {} : onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          disabledBackgroundColor: secondaryColor
              ? BackgroundPalette.regular
              : backgroundColor ??
                  ThemePalette.main.withOpacity(active ? 1 : disabledOpacity),
          disabledForegroundColor:
              secondaryColor ? ThemePalette.main : textColor,
          backgroundColor: secondaryColor
              ? BackgroundPalette.regular
              : backgroundColor ??
                  ThemePalette.main.withOpacity(active ? 1 : disabledOpacity),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
        ),
        child: inProgress
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              )
            : Text(
                text,
                style: TextStyle(
                  color: secondaryColor
                      ? ThemePalette.main
                      : textColor ?? ThemePalette.light,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  fontSize: fontSize ?? 20,
                  letterSpacing: -0.25,
                ),
              ),
      ),
    );
  }
}
