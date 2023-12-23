import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/modules/post_details/controllers/post_details_controller.dart';
import '../../../../data/constants/assets.dart';

class PostDetailWidget extends GetView<PostDetailsController> {
  const PostDetailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                    children: [
                      Text(
                        controller.post.value.interestArea.name,
                        style: TextStyle(
                            fontSize: 18,
                            color: ThemePalette.dark,
                            fontWeight: FontWeight.w700),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.post.value.createTime.split(' ').first,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: SeparatorPalette.dark),
                          ),
                          Text(controller.post.value.createTime.split(' ').last,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w300,
                                  color: SeparatorPalette.dark)),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(Assets.profilePlaceholder)),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.post.value.enigmaUser.name,
                          style: TextStyle(
                              color: ThemePalette.dark,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '@${controller.post.value.enigmaUser.username}',
                          style: TextStyle(
                              color: ThemePalette.main,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (controller.showFollowButton() |
                        controller.showUnfollowButton())
                      InkWell(
                        onTap: controller.showFollowButton()
                            ? controller.followUser
                            : controller.unfollowUser,
                        child: Container(
                          decoration: BoxDecoration(
                            color: ThemePalette.main,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          child: Text(
                            controller.showFollowButton()
                                ? 'Follow'
                                : 'Unfollow',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: BackgroundPalette.light,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          SizedBox(
                              width: 40,
                              child: InkWell(
                                  onTap: controller.showLocation,
                                  child: Image.asset(Assets.geolocation))),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  controller.post.value.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: ThemePalette.dark,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: BackgroundPalette.solid,
                                      borderRadius: BorderRadius.circular(14)),
                                  child: Text(
                                    controller.post.value.label,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(controller.post.value.sourceLink,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ThemePalette.main,
                                    )),
                                const SizedBox(height: 8),
                                Text(
                                  controller.post.value.content,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        left: -5,
                        top: -8,
                        child: Image.asset(
                          Assets.spot,
                          height: 58,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: ThemePalette.dark,
                      borderRadius: BorderRadius.circular(10)),
                  child: Wrap(
                    children: (controller.post.value.wikiTags)
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(
                                  right: 4.0, bottom: 4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: SeparatorPalette.light,
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Text(
                                  '#${e.label}',
                                  style: TextStyle(
                                      color: SeparatorPalette.dark,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: controller.upvotePost,
                      child: Image.asset(
                        Assets.upvote,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () => controller.showVotes(0),
                      child: Text(
                        controller.post.value.upvoteCount.toString(),
                        style: TextStyle(color: ThemePalette.positive),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: controller.downvotePost,
                      child: Image.asset(
                        Assets.downvote,
                        height: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () => controller.showVotes(1),
                      child: Text(
                        controller.post.value.downvoteCount.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              top: -15,
              left: -5,
              child: Image.asset(
                Assets.bunch,
                height: 48,
              )),
        ],
      );
    });
  }
}
