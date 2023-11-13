import 'package:flutter/material.dart';
import 'package:mobile/data/models/post_model.dart';

class PostDetailWidget extends StatelessWidget {
  final PostModel post;

  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //Image
                Column(
                  children: [
                    //IA name
                    //Username
                    //Follow button
                  ],
                ),
              ],
            ),
            //Date
          ],
        ),
        Column(
          children: [
            //Title
            Wrap(
              children: [
                //Labels
              ],
            ),
            //Link
            //Content
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
