import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/newIa/bindings/new_ia_binding.dart';
import 'package:mobile/modules/newIa/views/new_ia_view.dart';
import 'package:mobile/modules/newPost/bindings/new_post_binding.dart';
import 'package:mobile/modules/newPost/views/new_post_view.dart';
import 'package:mobile/modules/profile/bindings/profile_binding.dart';
import 'package:mobile/modules/profile/views/profile_view.dart';
import 'package:mobile/modules/settings/bindings/settings_binding.dart';
import 'package:mobile/modules/settings/views/settings_view.dart';

import '../../../data/models/user_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 1.obs;

  final String token = Get.arguments['token'];


  final UserModel signedInUser = const UserModel(
    id: 1001,
    name: 'Meriç Keskin',
    username: 'marcolphin',
    userProfileImage:
        'https://avatars.githubusercontent.com/u/88164767?s=400&u=09da0dbc9d0ee0246d7492d938a20dbc4b2be7f1&v=4',
    iaIds: [1, 2, 3, 4, 5],
    followerCount: 3,
    followingCount: 3,
    allTimeLikes: 20,
    allTimeDislikes: 5,
  );

  final pages = <String>[
    Routes.home,
    Routes.profile,
    Routes.newPost,
    Routes.newIa,
    Routes.settings
  ];

  void changePage(int index) {
    if (currentIndex.value == index) {
      return;
    }
    currentIndex.value = index;
    Get.offAllNamed(
      pages[index],
      id: 1,
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.home) {
      return GetPageRoute(
        settings: settings,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.noTransition,
      );
    }

    if (settings.name == Routes.profile) {
      return GetPageRoute(
        settings: settings,
        page: () => const ProfileView(),
        binding: ProfileBinding(),
        transition: Transition.noTransition,
      );
    }

    if (settings.name == Routes.newPost) {
      return GetPageRoute(
        settings: settings,
        page: () => NewPostView(),
        binding: NewPostBinding(),
        transition: Transition.noTransition,
      );
    }

    if (settings.name == Routes.newIa) {
      return GetPageRoute(
        settings: settings,
        page: () => const NewIaView(),
        binding: NewIaBinding(),
        transition: Transition.noTransition,
      );
    }
    if (settings.name == Routes.settings) {
      return GetPageRoute(
        settings: settings,
        page: () => const SettingsView(),
        binding: SettingsBinding(),
        transition: Transition.noTransition,
      );
    }
    return null;
  }

  @override
  void onInit() async {
    super.onInit();
  }
}
