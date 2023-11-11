import 'package:get/get.dart';
import 'package:mobile/routes/app_pages.dart';

import '../../../data/models/user_model.dart';
import '../../opening/controllers/opening_controller.dart';

class VisitorExploreController extends GetxController {
  RxList<UserModel> allUsers = <UserModel>[].obs;

  void fetchData() {
    allUsers.value = dummyUsers.map((e) => UserModel.fromJson(e)).toList();
  }

  void navigateToAuth(bool login) {
    Get.until((route) => Get.currentRoute == Routes.opening);
    Get.find<OpeningController>().navigateToAuthentication(toLogin: login);
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
}

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
