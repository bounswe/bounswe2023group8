import 'package:get/get.dart';
import 'package:mobile/data/models/user_model.dart';

class FollowingsController extends GetxController {
  final followings = <User>[
    User(
        name: 'Begüm Yivli',
        username: '@begum',
        profileImage: 'https://avatars.githubusercontent.com/u/88006241?v=4'),
    User(
        name: 'Sude Konyalioglu',
        username: '@barbunya',
        profileImage:
            'https://media.licdn.com/dms/image/D4D03AQEwzV5cotr8XA/profile-displayphoto-shrink_800_800/0/1681053885901?e=2147483647&v=beta&t=lkbnVNILWwVp-wb7ntCVJ4u9lmjsuKdOvwRIr8p0Rb8'),
  ].obs;
}
