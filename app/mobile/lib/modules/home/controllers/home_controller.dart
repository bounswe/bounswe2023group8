import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/widgets/user_list_dialog.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/home/providers/home_provider.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  RxList<Spot> posts = <Spot>[].obs;

  final routeLoading = true.obs;

  final bottomNavigationController = Get.find<BottomNavigationController>();
  final homeProvider = Get.find<HomeProvider>();

  var searchQuery = ''.obs;
  var searchPosts = <Spot>[].obs;
  var searchUsers = <EnigmaUser>[].obs;
  var searchIas = <InterestArea>[].obs;

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void onSearchQueryChanged(String value) {
    searchQuery.value = value;
    searchPosts.clear();
    searchUsers.clear();
    searchIas.clear();
    if (value.isNotEmpty) {
      search();
    } else {
      fetchData();
    }
  }

  void search() async {
    try {
      final searchMap = await homeProvider.globalSearch(
          searchKey: searchQuery.value,
          token: bottomNavigationController.token);
      if (searchMap != null) {
        searchPosts.value = searchMap['posts'] ?? [];
        searchUsers.value = searchMap['users'] ?? [];
        searchIas.value = searchMap['interestAreas'] ?? [];
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToProfile(int id) {
    Get.toNamed(Routes.profile, arguments: {'userId': id});
  }

  void navigateToIa(InterestArea ia) {
    Get.toNamed(Routes.interestArea, arguments: {'interestArea': ia});
  }

  void fetchData() async {
    try {
      posts.value = await homeProvider.getHomePage(
              token: bottomNavigationController.token) ??
          [];
      routeLoading.value = false;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void upvotePost(int postId) async {
    try {
      final hasUpvoted = await homeProvider.hasUpVoted(
          token: bottomNavigationController.token,
          postId: postId,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasUpvoted) {
        res = await homeProvider.unvotePost(
            token: bottomNavigationController.token, postId: postId);
      } else {
        res = await homeProvider.upvotePost(
            token: bottomNavigationController.token, postId: postId);
      }

      if (res) {
        fetchData();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void downvotePost(int postId) async {
    try {
      final hasDownvoted = await homeProvider.hasDownVoted(
          token: bottomNavigationController.token,
          postId: postId,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasDownvoted) {
        res = await homeProvider.unvotePost(
            token: bottomNavigationController.token, postId: postId);
      } else {
        res = await homeProvider.downvotePost(
            token: bottomNavigationController.token, postId: postId);
      }

      if (res) {
        fetchData();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showVotes(int postId) async {
    try {
      final upvotedUsers = await homeProvider.getUpvotedUsers(
          token: bottomNavigationController.token, postId: postId);
      final downvotedUsers = await homeProvider.getDownvotedUsers(
          token: bottomNavigationController.token, postId: postId);

      Get.dialog(
        UserListDialog(
          title: 'Votes',
          sections: const ['Upvoters', 'Downvoters'],
          users: [upvotedUsers, downvotedUsers],
          isRemovable: const [false, false],
        ),
      );
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  /*void showDownVotes(int postId) async {
    try {
      final users = await homeProvider.getDownvotedUsers(
          token: bottomNavigationController.token, postId: postId);
      if (users.isNotEmpty) {
        Get.dialog(UserListDialog(
          title: 'Downvoters',
          users: users,
        ));
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }*/

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}
}
