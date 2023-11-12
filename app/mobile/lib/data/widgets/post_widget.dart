import 'package:flutter/material.dart';
import 'package:mobile/data/models/post_model.dart';

class PostTileWidget extends StatelessWidget {
  final PostModel post;
  final String Function(int id) getAreaNameById;
  final String Function(int id) getUserNameById;
  const PostTileWidget(
      {super.key,
      required this.post,
      required this.getAreaNameById,
      required this.getUserNameById});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: ListTile(
        title: Text(
          post.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // Handle the interest area tap (e.g., navigate to an area-specific page)
              },
              child: Text(
                post.sourceLink,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),

                // maxLines: 2,
              ),
            ),
            // Text(
            //   "Content: ${item['content']}",
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            const SizedBox(
              height: 16,
            ),

            Row(
              children: [
                const Text("Created By ", style: TextStyle(fontSize: 10)),
                Text(
                  getUserNameById(post.userId),
                  style: const TextStyle(fontSize: 10, color: Colors.brown),
                ),
                const Spacer(),
                Text(
                  post.createdAt.split(' ')[0].split('-').reversed.join('.'),
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            )
          ],
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: post.iaIds.map<Widget>((iaId) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  color: Colors.grey, // Set the grey background color
                  margin: const EdgeInsets.all(1.0), // Add margin between rows
                  child: Padding(
                    padding:
                        const EdgeInsets.all(4.0), // Adjust padding as needed
                    child: Text(
                      "#${getAreaNameById(iaId)}",
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
        onTap: () {
          // Handle item tap (e.g., navigate to a detail page)
        },
      ),
    );
  }
}
