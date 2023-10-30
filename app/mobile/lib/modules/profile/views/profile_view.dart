import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/post_list.dart';
import 'package:mobile/modules/profile/widgets/profile_header_widget.dart';

import '../controllers/profile_controller.dart';
import '../controllers/followers_controller.dart';
import '../controllers/followings_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            ProfileHeaderWidget(
              user: controller.bottomNavController.signedInUser,
              followersCount: 10,
              followingCount: 20,
              onFollowersPressed: () {
                Get.dialog(FollowersPopup());
              },
              onFollowingPressed: () {
                Get.dialog(FollowingsPopup());
              },
            ),
            const Text(
              'ProfileView is working',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: PostListWidget(),
            ),
          ],
        ),
      ),

    );
  }
}


class FollowersPopup extends StatelessWidget {
  final followersController = Get.put(FollowersController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor:
            const Color(0xFFF6F6F6), // Set the background color
      ),
      child: SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Followers'),
            IconButton(
              icon: const Icon(Icons.close), // Close icon
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
        children: [
          Divider(),
          Container(
            width: 200, // necessary don't know why
            height: 300,
            child: SingleChildScrollView(
              // Wrap your content with SingleChildScrollView to add scrolling feature
              child: GetBuilder<FollowersController>(
                builder: (controller) {
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.followers.length,
                        itemBuilder: (context, index) {
                          final follower = controller.followers[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(follower.profileImage),
                            ),
                            title: Text(follower.name),
                            subtitle: Text(follower.username),
                            trailing: TextButton(
                              onPressed: () {
                                //TODO: Remove action
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF1F1F1),
                                foregroundColor: const Color(0xFFF13030),
                              ),
                              child: const Text("Remove"),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FollowingsPopup extends StatelessWidget {
  final followingsController = Get.put(FollowingsController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor:
            const Color(0xFFF6F6F6), // Set the background color
      ),
      child: SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Followings'),
            IconButton(
              icon: const Icon(Icons.close), // Close icon
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
        children: [
          Divider(),
          Container(
            width: 200, // necessary don't know why
            height: 300,
            child: SingleChildScrollView(
              // Wrap your content with SingleChildScrollView
              child: GetBuilder<FollowingsController>(
                builder: (controller) {
                  return Column(
                    // Wrap with a Column
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.followings.length,
                        itemBuilder: (context, index) {
                          final following = controller.followings[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(following.profileImage),
                            ),
                            title: Text(following.name),
                            subtitle: Text(following.username),
                            trailing: TextButton(
                              onPressed: () {
                                //TODO: Unfollow action
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: const Color(0xFFF1F1F1),
                                foregroundColor: const Color(0xFFF13030),
                              ),
                              child: const Text("Unfollow"),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
