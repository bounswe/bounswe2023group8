import 'package:get/get.dart';

import '../controllers/visitor_explore_controller.dart';

class VisitorExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorExploreController>(
      () => VisitorExploreController(),
    );
  }
}
