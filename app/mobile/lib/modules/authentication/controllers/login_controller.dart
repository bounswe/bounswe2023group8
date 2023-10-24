import 'package:get/get.dart';

import 'authentication_controller.dart';

class LoginController extends GetxController {
  var loginUsername = ''.obs;
  var loginPassword = ''.obs;
  var loginPasswordValid = false.obs;
  var hideLoginPassword = true.obs;
  var loginUsernameValid = false.obs;
  var loginInProgress = false.obs;
  var rememberMe = false.obs;

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
    authController.toggleForgotPassword();
  }

  void onSignIn() async {
    loginInProgress.value = true;

    // Login logic will be implemented here

    //  Get.offAllNamed(
    //    Routes.bottomNavigation,
    //  );
    loginInProgress.value = false;
  }

  @override
  void onClose() {}
}
