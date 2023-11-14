import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile/data/models/post_model.dart';

import '../../../data/models/user_model.dart';
import '../../profile/controllers/profile_controller.dart';

class VisitorView extends GetView<ProfileController> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered Header title
            Center(
              child: Text(
                'Find Your Interests',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 12),

            // 4 rectangles with tags
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TagRectangle(tag: '#knitting'),
                TagRectangle(tag: '#cats'),
                TagRectangle(tag: '#anime'),
                TagRectangle(tag: '#sports'),
              ],
            ),

            SizedBox(height: 24), // Add space between the tags and the new section

            // Trending title without a rectangle
            Center(
              child: Text(
                'Trending',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE6EFF4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pride & Prejudice
                  Text(
                    'Pride & Prejudice: The 15 Best Movie & TV Adaptations, Ranked According To IMDb',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    'Created by Lauren Allen',
                    style: TextStyle(
                      color: Color(0xFF7E7E7E),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 8), // Add space between the rectangles
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE6EFF4),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Best books text
                  Text(
                    'Best books to read when you are in a reading slump',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    'Created by Lauren Allen',
                    style: TextStyle(
                      color: Color(0xFF7E7E7E),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Discover title without a rectangle
            Center(
              child: Text(
                'Discover Popular Users',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),

            // List of popular users
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return PopularUserCard(
                    user: controller.allUsers[index],
                  );
                },
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
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