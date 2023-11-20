import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewIaController extends GetxController {
  var routeLoading = false.obs;

  final titleController = TextEditingController();
  final subIASearchController = TextEditingController();
  final tagSearchController = TextEditingController();
  final relatedIASearchController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}
}
