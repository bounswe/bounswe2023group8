import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/authentication/controllers/sign_up_controller.dart';

import '../../../data/constants/assets.dart';
import '../../../data/constants/palette.dart';
import '../../../data/widgets/custom_button.dart';
import '../../../data/widgets/custom_text_field.dart';

class SignUpBody extends GetView<SignUpController> {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.1),
              Image.asset(
                Assets.logo,
                height: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                'Sign Up',
                style: TextStyle(
                  color: ThemePalette.main,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                hintText: 'Name',
                initialValue: controller.signUpName.value,
                isValid: controller.signUpNameValid.value,
                onChanged: (value) => controller.onChangeName(value),
                circularBorder: true,
                showSuffix: false,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'E-mail',
                initialValue: controller.signUpEmail.value,
                isValid: controller.signUpEmailValid.value,
                onChanged: (value) => controller.onChangeEmail(value),
                circularBorder: true,
                showSuffix: false,
              ),
              const SizedBox(height: 8),
              CustomTextField(
                hintText: 'Username',
                initialValue: controller.signUpUsername.value,
                isValid: controller.signUpUsernameValid.value,
                onChanged: (value) => controller.onChangeUsername(value),
                circularBorder: true,
                showSuffix: false,
              ),
              const SizedBox(height: 8),
              InkWell(
                  onTap: () => controller.pickDate(),
                  child: Container(
                    width: Get.width,
                    height: 48,
                    padding: const EdgeInsets.only(top: 14, left: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: ThemePalette.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          offset: Offset(4, 4),
                          blurRadius: 10,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Text(
                      controller.birthday.value.isNotEmpty
                          ? controller.birthday.value
                          : 'Enter your birthday',
                      style: TextStyle(
                          fontSize: 16,
                          color: controller.birthday.value.isEmpty
                              ? ThemePalette.dark.withOpacity(0.4)
                              : ThemePalette.dark),
                    ),
                  )),
              const SizedBox(height: 8),
              CustomTextField(
                  hintText: 'Password',
                  initialValue: controller.signUpPassword.value,
                  isPassword: true,
                  obscureText: controller.hidesignUpPassword.value,
                  onChanged: (value) => controller.onChangePassword(value),
                  circularBorder: true,
                  onSuffixTap: () => controller.togglePasswordVisibility()),
              const SizedBox(height: 8),
              CustomTextField(
                  hintText: 'Confirm Password',
                  initialValue: controller.confirmPassword.value,
                  isPassword: true,
                  obscureText: controller.hideConfirmPassword.value,
                  onChanged: (value) =>
                      controller.onChangeConfirmPassword(value),
                  circularBorder: true,
                  onSuffixTap: () =>
                      controller.toggleConfirmPasswordVisibility()),
              const SizedBox(height: 8),
              !controller.confirmPasswordValid.value
                  ? Text(
                      "Confirm password must match your password!",
                      style: TextStyle(color: ThemePalette.negative),
                    )
                  : const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 28.0,
                        width: 28.0,
                        child: Checkbox(
                          value: controller.acceptTerms.value,
                          onChanged: (value) {
                            controller.toggleTermsOfService();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: ThemePalette.main,
                          side: BorderSide(color: ThemePalette.dark),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'I accept the Terms of Service',
                        style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: controller.onSignUp,
                width: 152,
                height: 50,
                shadow: true,
                text: 'Sign up',
                fontSize: 25,
                fontWeight: FontWeight.bold,
                inProgress: controller.signupInProgress.value,
                active: controller.signUpUsernameValid.value &&
                    controller.signUpPasswordValid.value &&
                    controller.signUpEmailValid.value &&
                    controller.confirmPasswordValid.value &&
                    controller.signUpNameValid.value &&
                    controller.acceptTerms.value,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Already have an account?',
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.35,
                      )),
                  InkWell(
                    onTap: controller.navigateToSignin,
                    child: Text('Log in',
                        style: TextStyle(
                            color: ThemePalette.main,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 64),
            ],
          ),
        );
      },
    );
  }
}
