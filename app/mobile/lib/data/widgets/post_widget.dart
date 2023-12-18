import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/spot.dart';

class PostTileWidget extends StatelessWidget {
  final Spot post;
  final void Function()? onTap;
  final bool hideTags;
  final void Function() onUpvote;
  final void Function() onDownvote;
  final void Function() showUpvoters;
  final void Function() showDownvoters;
  const PostTileWidget(
      {super.key,
      required this.post,
      this.onTap,
      required this.hideTags,
      required this.onUpvote,
      required this.onDownvote,
      required this.showUpvoters,
      required this.showDownvoters});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BackgroundPalette.regular,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.only(left: 8, right: 4),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.interestArea.name,
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Spotted by',
                      style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 10,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.15),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '@${post.enigmaUser.username}',
                      style: TextStyle(
                        color: ThemePalette.main,
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.15,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '•',
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post.createTime,
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.15,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: onUpvote,
                      child: Image.asset(
                        Assets.upvote,
                        width: 14,
                      ),
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      onTap: showUpvoters,
                      child: Text(
                        post.upvoteCount.toString(),
                        style: TextStyle(
                          color: ThemePalette.positive,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      onTap: onDownvote,
                      child: Image.asset(
                        Assets.downvote,
                        width: 14,
                      ),
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      onTap: showDownvoters,
                      child: Text(
                        post.downvoteCount.toString(),
                        style: TextStyle(
                          color: ThemePalette.negative,
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: -0.15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        subtitle: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: Get.width,
              margin: const EdgeInsets.only(left: 12, top: 9),
              padding:
                  const EdgeInsets.only(left: 27, right: 12, top: 4, bottom: 4),
              decoration: BoxDecoration(
                  color: BackgroundPalette.light,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      color: ThemePalette.dark,
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Container(
                    height: 12,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.solid,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      post.label,
                      style: TextStyle(
                        color: BackgroundPalette.light,
                        fontSize: 8,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    post.sourceLink,
                    style: TextStyle(
                        color: ThemePalette.main,
                        fontSize: 10,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                        decoration: TextDecoration.underline,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    post.content,
                    style: TextStyle(
                      color: ThemePalette.dark,
                      fontSize: 10,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  hideTags == true
                      ? const SizedBox()
                      : SizedBox(
                          height: 12,
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
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: BackgroundPalette.soft,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  "#${wikitag.label}",
                                  style: TextStyle(
                                    color: SeparatorPalette.dark,
                                    fontSize: 8,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.15,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
            Positioned(
                left: 7,
                top: 4,
                child: Image.asset(
                  Assets.spot,
                  width: 32,
                )),
          ],
        ),
      ),
    );
  }
}
