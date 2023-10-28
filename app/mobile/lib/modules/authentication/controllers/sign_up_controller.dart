import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/helpers/validator.dart';

import '../../../routes/app_pages.dart';
import 'authentication_controller.dart';

class SignUpController extends GetxController {
  var signUpEmail = ''.obs;
  var signUpUsername = ''.obs;
  var signUpPassword = ''.obs;
  var confirmPassword = ''.obs;
  var signUpBirthday = ''.obs;
  var signUpPasswordValid = false.obs;
  var confirmPasswordValid = true.obs;
  var passwordConfirmed = false.obs;
  var hidesignUpPassword = true.obs;
  var hideConfirmPassword = true.obs;
  var signUpUsernameValid = false.obs;
  var signUpEmailValid = false.obs;
  var signupInProgress = false.obs;
  var acceptTerms = false.obs;
  var birthday = ''.obs;

  final AuthenticationController authController =
      Get.find<AuthenticationController>();

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
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

    Get.offAllNamed(
      Routes.bottomNavigation,
    );

    // Signup logic will be implemented here

    //  Get.offAllNamed(
    //    Routes.bottomNavigation,
    //  );
    signupInProgress.value = false;
  }

  @override
  void onClose() {}
}
