import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/modules/bottom_navigation/providers/bottom_nav_provider.dart';
import 'package:mobile/modules/newIa/bindings/new_ia_binding.dart';
import 'package:mobile/modules/newIa/views/new_ia_view.dart';
import 'package:mobile/modules/newPost/bindings/new_post_binding.dart';
import 'package:mobile/modules/newPost/views/new_post_view.dart';
import 'package:mobile/modules/profile/bindings/profile_binding.dart';
import 'package:mobile/modules/profile/views/profile_view.dart';
import 'package:mobile/modules/settings/bindings/settings_binding.dart';
import 'package:mobile/modules/settings/views/settings_view.dart';

import '../../../routes/app_pages.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';

class BottomNavigationController extends GetxController {
  var currentIndex = 0.obs;

  final String token = Get.arguments['token'];
  final int userId = Get.arguments['userId'];

  EnigmaUser? signedInUser;

  List<EnigmaUser> followingUsers = <EnigmaUser>[];
  List<InterestArea> followingIas = <InterestArea>[];

  final bottomNavProvider = Get.find<BottomNavProvider>();

  bool isIaFollowing(int id) {
    return followingIas.any((element) => element.id == id);
  }

  bool isUserFollowing(int id) {
    return followingUsers.any((element) => element.id == id);
  }

  void followIa(InterestArea ia) async {
    followingIas.add(ia);
  }

  void unfollowIa(InterestArea ia) async {
    followingIas.removeWhere((element) => element.id == ia.id);
  }

  void followUser() async {
    fetchData();
  }

  void getUser() async {
    try {
      final res = await bottomNavProvider.getUser(token: token, userId: userId);
      if (res != null) {
        signedInUser = res;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowUser(int id) async {
    followingUsers.removeWhere((element) => element.id == id);
  }

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
        page: () => const NewPostView(),
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

  void fetchData() async {
    try {
      followingUsers =
          await bottomNavProvider.getFollowings(id: userId, token: token) ??
              followingUsers;
      followingIas = await bottomNavProvider.getIas(id: userId, token: token) ??
          followingIas;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() async {
    fetchData();
    getUser();
    super.onInit();
  }
}
