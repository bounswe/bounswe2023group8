import 'package:get/get.dart';
import 'package:mobile/modules/post_details/providers/post_details_provider.dart';

import '../controllers/post_details_controller.dart';

class PostDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostDetailsController>(
      () => PostDetailsController(),
    );
    Get.lazyPut(
      () => PostDetailsProvider(),
    );
  }
}
