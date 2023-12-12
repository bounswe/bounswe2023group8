import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/helpers/validator.dart';
import 'package:mobile/modules/authentication/providers/authentication_provider.dart';
import 'package:mobile/modules/authentication/views/verify_email_view.dart';

import '../../../data/helpers/error_handling_utils.dart';
import 'authentication_controller.dart';

class SignUpController extends GetxController {
  var signUpEmail = ''.obs;
  var signUpName = ''.obs;
  var signUpUsername = ''.obs;
  var signUpPassword = ''.obs;
  var confirmPassword = ''.obs;
  var signUpPasswordValid = false.obs;
  var confirmPasswordValid = true.obs;
  var passwordConfirmed = false.obs;
  var hidesignUpPassword = true.obs;
  var hideConfirmPassword = true.obs;
  var signUpUsernameValid = false.obs;
  var signUpEmailValid = false.obs;
  var signUpNameValid = false.obs;
  var signupInProgress = false.obs;
  var acceptTerms = false.obs;
  var birthday = ''.obs;

  final AuthenticationController authController =
      Get.find<AuthenticationController>();
  final AuthProvider authProvider = Get.find<AuthProvider>();

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      birthday.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void onChangeEmail(String value) {
    signUpEmail.value = value;
    signUpEmailValid.value = Validator.isEmailValid(signUpEmail.value);
  }

  void onChangeName(String value) {
    signUpName.value = value;
    signUpNameValid.value = value.length >= 3;
  }

  void onChangeUsername(String value) {
    signUpUsername.value = value;
    signUpUsernameValid.value = value.length >= 3;
  }

  void onChangePassword(String value) {
    signUpPassword.value = value;
    signUpPasswordValid.value = value.length >= 6;
    confirmPasswordValid.value = confirmPassword.value == signUpPassword.value;
  }

  void onChangeConfirmPassword(String value) {
    confirmPassword.value = value;
    confirmPasswordValid.value = confirmPassword.value == signUpPassword.value;
  }

  void togglePasswordVisibility() {
    hidesignUpPassword.value = !hidesignUpPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  void toggleTermsOfService() {
    acceptTerms.value = !acceptTerms.value;
  }

  void navigateToSignin() {
    authController.switchAuthView();
  }

  void onSignUp() async {
    signupInProgress.value = true;

    try {
      final res = await authProvider.signUp(
          name: signUpName.value,
          username: signUpUsername.value,
          email: signUpEmail.value,
          password: signUpPassword.value,
          birthday: birthday.value);
      if (res) {
        Get.to(() => const SentEmailView(
              verify: true,
            ));
      }
    } catch (e) {
      ErrorHandlingUtils.handleApiError(e);
    }


    
    signupInProgress.value = false;
  }

  @override
  void onClose() {}
}
