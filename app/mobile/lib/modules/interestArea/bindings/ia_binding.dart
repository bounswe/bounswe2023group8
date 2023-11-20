import 'package:get/get.dart';
import '../controllers/ia_controller.dart';

class InterestAreaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InterestAreaController());
  }
}