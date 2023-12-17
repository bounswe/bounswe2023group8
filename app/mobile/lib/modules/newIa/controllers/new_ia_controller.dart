import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/wiki_tag.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/newIa/providers/new_ia_provider.dart';

class NewIaController extends GetxController {
  var routeLoading = false.obs;

  var accesLevel = 0.obs;

  var title = ''.obs;
  var subIaQuery = ''.obs;
  var description = ''.obs;
  var tagQuery = ''.obs;

  var createInProgress = false.obs;

  RxList<WikiTag> searchTagResults = <WikiTag>[].obs;
  RxList<WikiTag> selectedTags = <WikiTag>[].obs;

  RxList<InterestArea> searchSubIaResults = <InterestArea>[].obs;
  RxList<InterestArea> selectedSubIas = <InterestArea>[].obs;

  final bottomNavController = Get.find<BottomNavigationController>();
  final newIaProvider = Get.find<NewIaProvider>();

  get isFormValid => title.value.isNotEmpty && description.value.isNotEmpty;

  void onChangeAccessLevel(int value) {
    accesLevel.value = value;
  }

  void onChangeTitle(String value) {
    title.value = value;
  }

  void onChangeDescription(String value) {
    description.value = value;
  }

  void onChangeSubIaQuery(String value) {
    subIaQuery.value = value;
    searchSubIaResults.clear();
    if (value == '') {
      return;
    }
    searchSubIa();
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

  void submitSubIaQuery(String val) {
    searchSubIaResults.clear();
  }

  void addTag(WikiTag tag) {
    selectedTags.add(tag);
    searchTagResults.remove(tag);
  }

  void addSubIa(InterestArea ia) {
    selectedSubIas.add(ia);
    searchSubIaResults.remove(ia);
  }

  void removeTag(WikiTag tag) {
    selectedTags.remove(tag);
  }

  void removeSubIa(InterestArea ia) {
    selectedSubIas.remove(ia);
  }

  void searchSubIa() async {
    try {
      final subIas = await newIaProvider.searchSubIas(
          key: subIaQuery.value, token: bottomNavController.token);
      if (subIas != null) {
        searchSubIaResults.value = subIas;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void searchTags() async {
    try {
      final tags = await newIaProvider.searchTags(
          key: tagQuery.value, token: bottomNavController.token);
      if (tags != null) {
        searchTagResults.value = tags;
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void onCreate() async {
    if (createInProgress.value) return;
    createInProgress.value = true;
    try {
      final success = await newIaProvider.createNewIa(
          token: bottomNavController.token,
          name: title.value,
          nestedIas: [],
          wikiTags: selectedTags.map((e) => e.id).toList(),
          accessLevel: accesLevel.value,
          description: description.value);
      if (success) {
        title.value = '';
        description.value = '';
        selectedTags.clear();
        accesLevel.value = 0;
        Get.snackbar(
          'Success',
          'Bunch created successfully',
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
    createInProgress.value = false;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}
}
