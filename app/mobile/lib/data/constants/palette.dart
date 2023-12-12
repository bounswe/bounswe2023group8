import 'package:flutter/material.dart';

class ThemePalette {
  static Color get main => const Color(0xff0B68B1);
  static Color get white => const Color(0xffFFFFFF);
  static Color get black => const Color(0xff000000);
  static Color get light => const Color(0xffF1F1F1);
  static Color get dark => const Color(0xff434343);
  static Color get positive => const Color(0xff31BC63);
  static Color get negative => const Color(0xffC32626);
}

class BackgroundPalette {
  static Color get light => const Color(0xffFFFAF6);
  static Color get soft => const Color(0xffEEF0EB);
  static Color get regular => const Color(0xffCDCFCF);
  static Color get solid => const Color(0xff7EA4B9);
  static Color get dark => const Color(0xff486376);
}

class SeparatorPalette {
  static Color get light => const Color(0xffE6EFF4);
  static Color get dark => const Color(0xff203376);
}

class GradientPalette {
  static LinearGradient get mainGradient => LinearGradient(
        colors: [ThemePalette.main, ThemePalette.main.withOpacity(0.7)],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
