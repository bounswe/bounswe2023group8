import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/spot.dart';
import '../../../data/constants/assets.dart';

class PostDetailWidget extends StatelessWidget {
  final bool visitor;
  final Spot post;
  final void Function() showLocation;
  final bool showFollow;
  final bool showUnfollow;
  final void Function()? onFollowPressed;
  final void Function()? onUnfollowPressed;

  const PostDetailWidget({
    super.key,
    this.visitor = false,
    required this.post,
    required this.showLocation,
    this.showFollow = false,
    this.showUnfollow = false,
    this.onFollowPressed,
    this.onUnfollowPressed,

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: BackgroundPalette.regular,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Row(
                  children: [
                    Text(
                      post.interestArea.name,
                      style: TextStyle(
                          fontSize: 18,
                          color: ThemePalette.dark,
                          fontWeight: FontWeight.w700),
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          post.createTime.split(' ').first,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: SeparatorPalette.dark),
                        ),
                        Text(post.createTime.split(' ').last,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: SeparatorPalette.dark)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(Assets.profilePlaceholder)),
                  const SizedBox(
                    width: 6,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.enigmaUser.name,
                        style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '@${post.enigmaUser.username}',
                        style: TextStyle(
                            color: ThemePalette.main,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  const Spacer(),
                  if (showFollow | showUnfollow)
                    InkWell(
                      onTap: showFollow ? onFollowPressed : onUnfollowPressed,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ThemePalette.main,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        child: Text(
                          showFollow ? 'Follow' : 'Unfollow',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: Get.width,
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: BackgroundPalette.light,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 40,
                            child: InkWell(
                                onTap: showLocation,
                                child: Image.asset(Assets.geolocation))),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: ThemePalette.dark,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 3),
                                decoration: BoxDecoration(
                                    color: BackgroundPalette.solid,
                                    borderRadius: BorderRadius.circular(14)),
                                child: Text(
                                  post.label,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(post.sourceLink,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: ThemePalette.main,
                                  )),
                              const SizedBox(height: 8),
                              Text(
                                post.content,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      left: -5,
                      top: -8,
                      child: Image.asset(
                        Assets.spot,
                        height: 58,
                      ))
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: Get.width,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: ThemePalette.dark,
                    borderRadius: BorderRadius.circular(10)),
                child: Wrap(
                  children: (post.wikiTags)
                      .map((e) => Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, bottom: 4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: SeparatorPalette.light,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: Text(
                                '#${e.label}',
                                style: TextStyle(
                                    color: SeparatorPalette.dark,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
             
              Row(
                children: [
                  Image.asset(
                    Assets.upvote,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  
                  Text(
                    '175',
                    style: TextStyle(color: ThemePalette.positive),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    Assets.downvote,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    '18',
                    style: TextStyle(color: Colors.red),
                  ),
                  const Spacer(),
                  if (!visitor)
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0XFFBA1F1F),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Report Spot",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                ],
              ),
           
              
            ],
          ),
        ),
        Positioned(
            top: -15,
            left: -5,
            child: Image.asset(
              Assets.bunch,
              height: 48,
            )),
      ],
    );
  }
}
