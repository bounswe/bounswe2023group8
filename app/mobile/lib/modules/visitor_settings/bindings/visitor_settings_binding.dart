import 'package:get/get.dart';

import '../controllers/visitor_settings_controller.dart';

class VisitorSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VisitorSettingsController>(
      () => VisitorSettingsController(),
    );
  }
}
