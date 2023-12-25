import 'package:get/get.dart';
import 'package:mobile/modules/home/providers/home_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(
      () => HomeProvider(),
    );
  }
}
