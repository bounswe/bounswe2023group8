import 'package:get/get.dart';
import 'package:mobile/routes/app_pages.dart';

class OpeningController extends GetxController {
  void navigateToAuthentication({required bool toLogin}) {
    Get.toNamed(Routes.authentication, arguments: {'toLogin': toLogin});
  }

  @override
  void onClose() {}
}
