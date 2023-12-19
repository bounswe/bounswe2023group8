import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';

import '../controllers/profile_controller.dart';

class FollowingsPopup extends GetView<ProfileController> {
  const FollowingsPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dialogBackgroundColor:
            const Color(0xFFF6F6F6), // Set the background color
      ),
      child: Obx(() {
        return SimpleDialog(
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
              width: Get.width - 40,
              height: Get.height - 200,
              child: 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.followings.length,
                    itemBuilder: (context, index) {
                      final following = controller.followings[index];
                      return ListTile(
                        leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage(Assets.profilePlaceholder),
                        ),
                        title: Text(following.name),
                    subtitle: Text('@${following.username}'),
                        trailing: TextButton(
                          onPressed: () {
                            controller.unfollowUser(following.id);
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
            ),
          ],
        );
      }
      ),
    );
  }
}
