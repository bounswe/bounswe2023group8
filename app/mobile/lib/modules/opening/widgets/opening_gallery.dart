import 'package:flutter/widgets.dart';

import '../../../data/constants/assets.dart';

class OpeningGallery extends StatelessWidget {
  const OpeningGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                Assets.sampleImage1,
                height: 152,
                fit: BoxFit.contain,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    Assets.sampleImage2,
                    height: 68,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Assets.sampleImage3,
                        height: 75,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 7),
                      Image.asset(
                        Assets.sampleImage4,
                        height: 75,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ]),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              Assets.sampleImage5,
              height: 194,
              fit: BoxFit.contain,
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Assets.sampleImage6,
                    height: 90,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 9),
                  Image.asset(
                    Assets.sampleImage7,
                    height: 95,
                    fit: BoxFit.contain,
                  ),
                ]),
            Image.asset(
              Assets.sampleImage8,
              height: 194,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ],
    );
  }
}
