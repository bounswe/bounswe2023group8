import 'package:flutter/material.dart';
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
    bool isExpanded = false;
    return Scaffold(
      appBar: CustomAppBar(
        leadingAppIcon: true,
        leadingBackIcon:
            controller.userId == controller.bottomNavigationController.userId
                ? false
                : true,
        search: false,
        notification: false,
        actions: [
          if (controller.userId != controller.bottomNavigationController.userId)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => controller.showReportUser(),
                child: Icon(
                  Icons.report_gmailerrorred,
                  size: 30,
                ),
              ),
            ),
        ],
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
              profileHeader(),
              const SizedBox(
                height: 20,
              ),
              if (controller.userId !=
                  controller.bottomNavigationController.userId)
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
                  color: Color(0xFF203376),
                ),
                initiallyExpanded: true,
                onExpansionChanged: (value) {
                  isExpanded = !isExpanded;
                },
                trailing: Icon(
                  isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  size: 40,
                  color: Color(0xFF203376), // Set the color as needed
                ),
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
                            height: 10,
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
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8))
            ],
          );
        }),
      ),
    );
  }

  Widget profileHeader() {
    return Container(
      child: SizedBox(
          child: Row(
        children: [
          Column(
            children: [
              controller.userProfile.profilePictureUrl != null &&
                      controller.userProfile.profilePictureUrl!.isNotEmpty
                  ? CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                          controller.userProfile.profilePictureUrl!))
                  : const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage(Assets.profilePlaceholder)),
              if (controller.userId ==
                  controller.bottomNavigationController.userId)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: controller.uploadImage,
                        child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.photo,
                              size: 16,
                              color: Colors.white,
                            )),
                      ),
                      if (controller.userProfile.profilePictureUrl != null &&
                          controller.userProfile.profilePictureUrl!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: InkWell(
                              onTap: controller.deletePicture,
                              child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 16,
                                  ))),
                        ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 8,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.userProfile.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '@${controller.userProfile.username}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => controller.showFollowPopUp(0),
                        child: Text(
                          '${controller.followers.length} Followers',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => controller.showFollowPopUp(1),
                        child: Text(
                          '${controller.followings.length} Following',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  Assets.upvote,
                  width: 25,
                ),
                Image.asset(
                  Assets.downvote,
                  width: 25,
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                controller.userProfile.upvotes.toString(),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                controller.userProfile.downvotes.toString(),
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
