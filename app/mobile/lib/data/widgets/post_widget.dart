import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/spot.dart';
import 'package:mobile/routes/app_pages.dart';

class PostTileWidget extends StatelessWidget {
  final Spot post;
  final void Function()? onTap;
  final bool hideTags;
  final void Function() onUpvote;
  final void Function() onDownvote;
  final void Function() showVoters;
  const PostTileWidget({
    super.key,
    required this.post,
    this.onTap,
    required this.hideTags,
    required this.onUpvote,
    required this.onDownvote,
    required this.showVoters,
  });

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
            InkWell(
              onTap: () => Get.toNamed(Routes.interestArea,
                  arguments: {'interestArea': post.interestArea}),
              child: Text(
                post.interestArea.name,
                style: TextStyle(
                  color: ThemePalette.dark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(height: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Spotted by',
                      style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.2),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.profile,
                          arguments: {'userId': post.enigmaUser.id}),
                      child: Text(
                        '@${post.enigmaUser.username}',
                        style: TextStyle(
                          color: ThemePalette.main,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '•',
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      post.createTime,
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2,
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
                        width: 15,
                        height: 15,
                      ),
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      onTap: showVoters,
                      child: SizedBox(
                        width: 18,
                        child: Text(
                          post.upvoteCount >= post.downvoteCount
                              ? (post.upvoteCount - post.downvoteCount)
                                  .toString()
                              : (post.downvoteCount - post.upvoteCount)
                                  .toString(),
                          style: TextStyle(
                            color: post.upvoteCount >= post.downvoteCount
                                ? post.upvoteCount == post.downvoteCount
                                    ? ThemePalette.dark
                                    : ThemePalette.positive
                                : ThemePalette.negative,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    InkWell(
                      onTap: onDownvote,
                      child: Image.asset(
                        Assets.downvote,
                        width: 15,
                        height: 15,
                      ),
                    ),
                    const SizedBox(width: 4),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.24,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Container(
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
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.17,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    post.sourceLink,
                    style: TextStyle(
                        color: ThemePalette.main,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
                        decoration: TextDecoration.underline,
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(height: 4),
                  if (hideTags)
                    Text(
                      post.content,
                      style: TextStyle(
                        color: ThemePalette.dark,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.2,
                      ),
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            post.content,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ThemePalette.dark,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: [
                                for (final tag in post.wikiTags)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 1),
                                    decoration: BoxDecoration(
                                      color: BackgroundPalette.soft,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: SeparatorPalette.dark
                                            .withOpacity(0.6),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "#${tag.label}",
                                      style: TextStyle(
                                        color: SeparatorPalette.dark,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.17,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
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
