import 'package:get/get.dart';
import 'package:mobile/modules/editIA/providers/edit_ia_provider.dart';

import '../controllers/edit_ia_controller.dart';

class EditIaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditIaController>(
      () => EditIaController(),
    );
    Get.lazyPut(
      () => EditIaProvider(),
    );
  }
}
