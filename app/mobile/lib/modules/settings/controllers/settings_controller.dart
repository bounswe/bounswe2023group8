import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/helpers/error_handling_utils.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../providers/settings_provider.dart';

class SettingsController extends GetxController {

  final _box = GetStorage();

  final settingsProvider = Get.find<SettingsProvider>();
  final bottomNavController = Get.find<BottomNavigationController>();

  @override
  void onInit() {
    super.onInit();
  }


  void logout() async {
    try {
      final res =
          await settingsProvider.logout(token: bottomNavController.token);
      if (res) {
        await _box.write('email', '');
        await _box.write('password', '');
        Get.offAllNamed(Routes.opening);
      }
    } catch (error) {
      ErrorHandlingUtils.handleApiError(error);
    }
  }
  @override
  void onClose() {}
}
