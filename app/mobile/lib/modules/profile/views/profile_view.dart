import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/modules/profile/widgets/profile_header_widget.dart';

import '../../../data/widgets/custom_app_bar.dart';
import '../controllers/profile_controller.dart';
import '../widgets/followers_popup.dart';
import '../widgets/followings_popup.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        leadingAppIcon: true,
       
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 50),
        child: Obx(() {
          if (controller.routeLoading.value) {
            return SizedBox(
                height: Get.height - 200,
                child: const Center(child: CircularProgressIndicator()));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeaderWidget(
                followerCount: controller.followers.length,
                followingCount: controller.followings.length,
                user: controller.userProfile,
                onFollowersPressed: () {
                  Get.dialog(const FollowersPopup());
                },
                onFollowingPressed: () {
                  Get.dialog(const FollowingsPopup());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (controller.userId != controller.bottomNavController.userId)
                controller.isFollowing.value
                    ? OutlinedButton(
                        onPressed: () =>
                            controller.unfollowUser(controller.userId),
                        child: Text('Unfollow',
                            style: TextStyle(color: ThemePalette.main)))
                    : OutlinedButton(
                        onPressed: () =>
                            controller.followUser(controller.userId),
                        child: Text('Follow',
                            style: TextStyle(color: ThemePalette.main))),
              const SizedBox(height: 20),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Bunches',
                  style: TextStyle(color: ThemePalette.dark, fontSize: 16),
                ),
                subtitle: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                initiallyExpanded: true,
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.ias.length,
                      itemBuilder: (context, index) {
                        return BunchWidget(
                            ia: controller.ias[index],
                            onTap: () =>
                                controller.navigateToIa(controller.ias[index]));
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 14,
                          )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Spots',
                style: TextStyle(color: ThemePalette.dark, fontSize: 16),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostTileWidget(
                      onTap: () => controller
                          .navigateToPostDetails(controller.posts[index]),
                      post: controller.posts[index],
                      showDownvoters: () =>
                          controller.showDownVotes(controller.posts[index].id),
                      showUpvoters: () =>
                          controller.showUpVotes(controller.posts[index].id),
                      hideTags: false,
                      onDownvote: () =>
                          controller.downvotePost(controller.posts[index].id),
                      onUpvote: () =>
                          controller.upvotePost(controller.posts[index].id),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8))
            ],
          );
        }),
      ),
    );
  }
}
