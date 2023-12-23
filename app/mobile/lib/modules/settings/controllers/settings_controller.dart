import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/models/enigma_user.dart';
import 'package:mobile/data/models/user_profile.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/settings/providers/settings_provider.dart';
import 'package:mobile/modules/settings/views/change_password.dart';
import 'package:mobile/routes/app_pages.dart';

class SettingsController extends GetxController {
  final bottomNavigationController = Get.find<BottomNavigationController>();
  final settingsProvider = Get.find<SettingsProvider>();

  var oldPassword = ''.obs;
  var newPassword = ''.obs;
  var confirmPassword = ''.obs;
  var obscureOldPassword = true.obs;
  var obscureNewPassword = true.obs;
  var obscureConfirmPassword = true.obs;

  var changePasswordInProgress = false.obs;

  final _box = GetStorage();

  int userId = Get.arguments['userId'];

  var routeLoading = true.obs;
  late final UserProfile userProfile;

  void onChangeOldPassword(String value) {
    oldPassword.value = value;
  }

  void onChangeNewPassword(String value) {
    newPassword.value = value;
  }

  void onChangeConfirmPassword(String value) {
    confirmPassword.value = value;
  }

  void toggleObscureOldPassword() {
    obscureOldPassword.value = !obscureOldPassword.value;
  }

  void toggleObscureNewPassword() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void navigateToChangePassword() {
    Get.to(() => const ChangePasswordView());
  }

  void onChangePassword() async {
    if (changePasswordInProgress.value ||
        newPassword.value.length < 6 ||
        (newPassword.value != confirmPassword.value)) return;
    try {
      changePasswordInProgress.value = true;
      final res = await settingsProvider.changePassword(
          token: bottomNavigationController.token,
          engimaUserId: userId,
          oldPassword: oldPassword.value,
          newPassword1: newPassword.value,
          newPassword2: confirmPassword.value);
      if (res) {
        Get.snackbar(
          'Success',
          'Password changed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.brown,
          borderRadius: 0,
          colorText: Colors.white,
          margin: EdgeInsets.zero,
        );
        oldPassword.value = '';
        newPassword.value = '';
        confirmPassword.value = '';
        Get.back();
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
    changePasswordInProgress.value = false;
  }

  void onDeleteUser() async {
    try {
      final res = await settingsProvider.deleteUser(
          token: bottomNavigationController.token, id: userId);
      if (res) {
        _box.remove('username');
        _box.remove('password');

        Get.offAllNamed(Routes.opening);
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  void onLogout() async {
    try {
      final res = await settingsProvider.logout(
          token: bottomNavigationController.token);
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
