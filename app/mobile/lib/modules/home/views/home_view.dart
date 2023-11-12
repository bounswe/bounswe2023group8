import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/modules/profile/controllers/profile_controller.dart';
import 'package:mobile/data/models/user_model.dart';
import '../../home/bindings/home_binding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomeView(),
      initialBinding: HomeBinding(), // Add this line
    );
  }
}
class HomeView extends GetView<ProfileController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 72),
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
      ),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF9A9A9A), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Icon(Icons.search, color: const Color(0xFF9A9A9A)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
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