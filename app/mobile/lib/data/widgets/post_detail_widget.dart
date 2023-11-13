import 'package:flutter/material.dart';
import 'package:mobile/data/models/post_model.dart';

class PostDetailWidget extends StatelessWidget {
  final PostModel post;
  final String Function(int id) getProfileImageById;
  final String Function(int id) getIANameById;
  final String Function(int id) getNameSurnameById;

  const PostDetailWidget(
      {super.key,
      required this.post,
      required this.getProfileImageById,
      required this.getIANameById,
      required this.getNameSurnameById});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(getProfileImageById(post.userId)),
                ),
                Column(
                  children: [
                    Text(getIANameById(post.id)),
                    Text(getNameSurnameById(post.userId)),
                    TextButton(
                        onPressed: () {
                          //Follow
                        },
                        child: const Text("Follow")),
                  ],
                ),
              ],
            ),
            Text(post.createdAt)
          ],
        ),
        Column(
          children: [
            Text(post.title),
            Wrap(
              children: [
                //Labels
              ],
            ),
            Expanded(child: Text(post.sourceLink)),
            Expanded(
              child: Text(post.content),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                //Source
                //Date
                Row(
                  children: [
                    //Upvote
                    //Downvote
                    //Report button
                  ],
                ),
              ],
            ),
            Row(
              children: [
                //Fact check
                //Geolocation
              ],
            ),
          ],
        ),
        Wrap(
          children: [
            //Tags
          ],
        )
      ],
    ));
  }
}
