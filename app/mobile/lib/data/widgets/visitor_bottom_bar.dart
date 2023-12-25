import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/visitor_explore/bindings/visitor_explore_binding.dart';
import 'package:mobile/modules/visitor_explore/views/visitor_explore_view.dart';
import 'package:mobile/modules/visitor_settings/bindings/visitor_settings_binding.dart';
import 'package:mobile/modules/visitor_settings/views/visitor_settings_view.dart';
import 'package:mobile/routes/app_pages.dart';

import '../constants/assets.dart';
import '../constants/palette.dart';
import 'custom_button.dart';

class VisitorBottomBarState extends State<VisitorBottomBar> {
  var currentIndex = 0;

  final pages = <String>[
    Routes.visitorExplore,
    Routes.visitorSettings,
  ];

  void changePage(int index) {
    if (currentIndex == index) {
      return;
    }
    currentIndex = index;
    Get.offAllNamed(
      pages[index],
      id: 2,
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.visitorExplore) {
      return GetPageRoute(
        settings: settings,
        page: () => const VisitorExploreView(),
        binding: VisitorExploreBinding(),
        transition: Transition.noTransition,
      );
    }

    if (settings.name == Routes.visitorSettings) {
      return GetPageRoute(
        settings: settings,
        page: () => const VisitorSettingsView(),
        binding: VisitorSettingsBinding(),
        transition: Transition.noTransition,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Navigator(
            key: Get.nestedKey(2),
            initialRoute: Routes.visitorExplore,
            onGenerateRoute: onGenerateRoute,
          ),
          Container(
            width: Get.width,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 36),
            color: BackgroundPalette.soft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomNavBarItem(
                  asset: Assets.explore,
                  label: 'Explore',
                  selected: currentIndex == 0,
                  onTap: () => setState(() {
                    changePage(0);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      CustomButton(
                        width: 90,
                        text: 'Log in',
                        textColor: ThemePalette.light,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onPressed: widget.onLoginPressed,
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        width: 90,
                        text: 'Sign up',
                        secondaryColor: true,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        onPressed: widget.onSignUpPressed,
                      ),
                    ],
                  ),
                ),
                _bottomNavBarItem(
                  asset: Assets.settings,
                  label: 'Settings',
                  selected: currentIndex == 1,
                  onTap: () => setState(() {
                    changePage(1);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );*/

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 36),
      color: BackgroundPalette.soft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bottomNavBarItem(
            asset: Assets.explore,
            label: 'Explore',
            selected: currentIndex == 0,
            onTap: () => setState(() {
              currentIndex = 0;
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                CustomButton(
                  width: 90,
                  text: 'Log in',
                  textColor: ThemePalette.light,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  onPressed: widget.onLoginPressed,
                ),
                const SizedBox(width: 16),
                CustomButton(
                  width: 90,
                  text: 'Sign up',
                  secondaryColor: true,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  onPressed: widget.onSignUpPressed,
                ),
              ],
            ),
          ),
          _bottomNavBarItem(
            asset: Assets.settings,
            label: 'Settings',
            selected: currentIndex == 1,
            onTap: () => setState(() {
              //currentIndex = 1;
              Get.toNamed(Routes.visitorSettings);
            }),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBarItem(
      {required String asset,
      required String label,
      required bool selected,
      required Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: selected
          ? SvgPicture.asset(
              asset,
              width: 24,
              height: 26,
              color: ThemePalette.main,
            )
          : SvgPicture.asset(
              asset,
              width: 24,
              height: 26,
              color: ThemePalette.dark,
            ),
    );
  }
}

class VisitorBottomBar extends StatefulWidget {
  final Function() onLoginPressed;
  final Function() onSignUpPressed;
  const VisitorBottomBar({
    super.key,
    required this.onLoginPressed,
    required this.onSignUpPressed,
  });

  @override
  State<VisitorBottomBar> createState() => VisitorBottomBarState();
}
