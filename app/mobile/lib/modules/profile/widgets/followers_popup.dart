import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class FollowersPopup extends GetView<ProfileController> {
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
                width: 200, // necessary don't know why
                height: 300,
                child: SingleChildScrollView(
                    // Wrap your content with SingleChildScrollView to add scrolling feature
                    child: Column(children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.followers.length,
                    itemBuilder: (context, index) {
                      final follower = controller.followers[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/88164767?s=400&u=09da0dbc9d0ee0246d7492d938a20dbc4b2be7f1&v=4'),
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
                ])),
              ),
            ]));
  }
}
