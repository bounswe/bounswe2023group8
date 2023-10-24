import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/data/helpers/validator.dart';

import 'authentication_controller.dart';

class ForgotPasswordController extends GetxController {
  var loginEmail = ''.obs;
  var loginEmailValid = false.obs;
  var verificationFailed = false.obs;

  final AuthenticationController authController =
  Get.find<AuthenticationController>();

  void onChangeUsername(String value) {
    loginEmail.value = value;
    loginEmailValid.value = Validator.isEmailValid(loginEmail.value);

  }

  void navigateToLogin() {
    authController.toggleForgotPassword();
  }

  void onSubmit() async {
    // Forgot password submit logic here, then navigate to login

    // verify email, to see if it exists
    if(true){
      verificationFailed = false.obs;
      navigateToLogin();
    }else{
      verificationFailed = true.obs;
    }

  }

  @override
  void onClose() {}
}
