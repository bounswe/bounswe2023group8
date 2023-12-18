import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/widgets/user_list_dialog.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/post_details/providers/post_details_provider.dart';
import 'package:mobile/modules/post_details/views/location_view.dart';

class PostDetailsController extends GetxController {
  Spot postArg = Get.arguments['post'];

  final bool visitor = false; //Get.arguments['visitor'];

  var isFollowing = false.obs;

  BottomNavigationController bottomNavController =
      Get.find<BottomNavigationController>();

  late Rx<Spot> post;

  final postDetailsProvider = Get.find<PostDetailsProvider>();
  var routeLoading = true.obs;

  bool showFollowButton() {
    return !visitor &&
        post.value.enigmaUser.id != bottomNavController.userId &&
        !isFollowing.value;
  }

  bool showUnfollowButton() {
    return !visitor &&
        post.value.enigmaUser.id != bottomNavController.userId &&
        isFollowing.value;
  }

  void followUser() async {
    try {
      final res = await postDetailsProvider.followUser(
          id: post.value.enigmaUser.id, token: bottomNavController.token);
      if (res) {
        isFollowing.value = true;
        bottomNavController.followUser();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowUser() async {
    try {
      final res = await postDetailsProvider.unfollowUser(
          id: post.value.enigmaUser.id, token: bottomNavController.token);
      if (res) {
        isFollowing.value = false;
        bottomNavController.unfollowUser(post.value.enigmaUser.id);
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
    showLocation();
    //Get.toNamed(Routes.editPost, arguments: {'spot': post});
  }

  void upvotePost() async {
    try {
      final hasUpvoted = await postDetailsProvider.hasUpVoted(
          token: bottomNavController.token,
          postId: post.value.id,
          userId: bottomNavController.userId);

      bool res = false;

      if (hasUpvoted) {
        res = await postDetailsProvider.unvotePost(
            token: bottomNavController.token, postId: post.value.id);
      } else {
        res = await postDetailsProvider.upvotePost(
            token: bottomNavController.token, postId: post.value.id);
      }

      if (res) {
        post.value = await postDetailsProvider.getPostById(
                id: post.value.id, token: bottomNavController.token) ??
            post.value;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void downvotePost() async {
    try {
      final hasDownvoted = await postDetailsProvider.hasDownVoted(
          token: bottomNavController.token,
          postId: post.value.id,
          userId: bottomNavController.userId);

      bool res = false;

      if (hasDownvoted) {
        res = await postDetailsProvider.unvotePost(
            token: bottomNavController.token, postId: post.value.id);
      } else {
        res = await postDetailsProvider.downvotePost(
            token: bottomNavController.token, postId: post.value.id);
      }

      if (res) {
        post.value = await postDetailsProvider.getPostById(
                id: post.value.id, token: bottomNavController.token) ??
            post.value;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showUpVotes() async {
    try {
      final users = await postDetailsProvider.getUpvotedUsers(
          token: bottomNavController.token, postId: post.value.id);
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

  void showDownVotes() async {
    try {
      final users = await postDetailsProvider.getDownvotedUsers(
          token: bottomNavController.token, postId: post.value.id);
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

    isFollowing.value =
        bottomNavController.isUserFollowing(postArg.enigmaUser.id);

    post = postArg.obs;
    routeLoading.value = false;
  }
}
