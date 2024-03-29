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

  void backToAuth(bool login) {
    Get.until((route) => Get.currentRoute == Routes.opening);
    navigateToAuthentication(toLogin: login);
  }

  final _box = GetStorage();

  final _provider = Get.find<OpeningProvider>();

  void checkUserLoggedIn() async {
    try {
      final String username = _box.read('username') ?? '';
      final String password = _box.read('password') ?? '';
      if (username.isNotEmpty && password.isNotEmpty) {
        final map = await _provider.login(user: username, password: password);
        if (map != null) {
          final token = map['token'];
          final userId = map['userId'];
          Get.offAllNamed(Routes.bottomNavigation,
              arguments: {'token': token, 'userId': userId});
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
