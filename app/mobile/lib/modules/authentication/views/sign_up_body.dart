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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(flex: 7),
            Image.asset(
              Assets.logo,
              height: Get.height * 0.2,
              fit: BoxFit.contain,
            ),
            const Spacer(flex: 1),
            Text('Sign Up',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Palette.primaryColor)),
            const Spacer(flex: 4),
            CustomTextField(
              hintText: 'E-mail',
              initialValue: controller.signUpEmail.value,
              isValid: controller.signUpEmailValid.value,
              onChanged: (value) => controller.onChangeEmail(value),
              circularBorder: true,
              showSuffix: false,
            ),
            const Spacer(flex: 1),
            CustomTextField(
              hintText: 'Username',
              initialValue: controller.signUpUsername.value,
              isValid: controller.signUpUsernameValid.value,
              onChanged: (value) => controller.onChangeUsername(value),
              circularBorder: true,
              showSuffix: false,
            ),
            const Spacer(flex: 1),
            InkWell(
                onTap: () => controller.pickDate(),
                child: Container(
                  width: Get.width,
                  height: 48,
                  padding: const EdgeInsets.only(top: 14, left: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.white,
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
                            ? Colors.grey
                            : Colors.black),
                  ),
                )),
            const Spacer(flex: 1),
            CustomTextField(
                hintText: 'Password',
                initialValue: controller.signUpPassword.value,
                isPassword: true,
                obscureText: controller.hidesignUpPassword.value,
                onChanged: (value) => controller.onChangePassword(value),
                circularBorder: true,
                onSuffixTap: () => controller.togglePasswordVisibility()),
            const Spacer(flex: 1),
            CustomTextField(
                hintText: 'Confirm Password',
                initialValue: controller.confirmPassword.value,
                isPassword: true,
                obscureText: controller.hideConfirmPassword.value,
                onChanged: (value) => controller.onChangeConfirmPassword(value),
                circularBorder: true,
                onSuffixTap: () =>
                    controller.toggleConfirmPasswordVisibility()),
            const Spacer(flex: 1),
            !controller.confirmPasswordValid.value
                ? const Text(
                    "Confirm password must match your password!",
                    style: TextStyle(color: Colors.red),
                  )
                : const SizedBox(),
            const Spacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 26.0,
                      width: 26.0,
                      child: Checkbox(
                        value: controller.acceptTerms.value,
                        onChanged: (value) {
                          controller.toggleTermsOfService();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: Colors.green,
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('I accept the Terms of Service',
                        style: TextStyle(
                          fontSize: 16,
                        )),
                  ],
                ),
              ],
            ),
            const Spacer(flex: 5),
            CustomButton(
                onPressed: controller.onSignUp,
                width: Get.width * 0.4,
                shadow: true,
                text: 'Sign up',
                inProgress: controller.signupInProgress.value,
                active: controller.signUpUsernameValid.value &&
                    controller.signUpPasswordValid.value &&
                    controller.signUpEmailValid.value &&
                    controller.confirmPasswordValid.value &&
                    controller.acceptTerms.value),
            const Spacer(flex: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Already have an account?',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                InkWell(
                  onTap: controller.navigateToSignin,
                  child: Text('Log in',
                      style: TextStyle(
                          color: Palette.primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Spacer(flex: 15),
          ],
        );
      }),
    );
  }
}
