import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/widgets/report_dialog.dart';
import 'package:mobile/data/widgets/user_list_dialog.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/interestArea/models/ia_request.dart';
import 'package:mobile/modules/interestArea/providers/ia_provider.dart';

import '../../../routes/app_pages.dart';

enum BunchViewState { main, about, requests }

class InterestAreaController extends GetxController {
  final bottomNavigationController = Get.find<BottomNavigationController>();
  final iaProvider = Get.find<IaProvider>();

  var routeLoading = true.obs;
  InterestArea interestArea = Get.arguments['interestArea'];

  final TextEditingController searchController = TextEditingController();

  RxList<Spot> posts = <Spot>[].obs;
  RxList<InterestArea> nestedIas = <InterestArea>[].obs;

  RxList<IaRequest> followRequests = <IaRequest>[].obs;

  final ImagePicker _picker = ImagePicker();

  var searchIas = <InterestArea>[].obs;

  var hasAccess = false.obs;

  var isFollower = false.obs;

  var searchQuery = ''.obs;

  var requestSent = false.obs;

  var viewState = BunchViewState.main.obs;

  void onChangeState(BunchViewState state) {
    viewState.value = state;
  }

  bool get isOwner =>
      interestArea.enigmaUserId == bottomNavigationController.userId;

  void onSearchQueryChanged(String value) {
    searchQuery.value = value;
    searchIas.clear();
    if (value.isNotEmpty) {
      search();
    }
  }

  void search() async {
    try {
      final searchRes = await iaProvider.searchIas(
          key: searchQuery.value, token: bottomNavigationController.token);
      if (searchRes != null) {
        searchIas.value = searchRes;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToEdit() {
    Get.toNamed(Routes.editIa,
        arguments: {'interestArea': interestArea, 'nestedIas': nestedIas});
  }

  void navigateToPostDetails(Spot post) {
    Get.toNamed(Routes.postDetails,
        arguments: {'post': post, 'visitor': false});
  }

  void fetchData() async {
    if (interestArea.accessLevel == 'PUBLIC') {
      hasAccess.value = true;
    } else {
      hasAccess.value =
          isOwner || bottomNavigationController.isIaFollowing(interestArea.id);
    }

    if (!hasAccess.value) {
      routeLoading.value = false;
      return;
    }

    try {
      if (isOwner) {
        hasAccess.value = true;
        followRequests.value = await iaProvider.getIaRequests(
                id: interestArea.id, token: bottomNavigationController.token) ??
            followRequests;
      } else {
        hasAccess.value =
            bottomNavigationController.isIaFollowing(interestArea.id);
      }
      posts.value = await iaProvider.getPosts(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      nestedIas.value = await iaProvider.getNestedIas(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      fetchIa();
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void uploadImage() async {
    try {
      _picker.pickImage(source: ImageSource.gallery).then((value) async {
        if (value != null) {
          routeLoading.value = true;
          final res = await iaProvider.uploadImage(
              id: interestArea.id,
              token: bottomNavigationController.token,
              image: value.path);
          if (res) {
            fetchIa();
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
      final res = await iaProvider.deleteImage(
          id: interestArea.id, token: bottomNavigationController.token);
      if (res) {
        fetchIa();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void fetchIa() async {
    try {
      final res = await iaProvider.getIa(
          id: interestArea.id, token: bottomNavigationController.token);
      if (res != null) {
        interestArea = res;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
    routeLoading.value = false;
  }

  void acceptIaRequest(int requestId) async {
    try {
      final res = await iaProvider.acceptIaRequest(
          requestId: requestId, token: bottomNavigationController.token);
      if (res) {
        followRequests.removeWhere((element) => element.requestId == requestId);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void rejectIaRequest(int requestId) async {
    try {
      final res = await iaProvider.rejectIaRequest(
          requestId: requestId, token: bottomNavigationController.token);
      if (res) {
        followRequests.removeWhere((element) => element.requestId == requestId);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToIa(InterestArea ia) {
    routeLoading.value = true;
    searchQuery.value = '';
    searchIas.clear();
    searchController.clear();
    interestArea = ia;
    if (interestArea.accessLevel != 'PUBLIC') {
      viewState.value = BunchViewState.about;
    }
    fetchData();
  }

  void upvotePost(int postId) async {
    try {
      final hasUpvoted = await iaProvider.hasUpVoted(
          token: bottomNavigationController.token,
          postId: postId,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasUpvoted) {
        res = await iaProvider.unvotePost(
            token: bottomNavigationController.token, postId: postId);
      } else {
        res = await iaProvider.upvotePost(
            token: bottomNavigationController.token, postId: postId);
      }

      if (res) {
        posts.value = await iaProvider.getPosts(
                id: interestArea.id, token: bottomNavigationController.token) ??
            posts;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void downvotePost(int postId) async {
    try {
      final hasDownvoted = await iaProvider.hasDownVoted(
          token: bottomNavigationController.token,
          postId: postId,
          userId: bottomNavigationController.userId);

      bool res = false;

      if (hasDownvoted) {
        res = await iaProvider.unvotePost(
            token: bottomNavigationController.token, postId: postId);
      } else {
        res = await iaProvider.downvotePost(
            token: bottomNavigationController.token, postId: postId);
      }

      if (res) {
        posts.value = await iaProvider.getPosts(
                id: interestArea.id, token: bottomNavigationController.token) ??
            posts;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showVotes(int postId) async {
    try {
      final upvotedUsers = await iaProvider.getUpvotedUsers(
          token: bottomNavigationController.token, postId: postId);
      final downvotedUsers = await iaProvider.getDownvotedUsers(
          token: bottomNavigationController.token, postId: postId);

      Get.dialog(UserListDialog(
        title: 'Votes',
        sections: const ['Upvoters', 'Downvoters'],
        sectionColors: [ThemePalette.positive, ThemePalette.negative],
        sectionTextColors: [ThemePalette.light, ThemePalette.light],
        users: [upvotedUsers, downvotedUsers],
        isRemovable: const [false, false],
      ));
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  /*void showDownVotes(int postId) async {
    try {
      final users = await iaProvider.getDownvotedUsers(
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

  void followIa() async {
    if (requestSent.value) {
      return;
    }
    try {
      final res = await iaProvider.followIa(
          id: interestArea.id, token: bottomNavigationController.token);
      if (res) {
        if (interestArea.accessLevel != 'PUBLIC') {
          Get.snackbar(
            'Success',
            'Request sent successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.brown,
            borderRadius: 0,
            colorText: Colors.white,
            margin: EdgeInsets.zero,
          );
          requestSent.value = true;
          return;
        }
        isFollower.value = true;
        bottomNavigationController.followIa(interestArea);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void unfollowIa() async {
    try {
      final res = await iaProvider.unfollowIa(
          id: interestArea.id, token: bottomNavigationController.token);
      if (res) {
        isFollower.value = false;
        bottomNavigationController.unfollowIa(interestArea);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void showReportBunch() {
    Get.dialog(ReportDialog(
        title: 'Report Bunch',
        onReport: (reason) =>
            onReport(interestArea.id, reason, 'interest_area')));
  }

  void onReport(int postId, String reason, String entityType) async {
    try {
      final res = await iaProvider.report(
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
    fetchData();
    isFollower.value =
        bottomNavigationController.isIaFollowing(interestArea.id);
  }

  @override
  void onClose() {}
}
