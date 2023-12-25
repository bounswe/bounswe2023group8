import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.routeLoading.value) {
          return SizedBox(
            height: Get.height - 200,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: CustomAppBar(
            leadingAppIcon: true,
            leadingBackIcon: controller.userId ==
                    controller.bottomNavigationController.userId
                ? false
                : true,
            search: false,
            notification: false,
            actions: [
              if (controller.userId !=
                  controller.bottomNavigationController.userId)
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => controller.showReportUser(),
                  child: Image.asset(
                    Assets.report,
                    width: 24,
                    height: 24,
                  ),
                ),
              const SizedBox(width: 16),
            ],
          ),
          body: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                profileHeader(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          Row(
                            children: [
                              Text(
                                controller.isBunchExpanded.value
                                    ? 'Hide'
                                    : 'Show',
                                style: TextStyle(
                                  color: SeparatorPalette.dark,
                                  fontSize: 12,
                                  fontFamily: 'Work Sans',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.2,
                                ),
                              ),
                              const SizedBox(width: 4),
                              InkWell(
                                onTap: () {
                                  controller.isBunchExpanded.value =
                                      !controller.isBunchExpanded.value;
                                },
                                child: SvgPicture.asset(
                                  controller.isBunchExpanded.value
                                      ? Assets.expand
                                      : Assets.collapse,
                                  width: 14,
                                  height: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Divider(
                        color: SeparatorPalette.dark,
                        height: 1,
                        thickness: 1,
                      ),
                      const SizedBox(height: 8),
                      if (controller.isBunchExpanded.value)
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.ias.length,
                          itemBuilder: (context, index) {
                            final ia = controller.ias[index];
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
                        itemCount: controller.posts.length,
                        itemBuilder: (context, index) {
                          final spot = controller.posts[index];
                          final isVoted =
                              controller.isVotes[spot.id] ?? [false, false];
                          return PostTileWidget(
                            onTap: () => controller.navigateToPostDetails(spot),
                            post: spot,
                            hideTags: false,
                            isUpvoted: isVoted[0],
                            isDownvoted: isVoted[1],
                            onDownvote: () => controller.downvotePost(spot.id),
                            onUpvote: () => controller.upvotePost(spot.id),
                            showVoters: () => controller.showVotes(spot.id),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 8);
                        },
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

  Widget profileHeader() {
    return Container(
      color: BackgroundPalette.soft,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              controller.userProfile.profilePictureUrl != null &&
                      controller.userProfile.profilePictureUrl!.isNotEmpty
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          controller.userProfile.profilePictureUrl!),
                    )
                  : Image.asset(
                      Assets.profilePlaceholder,
                      width: 80,
                      height: 80,
                    ),
              if (controller.userId ==
                  controller.bottomNavigationController.userId) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    InkWell(
                      onTap: controller.uploadImage,
                      child: Image.asset(
                        Assets.newPicture,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    if (controller.userProfile.profilePictureUrl != null &&
                        controller
                            .userProfile.profilePictureUrl!.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: controller.deletePicture,
                        child: Image.asset(
                          Assets.delete,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  controller.userProfile.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ThemePalette.dark,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.31,
                  ),
                ),
                Text(
                  '@${controller.userProfile.username}',
                  style: TextStyle(
                    color: ThemePalette.dark,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => controller.showFollowPopUp(0),
                              child: Text(
                                '${controller.followers.length} followers',
                                style: TextStyle(
                                  color: ThemePalette.main,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            InkWell(
                              onTap: () => controller.showFollowPopUp(1),
                              child: Text(
                                '${controller.followings.length} following',
                                style: TextStyle(
                                  color: ThemePalette.main,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (controller.userId !=
                            controller.bottomNavigationController.userId)
                          InkWell(
                            onTap: controller.isFollowing.value
                                ? () =>
                                    controller.unfollowUser(controller.userId)
                                : () =>
                                    controller.followUser(controller.userId),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical:
                                      controller.isFollowing.value ? 1 : 2),
                              decoration: controller.isFollowing.value
                                  ? BoxDecoration(
                                      color: BackgroundPalette.light,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: ThemePalette.negative,
                                        width: 1,
                                      ),
                                    )
                                  : BoxDecoration(
                                      color: ThemePalette.main,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                              child: Text(
                                controller.isFollowing.value
                                    ? 'Unfollow'
                                    : 'Follow',
                                style: TextStyle(
                                  color: controller.isFollowing.value
                                      ? ThemePalette.negative
                                      : ThemePalette.light,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.22,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              Assets.upvote,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              controller.userProfile.upvotes.toString(),
                              style: TextStyle(
                                color: ThemePalette.positive,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            Image.asset(
                              Assets.downvote,
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              controller.userProfile.downvotes.toString(),
                              style: TextStyle(
                                color: ThemePalette.negative,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
