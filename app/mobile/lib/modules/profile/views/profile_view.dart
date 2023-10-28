import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';


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
          ListTile(
            leading: CircleAvatar(
              // Follower's photo
              backgroundImage: AssetImage('assets/icons/begumpp.jpeg'),
            ),
            title: Text('Begüm Yivli'),
            subtitle: Text('@begum'),
          ),
          // Add more ListTile widgets for additional followers
        ],
      ),
    );
  }
}

class FollowingsPopup extends StatelessWidget {
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
        ListTile(
          leading: CircleAvatar(
            // Following's photo
            backgroundImage: AssetImage('assets/icons/begumpp.jpeg'),
          ),
          title: Text('Begüm Yivli'),
          subtitle: Text('@begum'),
        ),
        // Add more ListTile widgets for additional followers
      ],
    ),
    );
  }
}
