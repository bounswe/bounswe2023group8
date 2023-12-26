import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/visitor_bottom_bar.dart';

import '../../../data/models/user_model.dart';
import '../../../data/widgets/custom_search_bar.dart';
import '../../opening/controllers/opening_controller.dart';
import '../controllers/visitor_explore_controller.dart';

class VisitorExploreView extends GetView<VisitorExploreController> {
  const VisitorExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: ThemePalette.light,
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(Assets.explore),
                Row(
                  children: [
                    CustomButton(
                      text: 'Log in',
                      textColor: ThemePalette.light,
                      fontSize: 16,
                      onPressed: () => controller.navigateToLogIn(),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    CustomButton(
                      text: 'Sign up',
                      secondaryColor: true,
                      fontSize: 16,
                      onPressed: () => controller.navigateToSignUp(),
                    ),
                  ],
                ),
                InkWell(
                    onTap: () => Get.to(() => const VisitorSettingsView()),
                    child: SvgPicture.asset(Assets.settings))
              ],
            ),
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
              ),
              const SizedBox(height: 12),

              // 4 rectangles with tags
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tagRectangle(tag: '#knitting'),
                  tagRectangle(tag: '#cats'),
                  tagRectangle(tag: '#anime'),
                  tagRectangle(tag: '#sports'),
                ],
              ),

              const SizedBox(
                  height: 24), // Add space between the tags and the new section

              // Trending title without a rectangle
              const Center(
                child: Text(
                  'Trending',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 8),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) =>
                      trendinPost(controller.posts[index])),


              const SizedBox(height: 12),
              // Discover title without a rectangle
              const Center(
                child: Text(
                  'Discover Popular Users',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // List of popular users
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return popularUserCard(
                      user: controller.allUsers[index],
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget trendinPost(PostModel post) {
    return InkWell(
      onTap: () => controller.navigateToPostDetails(post),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE6EFF4),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pride & Prejudice
            Text(
              post.title,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 8),
            Text(
              'Created by ${controller.getNameById(post.userId)}',
              style: const TextStyle(
                color: Color(0xFF7E7E7E),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget tagRectangle({required String tag}) {
    return InkWell(
      onTap: () => controller.navigateToVisitorInterestArea(),
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

Widget popularUserCard({required UserModel user}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage(Assets.profilePlaceholder)),
        const SizedBox(height: 8),
        Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          '@${user.username}',
          style: const TextStyle(
            color: Color(0xFF7E7E7E),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
