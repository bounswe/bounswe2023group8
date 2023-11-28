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
                        width: 152,
                        height: 52,
                        text: 'Log in',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        onPressed: () {
                          controller.navigateToAuthentication(toLogin: true);
                        },
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        width: 152,
                        height: 50,
                        text: 'Sign up',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        secondaryColor: true,
                        onPressed: () {
                          controller.navigateToAuthentication(toLogin: false);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'or',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: controller.navigateoToVisitorExplore,
                        child: Text(
                          'Continue as Visitor',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: ThemePalette.main,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
              ])
            ],
          );
        }),
      ),
    );
  }
}
