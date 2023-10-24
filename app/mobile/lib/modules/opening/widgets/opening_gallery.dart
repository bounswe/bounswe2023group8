import 'package:flutter/widgets.dart';

import '../../../data/constants/assets.dart';

class OpeningGallery extends StatelessWidget {
  const OpeningGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
