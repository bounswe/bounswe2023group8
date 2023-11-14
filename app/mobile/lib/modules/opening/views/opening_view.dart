import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/modules/opening/controllers/opening_controller.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/modules/opening/widgets/opening_gallery.dart';

class OpeningView extends GetView<OpeningController> {
  const OpeningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          return Stack(
            alignment: Alignment.center,
            children: [
              const OpeningGallery(),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  Assets.logo,
                  height: Get.height * 0.2,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                if (!controller.splash.value)
                  Column(
                    children: [
                      CustomButton(
                        text: 'Log in',
                        onPressed: () {
                          controller.navigateToAuthentication(toLogin: true);
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: 'Sign up',
                        secondaryColor: true,
                        onPressed: () {
                          controller.navigateToAuthentication(toLogin: false);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'or',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: controller.navigateoToVisitorExplore,
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
              ])
            ],
          );
        }
        ),
      ),
    );
  }
}
