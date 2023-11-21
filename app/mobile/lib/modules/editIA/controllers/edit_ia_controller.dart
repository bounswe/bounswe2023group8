import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditIaController extends GetxController {
  var routeLoading = false.obs;
  var iaID = ''.obs;
  var iaTitle = ''.obs;
  var iaSubIAs = [].obs;
  var iaTags = [].obs;
  var iaRelatedIAs = [].obs;
  var iaDescription = ''.obs;

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

  void setInterestAreaID(String id){
    iaID = id.obs;
    setInterestAreaData(id);
  }

  void setInterestAreaData(String id){
    // get data from backend
    setIaTitle(''.obs);
    setIaSubIAs([].obs);
    setIaTags([].obs);
    setIaRelatedIAs([].obs);
    setIaDescription(''.obs);
  }

  void setIaTitle(data){
    iaTitle = data.obs;
  }
  void setIaSubIAs(data){
    iaSubIAs = data.obs;
  }
  void setIaTags(data){
    iaTags = data.obs;
  }
  void setIaRelatedIAs(data){
    iaRelatedIAs = data.obs;
  }
  void setIaDescription(data){
    iaDescription = data.obs;
  }
}
