import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/data/widgets/visitor_bottom_bar.dart';
import '../controllers/visitor_explore_controller.dart';

class VisitorExploreView extends GetView<VisitorExploreController> {
  const VisitorExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          bottomNavigationBar: VisitorBottomBar(
            onLoginPressed: () => controller.navigateToLogIn(),
            onSignUpPressed: () => controller.navigateToSignUp(),
          ),
          appBar: const CustomAppBar(
            leadingAppIcon: true,
            search: false,
            notification: false,
            actions: [],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.dark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            "Find your interest!",
                            style: TextStyle(
                              color: BackgroundPalette.light,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 23,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.bunches.length + 1,
                          itemBuilder: (context, index) {
                            if (index == controller.bunches.length) {
                              return Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Text(
                                    "...and many more!",
                                    style: TextStyle(
                                        color: BackgroundPalette.light,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -0.2),
                                  ),
                                ],
                              );
                            } else {
                              return bunchRectangle(
                                bunch: controller.bunches[index],
                              );
                            }
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 4),
                        ),
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
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 402,
                        child: ListView.separated(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.spots.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            return PostTileWidget(
                              onTap: () => controller.navigateToSignUp(),
                              post: controller.spots[index],
                              hideTags: false,
                              isUpvoted: false,
                              isDownvoted: false,
                              onUpvote: () {},
                              onDownvote: () {},
                              showVoters: () {},
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
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.dark,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text(
                            "Popular Users",
                            style: TextStyle(
                              color: BackgroundPalette.light,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 106,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          scrollDirection: Axis.horizontal,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.users.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return popularUsers(
                              user: controller.users[index],
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
      },
    );
  }

  Widget bunchRectangle({required InterestArea bunch}) {
    return InkWell(
      onTap: () => controller.navigateToSignUp(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: BackgroundPalette.solid,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          bunch.name,
          style: TextStyle(
            color: BackgroundPalette.soft,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.2,
          ),
        ),
      ),
    );
  }

  Widget popularUsers({required EnigmaUser user}) {
    return InkWell(
      onTap: () => controller.navigateToSignUp(),
      child: Column(
        children: [
          user.pictureUrl != null && user.pictureUrl!.isNotEmpty
              ? CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.pictureUrl!),
                )
              : Image.asset(
                  Assets.profilePlaceholder,
                  width: 80,
                  height: 80,
                ),
          const SizedBox(height: 4),
          Text(
            user.name,
            style: TextStyle(
              color: ThemePalette.light,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.15,
            ),
          ),
          Text(
            '@${user.username}',
            style: TextStyle(
              color: ThemePalette.light,
              fontSize: 8,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.15,
            ),
          ),
        ],
      ),
    );
  }
}
