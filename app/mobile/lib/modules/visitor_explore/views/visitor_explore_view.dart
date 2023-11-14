import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/visitor_bottom_bar.dart';

import '../../../data/constants/assets.dart';
import '../../../data/models/user_model.dart';
import '../../../data/widgets/custom_search_bar.dart';
import '../controllers/visitor_explore_controller.dart';

class VisitorExploreView extends GetView<VisitorExploreController> {
  const VisitorExploreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: VisitorBottomBar(
          onLoginPressed: () => controller.navigateToAuth(true),
          onSignUpPressed: () => controller.navigateToAuth(false)),
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            Assets.logo,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(top: 12, bottom: 12, right: 72),
            child: CustomSearchBar(),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Centered Header title
              const Center(
                child: Text(
                  'Find Your Interests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 4 rectangles with tags
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tagRectangle(tag: '#knitting'),
                  tagRectangle(tag: '#cats'),
                  tagRectangle(tag: '#anime'),
                  tagRectangle(tag: '#sports'),
                ],
              ),

              const SizedBox(
                  height: 24), // Add space between the tags and the new section

              // Trending title without a rectangle
              const Center(
                child: Text(
                  'Trending',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6EFF4),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
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

              const SizedBox(height: 8), // Add space between the rectangles
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6EFF4),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                child: const Column(
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
              const SizedBox(height: 12),
              // Discover title without a rectangle
              const Center(
                child: Text(
                  'Discover Popular Users',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // List of popular users
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return popularUserCard(
                      user: controller.allUsers[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

Widget tagRectangle({required String tag}) {
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
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget popularUserCard({required UserModel user}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(user.userProfileImage),
        ),
        const SizedBox(height: 8),
        Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Text(
          '@${user.username}',
          style: const TextStyle(
            color: Color(0xFF7E7E7E),
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
