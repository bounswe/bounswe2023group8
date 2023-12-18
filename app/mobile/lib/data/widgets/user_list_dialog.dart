import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/models/enigma_user.dart';

class UserListDialog extends StatelessWidget {
  final String title;
  final List<EnigmaUser> users;
  const UserListDialog({super.key, required this.title, required this.users});

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
                Text(title),
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
                height: Get.height - 200,
                width: Get.width - 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: const CircleAvatar(
                          backgroundImage:
                              AssetImage(Assets.profilePlaceholder)),
                      title: Text(user.name),
                      subtitle: Text('@${user.username}'),
                    );
                  },
                ),
              ),
            ]));
  }
}
