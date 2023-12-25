import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/user_profile.dart';
import 'package:mobile/data/widgets/report_dialog.dart';
import 'package:mobile/data/widgets/user_list_dialog.dart';
import 'package:mobile/modules/profile/providers/profile_provider.dart';

import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';

class ProfileController extends GetxController {
  final bottomNavigationController = Get.find<BottomNavigationController>();
  final profileProvider = Get.find<ProfileProvider>();

  int userId = Get.arguments['userId'];

  var routeLoading = true.obs;
  late UserProfile userProfile;

  var followers = <EnigmaUser>[].obs;
  var followings = <EnigmaUser>[].obs;
  var posts = <Spot>[].obs;
  var ias = <InterestArea>[].obs;
  RxMap<int, List<bool>> isVotes = <int, List<bool>>{}.obs;

  final ImagePicker _picker = ImagePicker();

  var isFollowing = false.obs;

  void fetchUserProfile() async {
    try {
      final profile = await profileProvider.getProfilePage(
          id: userId, token: bottomNavigationController.token);
      if (profile != null) {
        userProfile = profile;
        posts.value = await profileProvider.getPosts(
                id: userId, token: bottomNavigationController.token) ??
            [];
        ias.value = await profileProvider.getIas(
                id: userId, token: bottomNavigationController.token) ??
            [];
        fetchFollowers();
        fetchFollowings();
        await getVotedInfo();
        routeLoading.value = false;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void fetchProfile() async {
    try {
      final res = await profileProvider.getProfilePage(
          id: userId, token: bottomNavigationController.token);
      if (res != null) {
        userProfile = res;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
    routeLoading.value = false;
  }

  void uploadImage() async {
    try {
      _picker.pickImage(source: ImageSource.gallery).then((value) async {
        if (value != null) {
          routeLoading.value = true;
          final res = await profileProvider.uploadImage(
              token: bottomNavigationController.token, image: value.path);
          if (res) {
            fetchProfile();
          }
        }
      });
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void deletePicture() async {
    try {
      routeLoading.value = true;
      final res = await profileProvider.deleteImage(
          token: bottomNavigationController.token);
      if (res) {
        fetchProfile();
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
    });
  }

  void fetchFollowers() async {
    try {
      followers.value = await profileProvider.getFollowers(
              id: userId, token: bottomNavigationController.token) ??
          followers;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void fetchFollowings() async {
    try {
      followings.value = await profileProvider.getFollowings(
              id: userId, token: bottomNavigationController.token) ??
          followings;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void followUser(int targetId) async {
    try {
      final res = await profileProvider.followUser(
          id: targetId, token: bottomNavigationController.token);
      if (res) {
        if (userId != bottomNavigationController.userId) {
          isFollowing.value = true;
          bottomNavigationController.followUser();
          fetchFollowers();
        } else {
          fetchFollowings();
          bottomNavigationController.followUser();
        }
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowUser(int targetId) async {
    try {
      final res = await profileProvider.unfollowUser(
          id: targetId, token: bottomNavigationController.token);
      if (res) {
        if (userId != bottomNavigationController.userId) {
          isFollowing.value = false;
          bottomNavigationController.unfollowUser(userId);
          followers.removeWhere(
              (element) => element.id == bottomNavigationController.userId);
        } else {
          followings.removeWhere((element) => element.id == targetId);
          bottomNavigationController.unfollowUser(targetId);
        }
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showFollowPopUp(int section) {
    Get.dialog(
      UserListDialog(
        title: '@${userProfile.username}',
        sections: const ['Followers', 'Followings'],
        defaultSection: section,
        users: [followers, followings],
        isRemovable: bottomNavigationController.userId == userProfile.id
            ? [false, true]
            : [false, false],
        removeTexts: const ['Remove', 'Unfollow'],
        onRemove: [(temp) => {}, unfollowUser],
        redirectToProfile: false,
      ),
    );
  }

  void upvotePost(int postId) async {
    try {
      final hasUpvoted = await profileProvider.hasUpVoted(
          token: bottomNavigationController.token,
          postId: postId,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasUpvoted) {
        res = await profileProvider.unvotePost(
            token: bottomNavigationController.token, postId: postId);
      } else {
        res = await profileProvider.upvotePost(
            token: bottomNavigationController.token, postId: postId);
      }

      if (res) {
        posts.value = await profileProvider.getPosts(
                id: userId, token: bottomNavigationController.token) ??
            posts;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void downvotePost(int postId) async {
    try {
      final hasDownvoted = await profileProvider.hasDownVoted(
          token: bottomNavigationController.token,
          postId: postId,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasDownvoted) {
        res = await profileProvider.unvotePost(
            token: bottomNavigationController.token, postId: postId);
      } else {
        res = await profileProvider.downvotePost(
            token: bottomNavigationController.token, postId: postId);
      }

      if (res) {
        posts.value = await profileProvider.getPosts(
                id: userId, token: bottomNavigationController.token) ??
            posts;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  Future getVotedInfo() async {
    try {
      for (var post in posts) {
        final hasUpvoted = await profileProvider.hasUpVoted(
            token: bottomNavigationController.token,
            postId: post.id,
            userId: bottomNavigationController.userId);
        final hasDownvoted = await profileProvider.hasDownVoted(
            token: bottomNavigationController.token,
            postId: post.id,
            userId: bottomNavigationController.userId);
        isVotes[post.id] = [hasUpvoted, hasDownvoted];
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
      rethrow;
    }
  }

  void showVotes(int postId) async {
    try {
      final upvotedUsers = await profileProvider.getUpvotedUsers(
          token: bottomNavigationController.token, postId: postId);
      final downvotedUsers = await profileProvider.getDownvotedUsers(
          token: bottomNavigationController.token, postId: postId);

      Get.dialog(UserListDialog(
        title: 'Votes',
        sections: const ['Upvoters', 'Downvoters'],
        sectionColors: [ThemePalette.positive, ThemePalette.negative],
        sectionTextColors: [ThemePalette.light, ThemePalette.light],
        users: [upvotedUsers, downvotedUsers],
        isRemovable: const [false, false],
        redirectToProfile: false,
      ));
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showReportUser() {
    Get.dialog(ReportDialog(
        title: 'Report User',
        onReport: (reason) => onReport(userId, reason, 'user')));
  }

  void onReport(int postId, String reason, String entityType) async {
    try {
      final res = await profileProvider.report(
          token: bottomNavigationController.token,
          entityId: postId,
          entityType: entityType,
          reason: reason);
      if (res) {
        Get.snackbar(
          'Success',
          'Reported successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.brown,
          borderRadius: 0,
          colorText: Colors.white,
          margin: EdgeInsets.zero,
        );
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
    isFollowing.value = bottomNavigationController.isUserFollowing(userId);
  }

  @override
  void onClose() {}
}
