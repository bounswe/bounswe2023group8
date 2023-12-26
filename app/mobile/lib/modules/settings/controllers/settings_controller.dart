import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/user_profile.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/settings/providers/settings_provider.dart';
import 'package:mobile/routes/app_pages.dart';

class SettingsController extends GetxController {

  final bottomNavController = Get.find<BottomNavigationController>();
  final settingsProvider = Get.find<SettingsProvider>();

  final _box = GetStorage();

  void onLogout() async {
    try {
      final res =
          await settingsProvider.logout(token: bottomNavController.token);
      if (res) {
        _box.remove('username');
        _box.remove('password');

        Get.offAllNamed(Routes.opening);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {}
}
