import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/post_details/views/post_detail_widget.dart';

import '../../../data/constants/assets.dart';
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
        appBar: CustomAppBar(
          leadingAppIcon: true,
          actions: [
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id ==
                    controller.bottomNavController.userId)
              IconButton(
                  onPressed: controller.navigateToEditPost,
                  icon: Image.asset(
                    Assets.edit,
                    height: 32,
                  ))
          ],
        ),
        body: Obx(() {
          if (controller.routeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                const PostDetailWidget(
                 
                ),
                const SizedBox(height: 20),
                
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.regular,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage(Assets.profilePlaceholder),
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
                      ],
                    ),
                  ),
                )
              
                
              ],
            ),
          );
        }));
  }
}
