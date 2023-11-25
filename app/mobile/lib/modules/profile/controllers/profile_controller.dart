import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/user_profile.dart';
import 'package:mobile/modules/profile/providers/profile_provider.dart';

import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class ProfileController extends GetxController {
  final bottomNavController = Get.find<BottomNavigationController>();
  final profileProvider = Get.find<ProfileProvider>();

  var routeLoading = true.obs;
  late final UserProfile userProfile;

  var followers = <EnigmaUser>[].obs;
  var followings = <EnigmaUser>[].obs;
  var posts = <Spot>[].obs;
  var ias = <InterestArea>[].obs;

  void fetchUser() async {
    try {
      final profile = await profileProvider.getProfilePage(
          id: bottomNavController.userId, token: bottomNavController.token);
      if (profile != null) {
        userProfile = profile;
        posts.value = await profileProvider.getPosts(
                id: bottomNavController.userId,
                token: bottomNavController.token) ??
            [];
        ias.value = await profileProvider.getIas(
                id: bottomNavController.userId,
                token: bottomNavController.token) ??
            [];
        followers.value = await profileProvider.getFollowers(
                id: bottomNavController.userId,
                token: bottomNavController.token) ??
            [];
        followings.value = await profileProvider.getFollowings(
                id: bottomNavController.userId,
                token: bottomNavController.token) ??
            [];
        routeLoading.value = false;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void navigateToIa(InterestArea ia) {
    Get.toNamed(Routes.interestArea, arguments: {'interestArea': ia});
  }

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  @override
  void onClose() {}
}
