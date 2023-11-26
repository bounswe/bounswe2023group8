import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/modules/authentication/providers/authentication_provider.dart';
import 'package:mobile/modules/authentication/views/forgot_password_view.dart';

import '../../../routes/app_pages.dart';
import 'authentication_controller.dart';
import 'forgot_password_controller.dart';

class LoginController extends GetxController {
  var loginUsername = ''.obs;
  var loginPassword = ''.obs;
  var loginPasswordValid = false.obs;
  var hideLoginPassword = true.obs;
  var loginUsernameValid = false.obs;
  var loginInProgress = false.obs;
  var rememberMe = false.obs;

  final _box = GetStorage();

  final forgotPasswordController = Get.find<ForgotPasswordController>();
  final loginProvider = Get.find<AuthProvider>();

  final AuthenticationController authController =
      Get.find<AuthenticationController>();

  void onChangeUsername(String value) {
    loginUsername.value = value;
    loginUsernameValid.value = value.length >= 3;
  }

  void onChangePassword(String value) {
    loginPassword.value = value;
    loginPasswordValid.value = value.length >= 6;
  }

  void togglePasswordVisibility() {
    hideLoginPassword.value = !hideLoginPassword.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void navigateToSignUp() {
    authController.switchAuthView();
  }

  void navigateToForgotPassword() {
    Get.to(() => const ForgotPasswordView());
  }

  void onSignIn() async {
    loginInProgress.value = true;

    try {
      final map = await loginProvider.login(
          user: loginUsername.value, password: loginPassword.value);

      if (map != null) {
        final token = map['token'];
        final userId = map['userId'];
        if (rememberMe.value) {
          await _box.write('username', loginUsername.value);
          await _box.write('password', loginPassword.value);
        } else {
          await _box.write('username', '');
          await _box.write('password', '');
        }
        Get.offAllNamed(Routes.bottomNavigation,
            arguments: {'token': token, 'userId': userId});
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }

    loginInProgress.value = false;
  }

  @override
  void onClose() {}
}
