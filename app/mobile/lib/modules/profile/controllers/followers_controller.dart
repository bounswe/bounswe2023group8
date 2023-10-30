import 'package:get/get.dart';
import 'package:mobile/data/models/user_model.dart';

class FollowersController extends GetxController {
  final followers = <User>[
    User(
        name: 'Begüm Yivli',
        username: '@begum',
        profileImage: 'https://avatars.githubusercontent.com/u/88006241?v=4'),
  ].obs;
}
