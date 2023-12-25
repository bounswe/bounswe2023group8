import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/tag_suggestion.dart';
import 'package:mobile/data/models/wiki_tag.dart';
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
  RxMap<int, List<bool>> isVotes = <int, List<bool>>{}.obs;

  RxList<IaRequest> followRequests = <IaRequest>[].obs;
  RxList<TagSuggestion> tagSuggestions = <TagSuggestion>[].obs;

  RxList<WikiTag> searchTagResults = <WikiTag>[].obs;
  RxList<WikiTag> selectedTags = <WikiTag>[].obs;

  var tagQuery = ''.obs;

  final ImagePicker _picker = ImagePicker();

  var searchIas = <InterestArea>[].obs;

  var hasAccess = false.obs;

  var isFollower = false.obs;

  var searchQuery = ''.obs;

  var requestSent = false.obs;

  var viewState = BunchViewState.main.obs;

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

  void onChangeState(BunchViewState state) {
    viewState.value = state;
  }

  bool get isOwner =>
      interestArea.creatorId != null &&
      interestArea.creatorId == bottomNavigationController.userId;

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
    final res = await iaProvider.getIa(
        id: interestArea.id, token: bottomNavigationController.token);
    if (res != null) {
      interestArea = res;
    }
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
        followRequests.value = await iaProvider.getIaRequests(
                id: interestArea.id, token: bottomNavigationController.token) ??
            followRequests;
        tagSuggestions.value = await iaProvider.getTagSuggestions(
                entityId: interestArea.id,
                entityType: 'INTEREST_AREA',
                token: bottomNavigationController.token) ??
            tagSuggestions;
      }
      posts.value = await iaProvider.getPosts(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      nestedIas.value = await iaProvider.getNestedIas(
              id: interestArea.id, token: bottomNavigationController.token) ??
          [];
      await getVotedInfo();
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

  void acceptTagSuggestion(int tagSuggestionId) async {
    try {
      final res = await iaProvider.acceptTagSuggestion(
          tagSuggestionId: tagSuggestionId,
          token: bottomNavigationController.token);
      if (res) {
        tagSuggestions.removeWhere((element) => element.id == tagSuggestionId);
        routeLoading.value = true;
        fetchIa();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void rejectTagSuggestion(int tagSuggestionId) async {
    try {
      final res = await iaProvider.rejectTagSuggestion(
          tagSuggestionId: tagSuggestionId,
          token: bottomNavigationController.token);
      if (res) {
        tagSuggestions.removeWhere((element) => element.id == tagSuggestionId);
      }
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

  Future getVotedInfo() async {
    try {
      for (var post in posts) {
        final hasUpvoted = await iaProvider.hasUpVoted(
            token: bottomNavigationController.token,
            postId: post.id,
            userId: bottomNavigationController.userId);
        final hasDownvoted = await iaProvider.hasDownVoted(
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

  void showTagSuggestionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return Padding(
            padding: const EdgeInsets.only(
                right: 8.0, left: 8.0, top: 12.0, bottom: 8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onChanged: onChangeTagQuery,
                        decoration: InputDecoration(
                          hintText: 'Search tags',
                          contentPadding: const EdgeInsets.only(left: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ThemePalette.dark,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ThemePalette.dark,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchController.clear();
                        searchTagResults.clear();
                        Get.back();
                      },
                      icon: const Icon(Icons.clear),
                    ),
                  ],
                ),
                Expanded(
                    child: ListView.separated(
                  itemBuilder: (context, index) {
                    bool selected = selectedTags.any(
                        (element) => element.id == searchTagResults[index].id);
                    return ListTile(
                      title: Text(searchTagResults[index].label),
                      trailing: selected
                          ? const Icon(Icons.check, color: Colors.green)
                          : const SizedBox.shrink(),
                      onTap: () {
                        if (selected) {
                          selectedTags.removeWhere((element) =>
                              element.id == searchTagResults[index].id);
                        } else {
                          selectedTags.add(searchTagResults[index]);
                        }
                        searchTagResults.refresh();
                      },
                    );
                  },
                  separatorBuilder: (context, ind) {
                    return const Divider();
                  },
                  itemCount: searchTagResults.length,
                )),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemePalette.main,
                    primary: ThemePalette.main,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    if (selectedTags.isNotEmpty) {
                      suggestTag();
                    }
                  },
                  child: const Text(
                    'Suggest',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }

  void suggestTag() async {
    try {
      final res = await iaProvider.suggestTag(
          token: bottomNavigationController.token,
          tags: selectedTags.map((e) => e.id).toList(),
          entityType: 'INTEREST_AREA',
          entityId: interestArea.id);
      if (res) {
        Get.snackbar(
          'Success',
          'Tag suggested successfully',
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

  void onChangeTagQuery(String value) {
    searchTagResults.clear();
    tagQuery.value = value;
    if (value == '') {
      return;
    }
    searchTags();
  }

  void searchTags() async {
    try {
      final tags = await iaProvider.searchTags(
          key: tagQuery.value, token: bottomNavigationController.token);
      if (tags != null) {
        searchTagResults.value = tags;
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
