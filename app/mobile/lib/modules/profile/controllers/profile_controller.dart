import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/user_profile.dart';
import 'package:mobile/data/widgets/user_list_dialog.dart';
import 'package:mobile/modules/profile/providers/profile_provider.dart';

import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class ProfileController extends GetxController {
  final bottomNavController = Get.find<BottomNavigationController>();
  final profileProvider = Get.find<ProfileProvider>();

  int userId = Get.arguments['userId'];

  var routeLoading = true.obs;
  late final UserProfile userProfile;

  var followers = <EnigmaUser>[].obs;
  var followings = <EnigmaUser>[].obs;
  var posts = <Spot>[].obs;
  var ias = <InterestArea>[].obs;

  var isFollowing = false.obs;

  void fetchUser() async {
    try {
      final profile = await profileProvider.getProfilePage(
          id: userId, token: bottomNavController.token);
      if (profile != null) {
        userProfile = profile;
        posts.value = await profileProvider.getPosts(
                id: userId, token: bottomNavController.token) ??
            [];
        ias.value = await profileProvider.getIas(
                id: userId, token: bottomNavController.token) ??
            [];
        fetchFollowers();
        fetchFollowings();
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
    Get.toNamed(Routes.interestArea, arguments: {
      'interestArea': ia,
      'isOwner': userId == bottomNavController.userId
    });
  }

  void fetchFollowers() async {
    try {
      followers.value = await profileProvider.getFollowers(
              id: userId, token: bottomNavController.token) ??
          followers;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void fetchFollowings() async {
    try {
      followings.value = await profileProvider.getFollowings(
              id: userId, token: bottomNavController.token) ??
          followings;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void followUser(int targetId) async {
    try {
      final res = await profileProvider.followUser(
          id: targetId, token: bottomNavController.token);
      if (res) {
        if (userId != bottomNavController.userId) {
          isFollowing.value = true;
          bottomNavController.followUser();
          fetchFollowers();
        } else {
          fetchFollowings();
          bottomNavController.followUser();
        }
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowUser(int targetId) async {
    try {
      final res = await profileProvider.unfollowUser(
          id: targetId, token: bottomNavController.token);
      if (res) {
        if (userId != bottomNavController.userId) {
          isFollowing.value = false;
          bottomNavController.unfollowUser(userId);
          followers.removeWhere(
              (element) => element.id == bottomNavController.userId);
        } else {
          followings.removeWhere((element) => element.id == targetId);
          bottomNavController.unfollowUser(targetId);
        }
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void upvotePost(int postId) async {
    try {
      final hasUpvoted = await profileProvider.hasUpVoted(
          token: bottomNavController.token,
          postId: postId,
          userId: bottomNavController.userId);

      bool res = false;

      if (hasUpvoted) {
        res = await profileProvider.unvotePost(
            token: bottomNavController.token, postId: postId);
      } else {
        res = await profileProvider.upvotePost(
            token: bottomNavController.token, postId: postId);
      }

      if (res) {
        posts.value = await profileProvider.getPosts(
                id: userId, token: bottomNavController.token) ??
            posts;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void downvotePost(int postId) async {
    try {
      final hasDownvoted = await profileProvider.hasDownVoted(
          token: bottomNavController.token,
          postId: postId,
          userId: bottomNavController.userId);

      bool res = false;

      if (hasDownvoted) {
        res = await profileProvider.unvotePost(
            token: bottomNavController.token, postId: postId);
      } else {
        res = await profileProvider.downvotePost(
            token: bottomNavController.token, postId: postId);
      }

      if (res) {
        posts.value = await profileProvider.getPosts(
                id: userId, token: bottomNavController.token) ??
            posts;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showUpVotes(int postId) async {
    try {
      final users = await profileProvider.getUpvotedUsers(
          token: bottomNavController.token, postId: postId);
      if (users.isNotEmpty) {
        Get.dialog(UserListDialog(
          title: 'Upvoters',
          users: users,
        ));
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showDownVotes(int postId) async {
    try {
      final users = await profileProvider.getDownvotedUsers(
          token: bottomNavController.token, postId: postId);
      if (users.isNotEmpty) {
        Get.dialog(UserListDialog(
          title: 'Downvoters',
          users: users,
        ));
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUser();
    isFollowing.value = bottomNavController.isUserFollowing(userId);
  }

  @override
  void onClose() {}
}
