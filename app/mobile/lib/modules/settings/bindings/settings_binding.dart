import 'package:get/get.dart';
import 'package:mobile/modules/settings/providers/settings_provider.dart';

import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
    Get.lazyPut(() => SettingsProvider());
  }
}
