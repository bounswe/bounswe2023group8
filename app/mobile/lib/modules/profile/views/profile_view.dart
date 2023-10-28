import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
            ProfileHeader(
              followersCount: 20,
              followingCount: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final int followersCount;
  final int followingCount;

  const ProfileHeader({
    Key? key,
    required this.followersCount,
    required this.followingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Padding( // wrapped with padding to add some distance between 2 text
          padding: const EdgeInsets.only(right: 10), 
            child: InkWell(
            onTap: () {
              Get.dialog(FollowersPopup());
            },
            child: Text('$followersCount followers'),
          )
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
            child: InkWell(
            onTap: () {
              Get.dialog(FollowingsPopup());
            },
            child: Text('$followingCount followings'),
          )
        ),
      ],
    );
  }
}

class FollowersPopup extends StatelessWidget {
  final followersController = Get.put(FollowersController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor: Color(0xFFF1F1F1), // Set the background color
      ),
      child: SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Followers'),
            IconButton(
              icon: Icon(Icons.close), // Close icon
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
        children: [
          Container(
            width: 200, // necessary don't know why
            height: 300,
            child: SingleChildScrollView( // Wrap your content with SingleChildScrollView to add scrolling feature
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
                              backgroundImage: AssetImage(follower.profileImage),
                            ),
                            title: Text(follower.name),
                            subtitle: Text(follower.username),
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
        dialogBackgroundColor: Color(0xFFF1F1F1), // Set the background color
      ),
      child: SimpleDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Followings'),
            IconButton(
              icon: Icon(Icons.close), // Close icon
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        ),
        children: [
          Container(
            width: 200, // necessary don't know why
            height: 300,
            child: SingleChildScrollView( // Wrap your content with SingleChildScrollView
              child: GetBuilder<FollowingsController>(
                builder: (controller) {
                  return Column( // Wrap with a Column
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.followings.length,
                        itemBuilder: (context, index) {
                          final following = controller.followings[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(following.profileImage),
                            ),
                            title: Text(following.name),
                            subtitle: Text(following.username),
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
