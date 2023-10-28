import 'package:get/get.dart';
import 'package:mobile/data/models/user_model.dart';

class FollowersController extends GetxController {
  final followers = <User>[
    User(name: 'Begüm Yivli', username: '@begum', profileImage: 'assets/icons/begumpp.jpeg'),
  ].obs;
}