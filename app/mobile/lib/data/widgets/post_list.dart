import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostListController extends GetxController {
  final jsonData = <Map<String, dynamic>>[
    {
      "id": 101,
      "user_id": 1001,
      "ia_ids": [1],
      "source_link": "https://www.marca.com/en/football/2023/10/10/65251a10ca474153788b4578.html",
      "content": "The next World Cup may be three years away, but Cristiano Ronaldo reportedly plans to take part in the 2026 World Cup in the USA, Mexico and Canada.",
      "created_at": "2023-10-25 10:30:00",
      "title": "World Cup"
    },
    {
      "id": 102,
      "user_id": 1001,
      "ia_ids": [2, 3],
      "source_link": "https://apnews.com/article/hip-hop-50th-anniversary-nba-hisrory-81d0ada460ac2744ac9bd5eda66b6779",
      "content": "Just as a movie soundtrack helps viewers follow the action of the narrative through each plot twist, hip-hop has done the same for basketball via the NBA. Over the past five decades, the genre has inserted lyrics, beats and culture into the sport’s DNA. Now, as hip-hop reaches its 50th anniversary, the two are intertwined like a colorful, crisscrossed ball of yarn.",
      "created_at": "2023-10-24 11:15:00",
      "title": "NBA and Hip-Hop"
    },
    {
      "id": 103,
      "user_id": 1001,
      "ia_ids": [4],
      "source_link": "https://pinchofyum.com/house-favorite-garlic-bread",
      "content": "We did a soup series a few years ago, and I was thisclose to posting a garlic bread recipe in the series, but I never quite locked it in. I just could never commit to a certain type of bread, or a particular texture, or just a general look and feel. Do we want it crusty? Chewy? Hearty? Or light and toasty?",
      "created_at": "2023-10-23 09:00:00",
      "title": "Cooking Tips"
    },
    {
      "id": 104,
      "user_id": 1001,
      "ia_ids": [5],
      "source_link": "https://www.nationalgeographic.com/premium/article/invisible-wonders-photography-techniques",
      "content": "As a kid, I dreamed of becoming a marine biologist and living my life by the sea. Since I grew up in a landlocked suburb of Atlanta, I lived out this fantasy by setting up aquariums at home. At 14, I started working at my neighborhood aquarium shop. By 16, I had seven fish tanks at home. Then, at 20, I was introduced to photographer David Liittschwager, who hired me to help him with a National Geographic magazine assignment on marine life.",
      "created_at": "2023-10-22 14:45:00",
      "title": "Nat Geo"
    },
    {
      "id": 105,
      "user_id": 1001,
      "ia_ids": [1, 5],
      "source_link": "https://www.photocrowd.com/blog/195-beautiful-game-brief-guide-photographing-football-matches/",
      "content": "The temptation is to chase the action around the pitch. This will end up meaning you’re running as much as the players. It will benefit you to select one position, stay there and wait for the action to come to you. The prime position will be close to the net on one end of the pitch. This will give you opportunities to get great action shots as players fight for the ball and capture those crucial moments when a player scores.",
      "created_at": "2023-10-21 16:00:00",
      "title": "Sport Photography"
    }
// Add more JSON data as needed
  ].obs; // Use ".obs" to make the list observable

  final userData = <Map<String, dynamic>>[
    {
      "id": 1001,
      "name": "Furkan Özçelik",
      "nickname": "furkanozcelik",
      "ia_ids": [1,2,3,4,5],
      "follower_count": 7,
      "following_count": 7,
      "all_time_likes": 7,
      "all_time_dislikes": 7,
      "user_profile_image": "https://m.media-amazon.com/images/M/MV5BNDY3Y2E1NWYtMTFkZS00MzlmLTk2ZTItMTAyY2QxZDU1NjZhXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_FMjpg_UX1000_.jpg"
    }
  ];

  final interestAreaData = <Map<String, dynamic>>[
  {
  "id": 1,
  "area_name": "Football"
  },
  {
  "id": 2,
  "area_name": "Basketball"
  },
  {
  "id": 3,
  "area_name": "Music"
  },
  {
  "id": 4,
  "area_name": "Cooking"
  },
  {
  "id": 5,
  "area_name": "Photography"
  }
  ].obs;

}

class PostListWidget extends StatelessWidget {
  final PostListController postListController = Get.put(PostListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
            () => ListView.builder(
              itemCount: postListController.jsonData.length,
              itemBuilder: (context, index) {
                final item = postListController.jsonData[index];

                // Function to find area name by ID
                String getAreaNameById(int id) {
                  final area = postListController.interestAreaData.firstWhere(
                        (area) => area['id'] == id,
                    orElse: () => {'area_name': 'Area not found'},
                  );
                  return area['area_name'];
                }

                // Function to find area name by ID
                String getUserNameById(int id) {
                  print(id);
                  final user = postListController.userData.firstWhere(
                        (user) => user['id'] == id,
                    orElse: () => {'name': 'Area not found'},
                  );
                  return user['name'];
                }

                return Card(
                  color: Colors.blue.shade50,
                  child: ListTile(
                    title: Text(item['title']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${item['source_link']}\n",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                  fontSize: 12,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle the interest area tap (e.g., navigate to an area-specific page)
                                  },
                              ),
                            ],
                          ),
                          // maxLines: 2,
                        ),
                        // Text(
                        //   "Content: ${item['content']}",
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        Row(
                          children: [
                            Text("Created By: ", style: TextStyle(fontSize: 10)),
                            Text("${getUserNameById(item['user_id'])}", style: TextStyle(fontSize: 10, color: Colors.brown),),
                            const SizedBox(width: 40),
                            Text("${item['created_at'].split(" ")[0]}", style: TextStyle(fontSize: 10),),
                          ],
                        )
                      ],
                    ),
                    trailing: Container(
                      child: Column(
                        children: item['ia_ids'].map<Widget>((iaId) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              color: Colors.grey, // Set the grey background color
                              margin: const EdgeInsets.all(1.0), // Add margin between rows
                              child: Padding(
                                padding: const EdgeInsets.all(4.0), // Adjust padding as needed
                                child: Text(
                                  "#${getAreaNameById(iaId)}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54, // Text color inside the grey background
                                  ),
                                ),
                              ),
                            )
                          );
                        }).toList(),
                      ),
                    ),
                    onTap: () {
                      // Handle item tap (e.g., navigate to a detail page)
                    },
                  ),
                );
              },
            )



      ),
    );
  }
}

