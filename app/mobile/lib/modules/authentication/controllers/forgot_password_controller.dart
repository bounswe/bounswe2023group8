import 'package:get/get.dart';
import 'package:mobile/data/helpers/error_handling_utils.dart';
import 'package:mobile/data/helpers/validator.dart';
import 'package:mobile/modules/authentication/views/reset_password_view.dart';

import '../providers/authentication_provider.dart';
import '../views/verify_email_view.dart';
import 'authentication_controller.dart';

class ForgotPasswordController extends GetxController {
  var email = ''.obs;
  var emailValid = false.obs;
  var verificationFailed = false.obs;

  final AuthenticationController authController =
      Get.find<AuthenticationController>();
  final authProvider = Get.find<AuthProvider>();

  void onChangeUsername(String value) {
    email.value = value;
    emailValid.value = Validator.isEmailValid(email.value);
  }

  void onSubmit() async {
    try {
      //  final res = await authProvider.forgotPassword(email: email.value);
      //  if (res) {
      Get.to(() => const ResetPasswordView());

      //  }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }
  }

  @override
  void onClose() {}
}
