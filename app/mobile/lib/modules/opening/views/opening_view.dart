import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/modules/opening/controllers/opening_controller.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';

class OpeningView extends GetView<OpeningController> {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100), // Add space above the content
            Image.asset(
              Assets.logo,
              height: Get.height * 0.2,
              fit: BoxFit.contain,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 40), // Add space between login and logo
                  CustomButton(
                    text: 'Log in',
                    onPressed: () {
                      controller.navigateToAuthentication(toLogin: true);
                    },
                  ),
                  SizedBox(height: 10), // Add space between "Log in" and "Sign Up"
                  CustomButton(
                    text: 'Sign Up',
                    onPressed: () {
                      controller.navigateToAuthentication(toLogin: false);
                    },
                  ),
                  SizedBox(height: 10), // Add space between "Sign Up" and "or"
                  Text(
                    'or',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10), // Add space between "or" and "Continue as Visitor"
                  InkWell(
                    onTap: () {
                      // Handle "Continue as Visitor" click
                    },
                    child: Text(
                      'Continue as Visitor',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Palette.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
