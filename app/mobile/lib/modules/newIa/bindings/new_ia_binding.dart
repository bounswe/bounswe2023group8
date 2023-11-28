import 'package:get/get.dart';
import 'package:mobile/modules/newIa/providers/new_ia_provider.dart';

import '../controllers/new_ia_controller.dart';

class NewIaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewIaController>(
      () => NewIaController(),
    );
    Get.lazyPut(
      () => NewIaProvider(),
    );
  }
}
