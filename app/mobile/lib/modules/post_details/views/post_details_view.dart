import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/post_detail_widget.dart';

import '../../../data/constants/assets.dart';
import '../../../data/widgets/post_widget.dart';
import '../../../data/widgets/visitor_bottom_bar.dart';
import '../../opening/controllers/opening_controller.dart';
import '../controllers/post_details_controller.dart';

class PostDetailsView extends GetView<PostDetailsController> {
  const PostDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: controller.visitor
            ? VisitorBottomBar(
                onLoginPressed: () =>
                    Get.find<OpeningController>().backToAuth(true),
                onSignUpPressed: () =>
                    Get.find<OpeningController>().backToAuth(false))
            : null,
        appBar: const CustomAppBar(
          leadingAppIcon: true,
        ),
        body: Obx(() {
          if (controller.routeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                PostDetailWidget(
                  visitor: controller.visitor,
                  post: controller.post,
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: Palette.lightColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(children: [
                    const Row(
                      children: [
                        Text(
                          'Comments',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '140',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xff4936BF),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/88164767?s=400&u=09da0dbc9d0ee0246d7492d938a20dbc4b2be7f1&v=4'),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Mourinho’yu dinlemedi, kariyeri bitti adamin.',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(children: [
                                Image.asset(
                                  Assets.upvote,
                                  height: 20,
                                ),
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
                                Image.asset(
                                  Assets.downvote,
                                  height: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  '18',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ])
                            ],
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down_sharp)
                      ],
                    )
                  ]),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      return PostTileWidget(
                        onTap: () =>
                            controller.changePost(controller.posts[index]),
                        post: controller.posts[index],
                        hideTags: false,
                      );
                    })
              ],
            ),
          );
        }));
  }
}
