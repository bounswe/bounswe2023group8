import 'package:get/get.dart';
import 'package:mobile/modules/opening/controllers/opening_controller.dart';
import 'package:mobile/modules/opening/providers/opening_provider.dart';

class OpeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpeningController>(
      () => OpeningController(),
    );
    Get.lazyPut(
      () => OpeningProvider(),
    );
  }
}
