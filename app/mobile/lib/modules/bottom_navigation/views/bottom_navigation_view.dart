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
    return Scaffold(
      body: Stack(children: [
        Navigator(
          key: Get.nestedKey(1),
          initialRoute: Routes.home,
          onGenerateRoute: controller.onGenerateRoute,
        ),
        Positioned(
          bottom: 0,
          child: Obx(() {
            return BottomNavbar(
              selected: controller.currentIndex.value,
              onTap: controller.changePage,
            );
          }),
        ),
        Positioned(
          bottom: 25,
          left: Get.width * 0.5 - 24,
          child: Center(
            child: CircleAvatar(
                backgroundColor: Palette.primaryColor,
                radius: 24,
                child: InkWell(
                  onTap: () {
                    controller.changePage(2);
                  },
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}

class BottomNavbar extends StatelessWidget {
  final int selected;
  final void Function(int) onTap;

  const BottomNavbar({
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
            height: 50,
            width: Get.width,
            color: Palette.lightColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                const SizedBox(),
                _bottomNavBarItem(
                    asset: Assets.newIa,
                    label: 'NewIa',
                    selected: selected == 3,
                    onTap: () {
                      onTap(3);
                    }),
                _bottomNavBarItem(
                    asset: Assets.settings,
                    label: 'Settings',
                    selected: selected == 4,
                    onTap: () {
                      onTap(4);
                    }),
              ],
            ),
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
        child: Center(
          child: selected
              ? SvgPicture.asset(
                  asset,
                  height: 26,
                  color: Palette.primaryColor,
                )
              : SvgPicture.asset(
                  asset,
                  height: 26,
                  color: Colors.black,
                ),
        ));
  }
}
