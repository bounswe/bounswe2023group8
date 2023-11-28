import 'package:get/get.dart';
import 'package:mobile/modules/bottom_navigation/providers/bottom_nav_provider.dart';

import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(
      () => BottomNavigationController(),
    );
    Get.lazyPut(
      () => BottomNavProvider(),
    );
  }
}
