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
    return Obx(() {
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
                              height: 44,
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                ),
                                color: BackgroundPalette.regular,
                              ),
                              child: Row()),
                          ListView.builder(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.posts.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    PostTileWidget(
                                      onTap: () =>
                                          controller.navigateToPostDetails(
                                              controller.posts[index]),
                                      post: controller.posts[index],
                                      hideTags: false,
                                    )
                                  ],
                                );
                              })
                        ],
                      ))),
      );
    });
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
