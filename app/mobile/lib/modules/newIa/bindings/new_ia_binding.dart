import 'package:get/get.dart';

import '../controllers/new_ia_controller.dart';

class NewIaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewIaController>(
      () => NewIaController(),
    );
  }
}
