import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';

import '../controllers/profile_controller.dart';

class FollowersPopup extends GetView<ProfileController> {
  const FollowersPopup({super.key});

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
              const Divider(),
              SizedBox(
                width: Get.width - 40,
                height: Get.height - 200,
                child: 
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.followers.length,
                    itemBuilder: (context, index) {
                      final follower = controller.followers[index];
                      return ListTile(
                      leading: const CircleAvatar(
                            backgroundImage:
                                AssetImage(Assets.profilePlaceholder)),
                        title: Text(follower.name),
                      subtitle: Text('@${follower.username}'),
                        
                      );
                    },
                  
                ),
              ),
            ]));
  }
}
