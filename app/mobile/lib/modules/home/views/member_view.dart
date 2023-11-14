import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';

import '../../../data/models/user_model.dart';
import '../../profile/controllers/profile_controller.dart';

class MemberView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child:
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: Colors.grey.shade300,
                        margin: const EdgeInsets.all(1.0),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "JANE AUSTEN MOVIES",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: Colors.grey.shade400,
                        margin: const EdgeInsets.all(1.0),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Tags: #Jane Austen #Literature #Cinema",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 5,),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostTileWidget(
                      post: controller.posts[index],
                      getAreaNameById: controller.getAreaNameById,
                      getUserNameById: controller.getUserNameById,
                      hideTags: true,
                    );
                  })
            ],
          ),
        )    
       
      )



    );
  }
}

class TagRectangle extends StatelessWidget {
  final String tag;

  TagRectangle({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          tag,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class PopularUserCard extends StatelessWidget {
  final UserModel user;

  PopularUserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(user.userProfileImage),
          ),
          SizedBox(height: 8),
          Text(
            user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            '@${user.username}',
            style: TextStyle(
              color: Color(0xFF7E7E7E),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}