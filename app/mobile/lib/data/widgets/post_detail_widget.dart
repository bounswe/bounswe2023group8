import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/models/post_model.dart';
import '../../../data/constants/assets.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getIANameById(post.iaIds.first),
                      style: TextStyle(
                          color: Color(
                            0xff9a208e,
                          ),
                          fontWeight: FontWeight.w600),
                    ),
                    Text(getNameSurnameById(post.userId)),
                    OutlinedButton(
                      onPressed: () {
                        //Follow
                      },
                      child: const Text("Follow"),
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    )
                  ],
                ),
              ],
            ),
            Text(post.createdAt)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Wrap(
              children: post.iaIds
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(12)),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text(getIANameById(e)),
                        ),
                      ))
                  .toList(),
            ),
            Text(
              post.sourceLink,
              style: TextStyle(color: Colors.blue),
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              Text(
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
            Text(
              '175',
              style: TextStyle(color: Colors.green),
            ),
            SizedBox(
              width: 10,
            ),
            Image.asset(Assets.downvote),
            const SizedBox(
              width: 5,
            ),
            Text(
              '18',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Report",
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Color(0XFFBA1F1F),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Wrap(
          children: post.iaIds
              .map((e) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(12)),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(getIANameById(e)),
                    ),
                  ))
              .toList(),
        ),
      ],
    ));
  }
}
