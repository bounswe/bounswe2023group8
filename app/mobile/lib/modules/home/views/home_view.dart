import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/data/widgets/profile_column.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';

import '../../../data/widgets/custom_app_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.routeLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: CustomAppBar(
            leadingAppIcon: true,
            search: true,
            onSearchQueryChanged: controller.onSearchQueryChanged,
            notification: false,
            actions: const [
              SizedBox(
                width: 30,
              )
            ],
          ),
          body: Container(
            height: Get.height,
            color: ThemePalette.white,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 60),
              physics: const ClampingScrollPhysics(),
              child: controller.searchQuery.value.isNotEmpty
                  ? _searchBody()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.only(
                              left: 16, top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                            color: BackgroundPalette.regular,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Sort By:',
                                style: TextStyle(
                                  color: ThemePalette.dark,
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  controller.sortByDate();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: BackgroundPalette.soft,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Assets.sortNew,
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "New",
                                        style: TextStyle(
                                          color: ThemePalette.dark,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              InkWell(
                                onTap: () {
                                  controller.sortByTop();
                                },
                                child: Container(
                                  height: 28,
                                  padding: const EdgeInsets.only(
                                      left: 2, right: 4, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    color: BackgroundPalette.soft,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        Assets.sortTop,
                                        width: 24,
                                        height: 24,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        "Top",
                                        style: TextStyle(
                                          color: ThemePalette.dark,
                                          fontSize: 12,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context, index) {
                            final spot = controller.posts[index];
                        
                            return PostTileWidget(
                              onTap: () =>
                                  controller.navigateToPostDetails(spot),
                              post: spot,
                              hideTags: false,
                              onUpvote: () => controller.upvotePost(spot.id),
                              onDownvote: () =>
                                  controller.downvotePost(spot.id),
                              showVoters: () => controller.showVotes(spot.id),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  Widget _searchBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (controller.searchIas.isNotEmpty) ...[
            Text(
              "Bunches",
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.25,
              ),
            ),
            const SizedBox(height: 4),
            Divider(
              color: SeparatorPalette.dark,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 8),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.searchIas.length,
              itemBuilder: (context, index) {
                final ia = controller.searchIas[index];
                return BunchWidget(
                  ia: ia,
                  onTap: () => controller.navigateToIa(ia),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
            ),
            const SizedBox(height: 16),
          ],
          if (controller.searchUsers.isNotEmpty) ...[
            Text(
              "Profiles",
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.25,
              ),
            ),
            const SizedBox(height: 4),
            Divider(
              color: SeparatorPalette.dark,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 8),
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: 120,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.searchUsers.length,
                  itemBuilder: (context, index) {
                    final user = controller.searchUsers[index];
                    return ProfileColumn(
                        user: user,
                        onTap: () => controller.navigateToProfile(user.id));
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (controller.searchPosts.isNotEmpty) ...[
            Text(
              "Spots",
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 16,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w500,
                letterSpacing: -0.25,
              ),
            ),
            const SizedBox(height: 4),
            Divider(
              color: SeparatorPalette.dark,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 8),
            ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.searchPosts.length,
                itemBuilder: (context, index) {
                  final spot = controller.searchPosts[index];
                  return PostTileWidget(
                    onTap: () => controller.navigateToPostDetails(spot),
                    post: spot,
                    hideTags: false,
                    onDownvote: () => controller.downvotePost(spot.id),
                    onUpvote: () => controller.upvotePost(spot.id),
                    showVoters: () => controller.showVotes(spot.id),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                }),
          ],
          //TODO: Make bottom bar clip
        ],
      ),
    );
  }
}
