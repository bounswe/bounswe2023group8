import 'package:get/get.dart';
import 'package:mobile/modules/opening/controllers/opening_controller.dart';

class OpeningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OpeningController>(
      () => OpeningController(),
    );
  }
}
