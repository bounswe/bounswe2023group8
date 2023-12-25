import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/annotation_mode.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/tag_suggestion.dart';
import 'package:mobile/data/models/wiki_tag.dart';
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

  var tagSuggestionView = false.obs;

  var isFollowing = false.obs;

  Rx<TextSelection> annotationSelection =
      TextSelection(baseOffset: 0, extentOffset: 0).obs;

  final annotationController = TextEditingController();

  RxList<TagSuggestion> tagSuggestions = <TagSuggestion>[].obs;

  RxList<CommentModel> comments = <CommentModel>[].obs;

  RxList<AnnotationModel> annotations = <AnnotationModel>[].obs;

  RxList<WikiTag> searchTagResults = <WikiTag>[].obs;
  RxList<WikiTag> selectedTags = <WikiTag>[].obs;
  RxString tagQuery = ''.obs;

  BottomNavigationController bottomNavigationController =
      Get.find<BottomNavigationController>();

  late Rx<Spot> post;

  final postDetailsProvider = Get.find<PostDetailsProvider>();
  var routeLoading = true.obs;

  var showAnnotations = false.obs;

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

  void showAnnotation() {
    showAnnotations.value = !showAnnotations.value;
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
      final tags = await postDetailsProvider.searchTags(
          key: tagQuery.value, token: bottomNavigationController.token);
      if (tags != null) {
        searchTagResults.value = tags;
      }
    } catch (e) {
      log('');
    }
  }

  void onAnnotationSelectionChange(
      TextSelection selection, SelectionChangedCause? cause) {
    annotationSelection.value = selection;
  }

  void onAnnotate() async {
    try {
      try {
        final res = await postDetailsProvider.createAnnotationContainer(
            token: bottomNavigationController.token, postId: post.value.id);
        if (res) {
          final res = await postDetailsProvider.createAnnotation(
              token: bottomNavigationController.token,
              user: bottomNavigationController.signedInUser!,
              text:
                  '${annotationSelection.value.baseOffset}-${annotationSelection.value.extentOffset}',
              comment: annotationController.text,
              postId: post.value.id);

          if (res) {
            annotationController.clear();
            Get.snackbar(
              'Success',
              'Annotation added successfully',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.brown,
              borderRadius: 0,
              colorText: Colors.white,
              margin: EdgeInsets.zero,
            );
          }
        }
      } catch (e) {
        final res = await postDetailsProvider.createAnnotation(
            token: bottomNavigationController.token,
            user: bottomNavigationController.signedInUser!,
            text:
                '${annotationSelection.value.baseOffset}-${annotationSelection.value.extentOffset}',
            comment: annotationController.text,
            postId: post.value.id);

        if (res) {
          annotationController.clear();
          fetchAnnotations();
          Get.snackbar(
            'Success',
            'Annotation added successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.brown,
            borderRadius: 0,
            colorText: Colors.white,
            margin: EdgeInsets.zero,
          );
        }
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void acceptTagSuggestion(int tagSuggestionId) async {
    try {
      final res = await postDetailsProvider.acceptTagSuggestion(
          tagSuggestionId: tagSuggestionId,
          token: bottomNavigationController.token);
      if (res) {
        tagSuggestions.removeWhere((element) => element.id == tagSuggestionId);
        post.value = await postDetailsProvider.getPostById(
                id: post.value.id, token: bottomNavigationController.token) ??
            post.value;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void rejectTagSuggestion(int tagSuggestionId) async {
    try {
      final res = await postDetailsProvider.rejectTagSuggestion(
          tagSuggestionId: tagSuggestionId,
          token: bottomNavigationController.token);
      if (res) {
        tagSuggestions.removeWhere((element) => element.id == tagSuggestionId);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void suggestTag() async {
    try {
      final res = await postDetailsProvider.suggestTag(
          token: bottomNavigationController.token,
          tags: selectedTags.map((e) => e.id).toList(),
          entityType: 'POST',
          entityId: post.value.id);
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

  void fetchTagSuggestions() async {
    try {
      tagSuggestions.value = await postDetailsProvider.getTagSuggestions(
              entityId: post.value.id,
              entityType: 'POST',
              token: bottomNavigationController.token) ??
          tagSuggestions;
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void toggleTagSuggestionView() {
    tagSuggestionView.value = !tagSuggestionView.value;
  }

  void fetchAnnotations() async {
    try {
      annotations.value = await postDetailsProvider.getAnnotations(
              token: bottomNavigationController.token, postId: post.value.id) ??
          annotations;
    } catch (e) {}
  }

  void deleteAnnotation(AnnotationModel annotation) async {
    try {
      final res = await postDetailsProvider.deleteAnnotation(
          postId: post.value.id,
          token: bottomNavigationController.token,
          annotationId: annotation.id);
      if (res) {
        annotations.removeWhere((element) => element.id == annotation.id);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
    isFollowing.value =
        bottomNavigationController.isUserFollowing(postArg.enigmaUser.id);
    post = postArg.obs;
    fetchComments();
    if (post.value.enigmaUser.id == bottomNavigationController.userId) {
      fetchTagSuggestions();
    }
    fetchAnnotations();
  }
}
