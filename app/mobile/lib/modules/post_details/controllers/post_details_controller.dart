import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/post_details/providers/post_details_provider.dart';
import 'package:mobile/modules/post_details/views/location_view.dart';

class PostDetailsController extends GetxController {
  Spot post = Get.arguments['post'];

  final bool visitor = false; //Get.arguments['visitor'];

  var isFollowing = false.obs;

  BottomNavigationController? bottomNavController;

  final postDetailsProvider = Get.find<PostDetailsProvider>();
  var routeLoading = false.obs;

  void changePost(Spot argpost) {
    routeLoading.value = true;
    post = argpost;
    routeLoading.value = false;
  }

  bool showFollowButton() {
    return !visitor &&
        post.enigmaUser.id != bottomNavController!.userId &&
        !isFollowing.value;
  }

  bool showUnfollowButton() {
    return !visitor &&
        post.enigmaUser.id != bottomNavController!.userId &&
        isFollowing.value;
  }

  void followUser() async {
    try {
      final res = await postDetailsProvider.followUser(
          id: post.enigmaUser.id, token: bottomNavController!.token);
      if (res) {
        isFollowing.value = true;
        bottomNavController!.followUser();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowUser() async {
    try {
      final res = await postDetailsProvider.unfollowUser(
          id: post.enigmaUser.id, token: bottomNavController!.token);
      if (res) {
        isFollowing.value = false;
        bottomNavController!.unfollowUser(post.enigmaUser.id);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showLocation() {
    // TO AVOID MAP API PRICING, IT IS DISABLED FOR NOW

    return;
    Get.to(() => LocationView(
          currentLatLng:
              LatLng(post.geolocation.latitude, post.geolocation.longitude),
        ));
  }

  void navigateToEditPost() {
    showLocation();
    //Get.toNamed(Routes.editPost, arguments: {'spot': post});
  }

  @override
  void onInit() {
    super.onInit();
    try {
      bottomNavController = Get.find<BottomNavigationController>();
      isFollowing.value =
          bottomNavController!.isUserFollowing(post.enigmaUser.id);
    } catch (e) {
      bottomNavController = null;
    }


  }
}
