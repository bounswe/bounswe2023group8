import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          body: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Navigator(
                key: Get.nestedKey(1),
                initialRoute: Routes.home,
                onGenerateRoute: controller.onGenerateRoute,
              ),
              BottomNavBar(
                selected: controller.currentIndex.value,
                onTap: controller.changePage,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  final int selected;
  final void Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: Get.width,
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 36),
          color: BackgroundPalette.soft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomNavBarItem(
                asset: Assets.home,
                label: 'Home',
                selected: selected == 0,
                onTap: () {
                  onTap(0);
                },
              ),
              _bottomNavBarItem(
                asset: Assets.profile,
                label: 'Profile',
                selected: selected == 1,
                onTap: () {
                  onTap(1);
                },
              ),
              const SizedBox(width: 48),
              _bottomNavBarItem(
                asset: Assets.createBunch,
                label: 'CreateBunch',
                selected: selected == 3,
                onTap: () {
                  onTap(3);
                },
              ),
              _bottomNavBarItem(
                asset: Assets.settings,
                label: 'Settings',
                selected: selected == 4,
                onTap: () {
                  onTap(4);
                },
              ),
            ],
          ),
        ),
        Positioned(
          top: -12,
          child: InkWell(
            onTap: () {
              onTap(2);
            },
            child: Image.asset(Assets.createSpot,
                width: 48,
                height: 48,
                opacity: AnimationController(
                  vsync: Navigator.of(context),
                  value: selected == 2 ? 0.6 : 1,
                )),
          ),
        ),
      ],
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
