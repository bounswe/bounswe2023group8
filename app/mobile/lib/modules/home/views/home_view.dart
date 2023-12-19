import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';
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
            titleWidget: CustomSearchBar(
              onChanged: controller.onSearchQueryChanged,
            ),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                child: SvgPicture.asset(Assets.notification),
              )
            ],
          ),
          body: Container(
            color: ThemePalette.white,
            child: SingleChildScrollView(
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
                                onTap: () {},
                                child: Container(
                                  height: 28,
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
                                onTap: () {},
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
                        const SizedBox(height: 8),
                        ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.posts.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 8);
                          },
                          itemBuilder: (context, index) {
                            return PostTileWidget(
                              onTap: () => controller.navigateToPostDetails(
                                  controller.posts[index]),
                              post: controller.posts[index],
                              hideTags: false,
								onUpvote: () => controller.upvotePost(
                                          controller.posts[index].id),
                                      onDownvote: () => controller.downvotePost(
                                          controller.posts[index].id),
                                      showDownvoters: () =>
                                          controller.showDownVotes(
                                              controller.posts[index].id),
                                      showUpvoters: () =>
                                          controller.showUpVotes(
                                              controller.posts[index].id),
                            );
                          },
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.searchIas.isNotEmpty) ...[
          const Text('Bunches',
              style: TextStyle(
                fontSize: 16,
              )),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.searchIas.length,
              itemBuilder: (context, index) {
                final ia = controller.searchIas[index];
                return BunchWidget(
                    ia: ia, onTap: () => controller.navigateToIa(ia));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              }),
          const SizedBox(
            height: 10,
          ),
        ],
        if (controller.searchUsers.isNotEmpty) ...[
          const Text('Profiles',
              style: TextStyle(
                fontSize: 16,
              )),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 140,
            width: Get.width,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(16)),
            child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.searchUsers.length,
                itemBuilder: (context, index) {
                  final user = controller.searchUsers[index];
                  return ProfileColumn(
                      user: user,
                      onTap: () => controller.navigateToProfile(user.id));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        if (controller.searchPosts.isNotEmpty) ...[
          const Text('Spots',
              style: TextStyle(
                fontSize: 16,
              )),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.searchPosts.length,
              itemBuilder: (context, index) {
                return PostTileWidget(
                  onTap: () => controller
                      .navigateToPostDetails(controller.searchPosts[index]),
                  post: controller.searchPosts[index],
                  hideTags: false,
                  onDownvote: () =>
                      controller.downvotePost(controller.searchPosts[index].id),
                  onUpvote: () =>
                      controller.upvotePost(controller.searchPosts[index].id),
                  showDownvoters: () {},
                  showUpvoters: () {},
                      
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              }),
        ],
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
