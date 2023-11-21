import 'package:get/get.dart';

import '../controllers/edit_ia_controller.dart';

class NewIaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditIaController>(
      () => EditIaController(),
    );
  }
}
