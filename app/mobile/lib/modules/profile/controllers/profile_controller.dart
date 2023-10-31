import 'package:get/get.dart';
import 'package:mobile/data/models/ia_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/user_model.dart';

import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class ProfileController extends GetxController {
  final bottomNavController = Get.find<BottomNavigationController>();

  RxList<UserModel> followers = <UserModel>[].obs;
  RxList<UserModel> followings = <UserModel>[].obs;
  RxList<UserModel> allUsers = <UserModel>[].obs;
  RxList<PostModel> posts = <PostModel>[].obs;
  RxList<IaModel> ias = <IaModel>[].obs;

  String getAreaNameById(int id) {
    return ias.firstWhere((element) => element.id == id).areaName;
  }

  String getUserNameById(int id) {
    return allUsers.firstWhere((element) => element.id == id).name;
  }

  void fetchData() {
    allUsers.value = dummyUsers.map((e) => UserModel.fromJson(e)).toList();
    followers.value = dummyUsers.map((e) => UserModel.fromJson(e)).toList();
    followers.removeWhere((element) => element.id == 1004);
    followings.value = followers;
    posts.value = dummyPosts.map((e) => PostModel.fromJson(e)).toList();
    ias.value = dummyIas.map((e) => IaModel.fromJson(e)).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}
}

//dummy data to be removed

final dummyUsers = [
  {
    "id": 1001,
    "name": "Furkan Özçelik",
    "nickname": "furkanozcelik",
    "ia_ids": [1, 2, 3, 4, 5],
    "follower_count": 7,
    "following_count": 7,
    "all_time_likes": 7,
    "all_time_dislikes": 7,
    "user_profile_image":
        "https://m.media-amazon.com/images/M/MV5BNDY3Y2E1NWYtMTFkZS00MzlmLTk2ZTItMTAyY2QxZDU1NjZhXkEyXkFqcGdeQXVyMTA0MTM5NjI2._V1_FMjpg_UX1000_.jpg"
  },
  {
    "id": 1002,
    "name": "Begüm Yivli",
    "nickname": "begumyivli",
    "ia_ids": [1, 2, 3, 5],
    "follower_count": 10,
    "following_count": 5,
    "all_time_likes": 13,
    "all_time_dislikes": 4,
    "user_profile_image": "https://avatars.githubusercontent.com/u/88006241?v=4"
  },
  {
    "id": 1003,
    "name": "Sude Konyalıoğlu",
    "nickname": "sudekonyalioglu",
    "ia_ids": [1, 2, 3, 4, 5],
    "follower_count": 10,
    "following_count": 5,
    "all_time_likes": 13,
    "all_time_dislikes": 4,
    "user_profile_image":
        "https://media.licdn.com/dms/image/D4D03AQEwzV5cotr8XA/profile-displayphoto-shrink_800_800/0/1681053885901?e=2147483647&v=beta&t=lkbnVNILWwVp-wb7ntCVJ4u9lmjsuKdOvwRIr8p0Rb8"
  },
  {
    "id": 1004,
    "name": "Meriç Keskin",
    "nickname": "marcolphin",
    "ia_ids": [1, 2, 3, 4, 5],
    "follower_count": 3,
    "following_count": 3,
    "all_time_likes": 20,
    "all_time_dislikes": 5,
    "user_profile_image":
        "https://avatars.githubusercontent.com/u/88164767?s=400&u=09da0dbc9d0ee0246d7492d938a20dbc4b2be7f1&v=4"
  }
];

final dummyPosts = [
  {
    "id": 101,
    "user_id": 1004,
    "ia_ids": [1],
    "source_link":
        "https://www.marca.com/en/football/2023/10/10/65251a10ca474153788b4578.html",
    "content":
        "The next World Cup may be three years away, but Cristiano Ronaldo reportedly plans to take part in the 2026 World Cup in the USA, Mexico and Canada.",
    "created_at": "2023-10-25 10:30:00",
    "title": "World Cup"
  },
  {
    "id": 102,
    "user_id": 1004,
    "ia_ids": [2, 3],
    "source_link":
        "https://apnews.com/article/hip-hop-50th-anniversary-nba-hisrory-81d0ada460ac2744ac9bd5eda66b6779",
    "content":
        "Just as a movie soundtrack helps viewers follow the action of the narrative through each plot twist, hip-hop has done the same for basketball via the NBA. Over the past five decades, the genre has inserted lyrics, beats and culture into the sport’s DNA. Now, as hip-hop reaches its 50th anniversary, the two are intertwined like a colorful, crisscrossed ball of yarn.",
    "created_at": "2023-10-24 11:15:00",
    "title": "NBA and Hip-Hop"
  },
  {
    "id": 103,
    "user_id": 1004,
    "ia_ids": [4],
    "source_link": "https://pinchofyum.com/house-favorite-garlic-bread",
    "content":
        "We did a soup series a few years ago, and I was thisclose to posting a garlic bread recipe in the series, but I never quite locked it in. I just could never commit to a certain type of bread, or a particular texture, or just a general look and feel. Do we want it crusty? Chewy? Hearty? Or light and toasty?",
    "created_at": "2023-10-23 09:00:00",
    "title": "Cooking Tips"
  },
  {
    "id": 104,
    "user_id": 1004,
    "ia_ids": [5],
    "source_link":
        "https://www.nationalgeographic.com/premium/article/invisible-wonders-photography-techniques",
    "content":
        "As a kid, I dreamed of becoming a marine biologist and living my life by the sea. Since I grew up in a landlocked suburb of Atlanta, I lived out this fantasy by setting up aquariums at home. At 14, I started working at my neighborhood aquarium shop. By 16, I had seven fish tanks at home. Then, at 20, I was introduced to photographer David Liittschwager, who hired me to help him with a National Geographic magazine assignment on marine life.",
    "created_at": "2023-10-22 14:45:00",
    "title": "Nat Geo"
  },
  {
    "id": 105,
    "user_id": 1004,
    "ia_ids": [1, 5],
    "source_link":
        "https://www.photocrowd.com/blog/195-beautiful-game-brief-guide-photographing-football-matches/",
    "content":
        "The temptation is to chase the action around the pitch. This will end up meaning you’re running as much as the players. It will benefit you to select one position, stay there and wait for the action to come to you. The prime position will be close to the net on one end of the pitch. This will give you opportunities to get great action shots as players fight for the ball and capture those crucial moments when a player scores.",
    "created_at": "2023-10-21 16:00:00",
    "title": "Sport Photography"
  }
];

final dummyIas = [
  {"id": 1, "area_name": "Football"},
  {"id": 2, "area_name": "Basketball"},
  {"id": 3, "area_name": "Music"},
  {"id": 4, "area_name": "Cooking"},
  {"id": 5, "area_name": "Photography"}
];
