import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/widgets/report_dialog.dart';
import 'package:mobile/data/widgets/user_list_dialog.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/post_details/models/comment.dart';
import 'package:mobile/modules/post_details/providers/post_details_provider.dart';
import 'package:mobile/modules/post_details/views/location_view.dart';
import 'package:mobile/routes/app_pages.dart';

class PostDetailsController extends GetxController {
  Spot postArg = Get.arguments['post'];

  final bool visitor = false; //Get.arguments['visitor'];

  var isFollowing = false.obs;

  RxList<CommentModel> comments = <CommentModel>[].obs;

  BottomNavigationController bottomNavigationController =
      Get.find<BottomNavigationController>();

  late Rx<Spot> post;

  final postDetailsProvider = Get.find<PostDetailsProvider>();
  var routeLoading = true.obs;

  final commentController = TextEditingController();

  bool showFollowButton() {
    return !visitor &&
        post.value.enigmaUser.id != bottomNavigationController.userId &&
        !isFollowing.value;
  }

  bool showUnfollowButton() {
    return !visitor &&
        post.value.enigmaUser.id != bottomNavigationController.userId &&
        isFollowing.value;
  }

  void followUser() async {
    try {
      final res = await postDetailsProvider.followUser(
          id: post.value.enigmaUser.id,
          token: bottomNavigationController.token);
      if (res) {
        isFollowing.value = true;
        bottomNavigationController.followUser();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowUser() async {
    try {
      final res = await postDetailsProvider.unfollowUser(
          id: post.value.enigmaUser.id,
          token: bottomNavigationController.token);
      if (res) {
        isFollowing.value = false;
        bottomNavigationController.unfollowUser(post.value.enigmaUser.id);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showLocation() {
    // TO AVOID MAP API PRICING, IT IS DISABLED FOR NOW

    return;
    Get.to(() => LocationView(
          currentLatLng: LatLng(post.value.geolocation.latitude,
              post.value.geolocation.longitude),
        ));
  }

  void navigateToEditPost() {
    Get.toNamed(Routes.editPost, arguments: {'spot': post.value});
  }

  void upvotePost() async {
    try {
      final hasUpvoted = await postDetailsProvider.hasUpVoted(
          token: bottomNavigationController.token,
          postId: post.value.id,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasUpvoted) {
        res = await postDetailsProvider.unvotePost(
            token: bottomNavigationController.token, postId: post.value.id);
      } else {
        res = await postDetailsProvider.upvotePost(
            token: bottomNavigationController.token, postId: post.value.id);
      }

      if (res) {
        post.value = await postDetailsProvider.getPostById(
                id: post.value.id, token: bottomNavigationController.token) ??
            post.value;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void downvotePost() async {
    try {
      final hasDownvoted = await postDetailsProvider.hasDownVoted(
          token: bottomNavigationController.token,
          postId: post.value.id,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasDownvoted) {
        res = await postDetailsProvider.unvotePost(
            token: bottomNavigationController.token, postId: post.value.id);
      } else {
        res = await postDetailsProvider.downvotePost(
            token: bottomNavigationController.token, postId: post.value.id);
      }

      if (res) {
        post.value = await postDetailsProvider.getPostById(
                id: post.value.id, token: bottomNavigationController.token) ??
            post.value;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showVotes(int section) async {
    try {
      final upvotedUsers = await postDetailsProvider.getUpvotedUsers(
          token: bottomNavigationController.token, postId: post.value.id);
      final downvotedUsers = await postDetailsProvider.getDownvotedUsers(
          token: bottomNavigationController.token, postId: post.value.id);

      Get.dialog(UserListDialog(
        title: 'Votes',
        sections: const ['Upvoters', 'Downvoters'],
        defaultSection: section,
        sectionColors: [ThemePalette.positive, ThemePalette.negative],
        sectionTextColors: [ThemePalette.light, ThemePalette.light],
        users: [upvotedUsers, downvotedUsers],
        isRemovable: const [false, false],
      ));
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showReportSpot() {
    Get.dialog(ReportDialog(
        title: 'Report Spot',
        onReport: (reason) => onReport(post.value.id, reason, 'post')));
  }

  void onReport(int postId, String reason, String entityType) async {
    try {
      final res = await postDetailsProvider.report(
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

  void fetchComments() async {
    try {
      comments.value = await postDetailsProvider.getPostComments(
              token: bottomNavigationController.token, postId: postArg.id) ??
          comments;
      routeLoading.value = false;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void makeComment() async {
    try {
      final res = await postDetailsProvider.comment(
          token: bottomNavigationController.token,
          postId: post.value.id,
          content: commentController.text);
      if (res) {
        commentController.clear();
        fetchComments();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void deleteComment(int commentId) async {
    try {
      final res = await postDetailsProvider.deleteComment(
          token: bottomNavigationController.token,
          postId: post.value.id,
          commentId: commentId);
      if (res) {
        fetchComments();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void startEditingComment(int commentId) {}

  @override
  void onInit() {
    super.onInit();
    isFollowing.value =
        bottomNavigationController.isUserFollowing(postArg.enigmaUser.id);
    post = postArg.obs;
    fetchComments();
  }
}
