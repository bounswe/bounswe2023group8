import 'package:flutter/material.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/models/user_model.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final User user;
  final int followersCount;
  final int followingCount;

  final void Function() onFollowersPressed;
  final void Function() onFollowingPressed;
  const ProfileHeaderWidget({
    super.key,
    required this.user,
    required this.followersCount,
    required this.followingCount,
    required this.onFollowersPressed,
    required this.onFollowingPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 75,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(user.profileImage),
            ),
            const SizedBox(width: 10),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '@${user.username}',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: onFollowersPressed,
                        child: Text(
                          '$followersCount Followers',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: onFollowingPressed,
                        child: Text(
                          '$followingCount Following',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  Assets.upvote,
                  width: 25,
                ),
                const SizedBox(height: 5),
                Image.asset(
                  Assets.downvote,
                  width: 25,
                ),
              ],
            ),
            const SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  user.likeCount.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  user.dislikeCount.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
