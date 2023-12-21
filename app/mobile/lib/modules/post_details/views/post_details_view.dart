import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/post_details/models/comment.dart';
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
          leadingBackIcon: true,
          search: false,
          notification: true,
          actions: [
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id ==
                    controller.bottomNavController.userId)
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: controller.navigateToEditPost,
                    child: Image.asset(
                      Assets.edit,
                      height: 30,
                    )),
              ),
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id !=
                    controller.bottomNavController.userId)
              Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () => controller.showReportSpot(),
                    child: Icon(
                      Icons.report_gmailerrorred,
                      size: 30,
                    )),
              )
          ],
        ),
        body: Obx(() {
          if (controller.routeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: Get.height,
            child: Stack(
              children: [
                SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Column(
                    children: [
                      const PostDetailWidget(),
                      const SizedBox(height: 20),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.comments.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(height: 4);
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return commentRow(controller.comments[index]);
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.soft,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.commentController,
                            decoration: const InputDecoration(
                              hintText: 'Make comment...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.2,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: controller.makeComment,
                          child: Icon(
                            Icons.send,
                            color: ThemePalette.main,
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

  Padding commentRow(CommentModel comment) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        tileColor: BackgroundPalette.regular,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(Assets.profilePlaceholder),
        ),
        title: Text(
          '@${comment.enigmaUser.username}',
          style: TextStyle(
            color: ThemePalette.main,
            fontSize: 12,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.content,
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 12,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.2,
              ),
            ),
            Text(
              getCommentTime(comment.createTime),
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 10,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.15,
              ),
            )
          ],
        ),
        trailing:
            (comment.enigmaUser.id == controller.bottomNavController.userId)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 2),
                      InkWell(
                          onTap: () => controller.deleteComment(comment.id),
                          child: Icon(
                            Icons.delete,
                            color: ThemePalette.main,
                            size: 20,
                          )),
                    ],
                  )
                : null,
      ),
    );
  }

  String getCommentTime(DateTime createTimeDate) {
    final now = DateTime.now();
    final difference = now.difference(createTimeDate);
    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return '${difference.inSeconds}s';
    }
  }
}
