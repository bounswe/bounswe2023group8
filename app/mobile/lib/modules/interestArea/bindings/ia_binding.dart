import 'package:get/get.dart';
import 'package:mobile/modules/interestArea/providers/ia_provider.dart';
import '../controllers/ia_controller.dart';

class InterestAreaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InterestAreaController());
    Get.lazyPut(() => IaProvider());
  }
}
