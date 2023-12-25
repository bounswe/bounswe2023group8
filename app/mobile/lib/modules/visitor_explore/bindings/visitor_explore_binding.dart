import 'package:get/get.dart';

import '../controllers/visitor_explore_controller.dart';
import '../providers/explore_provider.dart';

class VisitorExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorExploreController>(
      () => VisitorExploreController(),
    );
    Get.lazyPut(
      () => ExploreProvider(),
    );
  }
}
