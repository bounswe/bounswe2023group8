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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Image.asset(
                    Assets.sampleImage1,
                    height: 160,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.sampleImage2,
                        height: 74,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            Assets.sampleImage3,
                            height: 74,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 30),
                          Image.asset(
                            Assets.sampleImage4,
                            height: 74,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Image.asset(
                      Assets.sampleImage5,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(width: 50),
                    Column(children: [
                      Image.asset(
                        Assets.sampleImage6,
                        height: 74,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 12),
                      Image.asset(
                        Assets.sampleImage7,
                        height: 74,
                        fit: BoxFit.contain,
                      ),
                    ]),
                    const SizedBox(width: 50),
                    Image.asset(
                      Assets.sampleImage8,
                      height: 160,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ],
            ),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                Assets.logo,
                height: Get.height * 0.2,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
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
            ])
          ],
        ),
      ),
    );
  }
}
