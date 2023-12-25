import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/constants/assets.dart';

class OpeningGallery extends StatelessWidget {
  const OpeningGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.sampleImage1,
              width: Get.width * 0.26,
              height: Get.height * 0.2,
              fit: BoxFit.fill,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  Assets.sampleImage2,
                  width: Get.width * 0.72,
                  height: Get.height * 0.09,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: Get.height * 0.01),
                Row(
                  children: [
                    Image.asset(
                      Assets.sampleImage3,
                      width: Get.width * 0.38,
                      height: Get.height * 0.1,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(width: Get.width * 0.02),
                    Image.asset(
                      Assets.sampleImage4,
                      width: Get.width * 0.32,
                      height: Get.height * 0.1,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: Get.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Assets.sampleImage5,
              width: Get.width * 0.38,
              height: Get.height * 0.24,
              fit: BoxFit.fill,
            ),
            Column(
              children: [
                Image.asset(
                  Assets.sampleImage6,
                  width: Get.width * 0.34,
                  height: Get.height * 0.11,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: Get.height * 0.01),
                Image.asset(
                  Assets.sampleImage7,
                  width: Get.width * 0.34,
                  height: Get.height * 0.12,
                  fit: BoxFit.fill,
                ),
              ],
            ),
            Image.asset(
              Assets.sampleImage8,
              width: Get.width * 0.24,
              height: Get.height * 0.24,
              fit: BoxFit.fill,
            ),
          ],
        ),
      ],
    );
  }
}
