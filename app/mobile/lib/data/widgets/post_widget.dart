import 'package:flutter/material.dart';
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
      color: Colors.blue.shade50,
      child: ListTile(
        onTap: onTap,
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              child: Text(
                post.content,
                style: const TextStyle(
                    // color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),

                // maxLines: 2,
              ),
            ),
          
            const SizedBox(
              height: 5,
            ),
            Text(post.sourceLink,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.blue,
                    decoration: TextDecoration.underline)),
            Text(post.interestArea.name,
                style: const TextStyle(
                    fontSize: 10,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold)),
            Row(
              children: [
                
                Text(
                  post.enigmaUser.name,
                  style: const TextStyle(fontSize: 10, color: Colors.brown),
                ),
                const Spacer(),

                Text(
                  post.createTime,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            )
          ],
        ),
        trailing: hideTags == true
            ? const SizedBox()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: post.wikiTags.map<Widget>((wikitag) {
                  return ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        color: Colors.grey, // Set the grey background color
                        margin: const EdgeInsets.all(
                            1.0), // Add margin between rows
                        child: Padding(
                          padding: const EdgeInsets.all(
                              4.0), // Adjust padding as needed
                          child: Text(
                            "#${wikitag.label}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors
                                  .black54, // Text color inside the grey background
                            ),
                          ),
                        ),
                      ));
                }).toList(),
              ),
      ),
    );
  }
}
