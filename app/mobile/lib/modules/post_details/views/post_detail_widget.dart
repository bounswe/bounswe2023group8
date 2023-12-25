import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/modules/post_details/controllers/post_details_controller.dart';
import 'package:mobile/routes/app_pages.dart';
import '../../../../data/constants/assets.dart';

class PostDetailWidget extends GetView<PostDetailsController> {
  const PostDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BackgroundPalette.regular,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () =>
                              Get.toNamed(Routes.interestArea, arguments: {
                            'interestArea': controller.post.value.interestArea
                          }),
                          child: Text(
                            controller.post.value.interestArea.name,
                            style: TextStyle(
                              color: ThemePalette.dark,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.31,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              controller.post.value.createTime.split(' ').first,
                              style: TextStyle(
                                color: SeparatorPalette.dark,
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.17,
                              ),
                            ),
                            Text(
                              controller.post.value.createTime.split(' ').last,
                              style: TextStyle(
                                color: SeparatorPalette.dark,
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                letterSpacing: -0.17,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed(Routes.profile, arguments: {
                          'userId': controller.post.value.enigmaUser.id
                        }),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.post.value.enigmaUser.pictureUrl !=
                                        null &&
                                    controller.post.value.enigmaUser.pictureUrl!
                                        .isNotEmpty
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(controller
                                        .post.value.enigmaUser.pictureUrl!),
                                  )
                                : Image.asset(
                                    Assets.profilePlaceholder,
                                    width: 40,
                                    height: 40,
                                  ),
                            const SizedBox(width: 6),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        controller.post.value.enigmaUser.name,
                                        style: TextStyle(
                                          color: ThemePalette.dark,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.24,
                                        ),
                                      ),
                                      if (controller.showFollowButton() |
                                          controller.showUnfollowButton()) ...[
                                        const SizedBox(width: 6),
                                        InkWell(
                                          onTap: controller.showFollowButton()
                                              ? controller.followUser
                                              : controller.unfollowUser,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 6,
                                                vertical: controller
                                                        .showFollowButton()
                                                    ? 2
                                                    : 1),
                                            decoration: BoxDecoration(
                                              color:
                                                  controller.showFollowButton()
                                                      ? ThemePalette.main
                                                      : BackgroundPalette.light,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: controller
                                                      .showFollowButton()
                                                  ? null
                                                  : Border.all(
                                                      color:
                                                          ThemePalette.negative,
                                                      width: 1),
                                            ),
                                            child: Text(
                                              controller.showFollowButton()
                                                  ? 'Follow'
                                                  : 'Unfollow',
                                              style: TextStyle(
                                                color: controller
                                                        .showFollowButton()
                                                    ? ThemePalette.light
                                                    : ThemePalette.negative,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.17,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Text(
                                    '@${controller.post.value.enigmaUser.username}',
                                    style: TextStyle(
                                      color: ThemePalette.main,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: Get.width,
                        padding: const EdgeInsets.only(
                            left: 46, right: 8, top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: BackgroundPalette.light,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.post.value.title,
                              style: TextStyle(
                                color: ThemePalette.dark,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.24,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                  color: BackgroundPalette.solid,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                controller.post.value.label,
                                style: TextStyle(
                                  color: BackgroundPalette.light,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.17,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              controller.post.value.sourceLink,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: ThemePalette.main,
                                decoration: TextDecoration.underline,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 5,
                            ),
                            const SizedBox(height: 8),
                            SelectableText(
                              controller.post.value.content,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                              onSelectionChanged:
                                  controller.onAnnotationSelectionChange,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: -8,
                        top: -8,
                        child: Image.asset(
                          Assets.spot,
                          width: 51,
                          height: 58,
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 60,
                        child: InkWell(
                          onTap: controller.showLocation,
                          child: Image.asset(
                            Assets.geolocation,
                            width: 28,
                            height: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: BackgroundPalette.dark,
                        borderRadius: BorderRadius.circular(10)),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tag in controller.post.value.wikiTags) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: SeparatorPalette.light,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "#${tag.label}",
                              style: TextStyle(
                                color: SeparatorPalette.dark,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.2,
                              ),
                            ),
                          ),
                        ],
                        if (controller.post.value.enigmaUser.id !=
                            controller.bottomNavigationController.userId)
                          InkWell(
                            onTap: () =>
                                controller.showTagSuggestionModal(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              decoration: BoxDecoration(
                                color: BackgroundPalette.solid,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                    Assets.add,
                                    width: 12,
                                    height: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Suggest",
                                    style: TextStyle(
                                      color: ThemePalette.light,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
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
                  Row(
                    children: [
                      InkWell(
                        onTap: controller.upvotePost,
                        child: Image.asset(
                          Assets.upvoteEmpty,
                          width: 28,
                          height: 28,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => controller.showVotes(0),
                        child: Text(
                          controller.post.value.upvoteCount.toString(),
                          style: TextStyle(
                            color: ThemePalette.positive,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.27,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      InkWell(
                        onTap: controller.downvotePost,
                        child: Image.asset(
                          Assets.downvoteEmpty,
                          width: 28,
                          height: 28,
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => controller.showVotes(1),
                        child: Text(
                          controller.post.value.downvoteCount.toString(),
                          style: TextStyle(
                            color: ThemePalette.negative,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.27,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: -11,
              left: 0,
              child: Image.asset(
                Assets.bunch,
                width: 48,
                height: 48,
              ),
            ),
          ],
        );
      },
    );
  }
}
