import 'package:get/get.dart';

import '../controllers/edit_post_controller.dart';

class EditPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPostController>(
      () => EditPostController(),
    );
  }
}
