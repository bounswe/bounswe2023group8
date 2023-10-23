import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'authentication_controller.dart';

class SignUpController extends GetxController {

  var loginEmail = ''.obs;
  var loginUsername = ''.obs;
  var loginPassword = ''.obs;
  var confirmPassword = ''.obs;
  var loginBirthday = ''.obs;
  var selectedDate = 'Birthday'.obs;
  var loginPasswordValid = false.obs;
  var confirmPasswordValid = false.obs;
  var passwordConfirmed = false.obs;
  var hideLoginPassword = true.obs;
  var hideConfirmPassword = true.obs;
  var loginUsernameValid = false.obs;
  var loginEmailValid = false.obs;
  var signupInProgress = false.obs;
  var acceptTerms = false.obs;

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
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void onChangeSelectedDate(String value) {
    selectedDate.value = value;
  }

  void onChangeEmail(String value) {
    loginEmail.value = value;
    loginEmailValid.value = value.length >= 3;
  }

  void onChangeUsername(String value) {
    loginUsername.value = value;
    loginUsernameValid.value = value.length >= 3;
  }

  void onChangePassword(String value) {
    loginPassword.value = value;
    loginPasswordValid.value = value.length >= 6;
    confirmPasswordValid.value = confirmPassword.value == loginPassword.value;
  }

  void onChangeConfirmPassword(String value) {
    confirmPassword.value = value;
    confirmPasswordValid.value = confirmPassword.value == loginPassword.value;
  }

  void togglePasswordVisibility() {
    hideLoginPassword.value = !hideLoginPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  void toggleTermsOfService() {
    acceptTerms.value = !acceptTerms.value;
  }

  void navigateToSignUp() {
    authController.switchAuthView();
  }

  void onSignUp() async {
    signupInProgress.value = true;

    // Login logic will be implemented here

    //  Get.offAllNamed(
    //    Routes.bottomNavigation,
    //  );
    signupInProgress.value = false;
  }

  @override
  void onClose() {}
}
