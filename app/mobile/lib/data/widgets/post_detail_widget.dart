import 'package:flutter/material.dart';
import 'package:mobile/data/models/spot.dart';
import '../../../data/constants/assets.dart';

class PostDetailWidget extends StatelessWidget {
  final bool visitor;
  final Spot post;

  const PostDetailWidget({
    super.key,
    this.visitor = false,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/88164767?s=400&u=09da0dbc9d0ee0246d7492d938a20dbc4b2be7f1&v=4'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.interestArea.name,
                      style: const TextStyle(
                          color: Color(
                            0xff9a208e,
                          ),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(post.enigmaUser.name),
                    if (!visitor)
                      OutlinedButton(
                        onPressed: () {
                          //Follow
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Text("Follow"),
                      )
                  ],
                ),
              ],
            ),
            Text(post.createTime)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Wrap(
              children: post.wikiTags
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(e.label),
                        ),
                      ))
                  .toList(),
            ),
            Text(
              post.sourceLink,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              post.content,
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Text('Kaynak: '),
              ],
            ),
            Row(
              children: [
                Text('Paylaşım Tarihi: '),
              ],
            ),
          ]),
          Row(
            children: [
              Image.asset(Assets.factCheck),
              const Text(
                'UNKNOWN',
                style: TextStyle(
                    color: Color(0xffd9831f), fontWeight: FontWeight.w900),
              )
            ],
          ),
        ]),
        Row(
          children: [
            Image.asset(Assets.upvote),
            const SizedBox(
              width: 5,
            ),
            const Text(
              '175',
              style: TextStyle(color: Colors.green),
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(Assets.downvote),
            const SizedBox(
              width: 5,
            ),
            const Text(
              '18',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(
              width: 20,
            ),
            if (!visitor)
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0XFFBA1F1F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "Report",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Wrap(
          children: post.wikiTags
              .map((e) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(e.label),
                    ),
                  ))
              .toList(),
        ),
      ],
    ));
  }
}
