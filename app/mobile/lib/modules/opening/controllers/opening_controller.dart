import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/routes/app_pages.dart';

import '../providers/opening_provider.dart';

class OpeningController extends GetxController {
  var splash = true.obs;

  void navigateToAuthentication({required bool toLogin}) {
    Get.toNamed(Routes.authentication, arguments: {'toLogin': toLogin});
  }

  final _box = GetStorage();

  final _provider = Get.find<OpeningProvider>();

  void checkUserLoggedIn() async {
    try {
      final String username = _box.read('username') ?? '';
      final String password = _box.read('password') ?? '';
      if (username.isNotEmpty && password.isNotEmpty) {
        final token = await _provider.login(user: username, password: password);
        if (token != null) {
          Get.offAllNamed(Routes.bottomNavigation, arguments: {'token': token});
          return;
        }
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
    splash.value = false;
  }

  void navigateoToVisitorExplore() {
    Get.toNamed(Routes.visitorExplore);
  }

  @override
  void onClose() {}

  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn();
  }
}
