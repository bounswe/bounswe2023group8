import 'package:flutter/material.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.interestArea.name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: ThemePalette.dark),
            ),
            Row(
              children: [
                Text(
                  'Spotted by',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '@${post.enigmaUser.username}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: ThemePalette.main),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text('•'),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  post.createTime,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(4),
        subtitle: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 30, bottom: 10),
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(post.sourceLink,
                      style: TextStyle(
                          fontSize: 10,
                          color: ThemePalette.main,
                          decoration: TextDecoration.underline)),
                  Text(
                    post.content,
                    style: const TextStyle(
                        // color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),

                    // maxLines: 2,
                    
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                
                 
                  hideTags == true
                      ? const SizedBox()
                      : SizedBox(
                          height: 30,
                          child: ListView.separated(
                            itemCount: post.wikiTags.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 5,
                              );
                            },
                            itemBuilder: (BuildContext context, int index) {
                              final wikitag = post.wikiTags[index];
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: Container(
                                    color: Colors
                                        .grey, // Set the grey background color
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
                            },
                          ),
                        ),
                ],
              ),
            ),
            Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  Assets.spot,
                  width: 30,
                ))
          ],
        ),
       
      ),
    );
  }
}
