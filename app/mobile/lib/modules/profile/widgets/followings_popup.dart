import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';

import '../controllers/profile_controller.dart';

class FollowingsPopup extends GetView<ProfileController> {
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
          const Divider(),
          SizedBox(
            width: 200, // necessary don't know why
            height: 300,
            child: SingleChildScrollView(
                // Wrap your content with SingleChildScrollView
                child: Column(
              // Wrap with a Column
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.followings.length,
                  itemBuilder: (context, index) {
                    final following = controller.followings[index];
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(Assets.profilePlaceholder),
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
            )),
          ),
        ],
      ),
    );
  }
}
