import 'package:get/get.dart';
import 'package:mobile/modules/newPost/providers/new_post_provider.dart';

import '../controllers/new_post_controller.dart';

class NewPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPostController>(
      () => NewPostController(),
    );

    Get.lazyPut(
      () => NewPostProvider(),
    );
  }
}
