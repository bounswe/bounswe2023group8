import 'package:get/get.dart';
import 'package:mobile/modules/editPost/providers/edit_post_provider.dart';

import '../controllers/edit_post_controller.dart';

class EditPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditPostController>(
      () => EditPostController(),
    );
    Get.lazyPut(
      () => EditPostProvider(),
    );
  }
}
