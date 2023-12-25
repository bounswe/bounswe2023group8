import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
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
  RxMap<int, List<bool>> isVotes = <int, List<bool>>{}.obs;

  final routeLoading = true.obs;

  final bottomNavigationController = Get.find<BottomNavigationController>();
  final homeProvider = Get.find<HomeProvider>();

  var searchQuery = ''.obs;
  var searchPosts = <Spot>[].obs;
  var searchUsers = <EnigmaUser>[].obs;
  var searchIas = <InterestArea>[].obs;

  // Sort posts by the newest first
  void sortByDate() {
    posts.sort((a, b) => b.createTime.compareTo(a.createTime));
    posts.refresh();
  }

  // Sort posts by the top votes
  void sortByTop() {
    posts.sort((a, b) {
      int aVotes = a.upvoteCount - a.downvoteCount;
      int bVotes = b.upvoteCount - b.downvoteCount;
      return bVotes.compareTo(aVotes);
    });
    posts.refresh();
  }

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
      await getVotedInfo();
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
        posts.value = await homeProvider.getHomePage(
                token: bottomNavigationController.token) ??
            [];
        search();
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
        posts.value = await homeProvider.getHomePage(
                token: bottomNavigationController.token) ??
            [];
        search();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  Future getVotedInfo() async {
    try {
      for (var post in posts) {
        final hasUpvoted = await homeProvider.hasUpVoted(
            token: bottomNavigationController.token,
            postId: post.id,
            userId: bottomNavigationController.userId);
        final hasDownvoted = await homeProvider.hasDownVoted(
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
      final upvotedUsers = await homeProvider.getUpvotedUsers(
          token: bottomNavigationController.token, postId: postId);
      final downvotedUsers = await homeProvider.getDownvotedUsers(
          token: bottomNavigationController.token, postId: postId);

      Get.dialog(
        UserListDialog(
          title: 'Votes',
          sections: const ['Upvoters', 'Downvoters'],
          sectionColors: [ThemePalette.positive, ThemePalette.negative],
          sectionTextColors: [ThemePalette.light, ThemePalette.light],
          users: [upvotedUsers, downvotedUsers],
          isRemovable: const [false, false],
        ),
      );
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {}
}
