import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/spot.dart';

class PostTileWidget extends StatelessWidget {
  final Spot post;
  final void Function()? onTap;
  final bool hideTags;
  const PostTileWidget(
      {super.key, required this.post, this.onTap, required this.hideTags});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: BackgroundPalette.regular,
      child: ListTile(
        onTap: onTap,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.interestArea.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: ThemePalette.dark),
            ),
            Row(
              children: [
                Text(
                  'Spotted by',
                  style: TextStyle(
                    color: ThemePalette.dark,
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '@${post.enigmaUser.username}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      color: ThemePalette.main),
                ),
                const SizedBox(width: 4),
                Text('•',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                        color: ThemePalette.dark)),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  post.createTime,
                  style: TextStyle(
                    color: ThemePalette.dark,
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
        contentPadding: const EdgeInsets.all(8),
        subtitle: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: Get.width,
              padding: EdgeInsets.only(left: 27, bottom: 10),
              decoration: BoxDecoration(
                  color: BackgroundPalette.light,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  Text(post.sourceLink,
                      style: TextStyle(
                          fontSize: 10,
                          color: ThemePalette.main,
                          decoration: TextDecoration.underline)),
                  const SizedBox(height: 4),
                  Text(
                    post.content,
                    style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(height: 4),
                  hideTags == true
                      ? const SizedBox()
                      : SizedBox(
                          height: 30,
                          child: ListView.separated(
                            itemCount: post.wikiTags.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 4);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final wikitag = post.wikiTags[index];
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    color: SeparatorPalette
                                        .light, // Set the grey background color
                                    margin: const EdgeInsets.all(
                                        1.0), // Add margin between rows
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          4.0), // Adjust padding as needed
                                      child: Text(
                                        "#${wikitag.label}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: SeparatorPalette
                                              .dark, // Text color inside the grey background
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                ],
              ),
            ),
            Positioned(
                left: -5,
                top: -5,
                child: Image.asset(
                  Assets.spot,
                  width: 32,
                ))
          ],
        ),
      ),
    );
  }
}
