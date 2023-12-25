import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/data/models/wiki_tag.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/editPost/providers/edit_post_provider.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';
import 'package:mobile/modules/newPost/views/select_location_view.dart';
import 'package:mobile/routes/app_pages.dart';

class EditPostController extends GetxController {
  Spot spot = Get.arguments['spot'];

  var label = 0.obs;

  var title = ''.obs;
  var content = ''.obs;
  var tagQuery = ''.obs;
  var sourceLink = ''.obs;

  var isAgeRestricted = false.obs;

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final sourceLinkController = TextEditingController();

  var createInProgress = false.obs;

  var address = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  Rx<InterestArea?> selectedIa = Rx<InterestArea?>(null);

  RxList<WikiTag> searchTagResults = <WikiTag>[].obs;
  RxList<WikiTag> selectedTags = <WikiTag>[].obs;

  RxList<InterestArea> iaResults = <InterestArea>[].obs;

  var publicationDate = ''.obs;

  final bottomNavController = Get.find<BottomNavigationController>();
  final editPostProvider = Get.find<EditPostProvider>();
  HomeController? homeController;

  @override
  void onInit() {
    super.onInit();
    fetchIa();
    initFields();
    try {
      homeController = Get.find<HomeController>();
    } catch (e) {
      homeController = null;
    }
  }

  get isFormValid =>
      title.value.isNotEmpty &&
      content.value.isNotEmpty &&
      selectedIa.value != null;

  void onChangeLabel(int value) {
    label.value = value;
  }

  void onChangeSourceLink(String value) {
    sourceLink.value = value;
  }

  void onChangeTitle(String value) {
    title.value = value;
  }

  void onChangeIsAgeRestricted() {
    isAgeRestricted.value = !isAgeRestricted.value;
  }

  void onChangeContent(String value) {
    content.value = value;
  }

  void onChangeTagQuery(String value) {
    searchTagResults.clear();
    tagQuery.value = value;
    if (value == '') {
      return;
    }
    searchTags();
  }

  void submitTagQuery(String val) {
    searchTagResults.clear();
  }

  void addTag(WikiTag tag) {
    selectedTags.add(tag);
    searchTagResults.remove(tag);
  }

  void removeTag(WikiTag tag) {
    selectedTags.remove(tag);
  }

  void removeIa() {
    selectedIa.value = null;
  }

  void fetchIa() async {
    try {
      final subIas = await editPostProvider.getIas(
          id: bottomNavController.userId, token: bottomNavController.token);
      if (subIas != null) {
        iaResults.value = subIas;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void searchTags() async {
    try {
      final tags = await editPostProvider.searchTags(
          key: tagQuery.value, token: bottomNavController.token);
      if (tags != null) {
        searchTagResults.value = tags;
      }
    } catch (e) {
      log('');
    }
  }

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      publicationDate.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void showIaSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: iaResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      final ia = iaResults[index];
                      return ListTile(
                        title: Text(ia.name),
                        onTap: () {
                          selectedIa.value = ia;
                          Navigator.pop(context);
                          // Handle the tap event on a suggestion
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLabelSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: const Text('Documentation'),
                      onTap: () {
                        label.value = 0;
                        Navigator.pop(context);
                        // Handle the tap event on a suggestion
                      },
                    ),
                    ListTile(
                      title: const Text('Learning'),
                      onTap: () {
                        label.value = 1;
                        Navigator.pop(context);
                        // Handle the tap event on a suggestion
                      },
                    ),
                    ListTile(
                      title: const Text('News'),
                      onTap: () {
                        label.value = 2;
                        Navigator.pop(context);
                        // Handle the tap event on a suggestion
                      },
                    ),
                    ListTile(
                      title: const Text('Research'),
                      onTap: () {
                        label.value = 3;
                        Navigator.pop(context);
                        // Handle the tap event on a suggestion
                      },
                    ),
                    ListTile(
                      title: const Text('Discussion'),
                      onTap: () {
                        label.value = 4;
                        Navigator.pop(context);
                        // Handle the tap event on a suggestion
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onDeletePost() async {
    try {
      final res = await editPostProvider.deletePost(
          id: spot.id, token: bottomNavController.token);
      if (res) {
        Get.until((route) => Get.currentRoute == Routes.bottomNavigation);
        homeController?.fetchData();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void navigateToSelectAddress() {
    Get.to(SelectLocationView());
  }

  void onSelectAddress(GeocodingResult? result) {
    if (result != null) {
      address.value = result.formattedAddress ?? '';
      latitude.value = result.geometry.location.lat;
      longitude.value = result.geometry.location.lng;
    }

    Get.back();
  }

  void onUpdatePost() async {
    try {
      final res = await editPostProvider.updatePost(
          title: title.value,
          postId: spot.id,
          address: address.value,
          latitude: latitude.value,
          longitude: longitude.value,
          content: content.value,
          tags: selectedTags.map((e) => e.id).toList(),
          token: bottomNavController.token,
          sourceLink: sourceLink.value,
          interestAreaId: selectedIa.value!.id,
          label: label.value,
          isAgeRestricted: isAgeRestricted.value);
      if (res) {
        Get.back();
        homeController?.fetchData();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  initFields() {
    title.value = spot.title;
    titleController.text = spot.title;
    selectedIa.value = spot.interestArea;
    content.value = spot.content;
    contentController.text = spot.content;
    selectedTags.value = spot.wikiTags;
    sourceLink.value = spot.sourceLink;
    sourceLinkController.text = spot.sourceLink;
    isAgeRestricted.value = spot.isAgeRestricted;
    address.value = spot.geolocation.address;
    latitude.value = spot.geolocation.latitude;
    longitude.value = spot.geolocation.longitude;
    label.value = spot.label == "Documentation"
        ? 0
        : spot.label == "Learning"
            ? 1
            : spot.label == "News"
                ? 2
                : spot.label == "Research"
                    ? 3
                    : 4;
    publicationDate.value = spot.createTime;
  }

  @override
  void onClose() {}
}
