import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/interest_area.dart';
import 'package:mobile/data/models/wiki_tag.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/editIA/providers/edit_ia_provider.dart';

class EditIaController extends GetxController {
  InterestArea interestArea = Get.arguments['interestArea'];
  List<InterestArea> nestedIas = Get.arguments['nestedIas'];

  var routeLoading = false.obs;

  var accesLevel = 0.obs;

  var title = ''.obs;
  var subIaQuery = ''.obs;
  var description = ''.obs;
  var tagQuery = ''.obs;

  var actionInProgress = false.obs;

  RxList<WikiTag> searchTagResults = <WikiTag>[].obs;
  RxList<WikiTag> selectedTags = <WikiTag>[].obs;

  RxList<InterestArea> searchSubIaResults = <InterestArea>[].obs;
  RxList<InterestArea> selectedSubIas = <InterestArea>[].obs;


  final bottomNavController = Get.find<BottomNavigationController>();
  final newIaProvider = Get.find<EditIaProvider>();

  final titleController = TextEditingController();

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

  void submitSubIaQuery(String val) {
    searchSubIaResults.clear();
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

  void addSubIa(InterestArea ia) {
    selectedSubIas.add(ia);
    searchSubIaResults.remove(ia);
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

  onDeleteIa() async {
    if (actionInProgress.value) return;
    actionInProgress.value = true;
    try {
      final res = await newIaProvider.deleteIa(
          id: interestArea.id, token: bottomNavController.token);
      if (res) {
        Get.back();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void onUpdate() async {
    if (actionInProgress.value) return;
    actionInProgress.value = true;
    try {
      final success = await newIaProvider.updateIa(
          id: interestArea.id,
          token: bottomNavController.token,
          name: title.value,
          nestedIas: [],
          wikiTags: selectedTags.map((e) => e.id).toList(),
          accessLevel: accesLevel.value,
          description: description.value);
      if (success) {
        Get.back();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
    actionInProgress.value = false;
  }

  initFields() {
    title.value = interestArea.name;
    titleController.text = title.value;
    description.value = '';
    accesLevel.value = interestArea.accessInt;
    selectedTags.value = interestArea.wikiTags;
    selectedSubIas.value = nestedIas;
  }

  @override
  void onInit() {
    super.onInit();
    initFields();
  }

  @override
  void onClose() {}
}
