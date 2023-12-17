import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/data/widgets/visitor_bottom_bar.dart';

import '../../../data/models/user_model.dart';
import '../../../data/widgets/custom_search_bar.dart';
import '../../opening/controllers/opening_controller.dart';
import '../controllers/visitor_explore_controller.dart';

class VisitorExploreView extends GetView<VisitorExploreController> {
  const VisitorExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: VisitorBottomBar(
          onLoginPressed: () => Get.find<OpeningController>().backToAuth(true),
          onSignUpPressed: () =>
              Get.find<OpeningController>().backToAuth(false)),
      appBar: const CustomAppBar(
        leadingAppIcon: true,
        titleWidget: CustomSearchBar(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Find your interest!",
                    style: TextStyle(
                      color: BackgroundPalette.light,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizedBox(
                        width: Get.width * 0.6,
                        height: 23,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            return tagRectangle(
                              tag: "#sampletag",
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 4),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text("...and many more!",
                          style: TextStyle(
                              color: BackgroundPalette.light,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Trending Spots",
                    style: TextStyle(
                      color: BackgroundPalette.light,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 402,
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: controller.dummySpots.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        return PostTileWidget(
                          onTap: () {
                            //TODO: Navigate to post details
                          },
                          post: controller.dummySpots[index],
                          hideTags: false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Popular Users",
                    style: TextStyle(
                      color: BackgroundPalette.light,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 106,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: controller.dummyUsers.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return popularUsers(
                          user: controller.dummyUsers[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tagRectangle({required String tag}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: SeparatorPalette.light,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: SeparatorPalette.dark,
          fontSize: 12,
          fontFamily: "Inter",
          fontWeight: FontWeight.w500,
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

Widget popularUsers({required EnigmaUser user}) {
  return Column(
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
  );
}
