import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/modules/post_details/models/comment.dart';
import 'package:mobile/modules/post_details/views/post_detail_widget.dart';
import 'package:mobile/routes/app_pages.dart';

import '../../../data/constants/assets.dart';
import '../../../data/widgets/visitor_bottom_bar.dart';
import '../../opening/controllers/opening_controller.dart';
import '../controllers/post_details_controller.dart';

class PostDetailsView extends GetView<PostDetailsController> {
  const PostDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leadingAppIcon: true,
          leadingBackIcon: true,
          search: false,
          notification: false,
          actions: [
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id ==
                    controller.bottomNavigationController.userId) ...[
              Padding(
                padding: const EdgeInsets.only(
                  top: 14,
                  bottom: 14,
                ),
                child: CircleAvatar(
                  backgroundColor: ThemePalette.main,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: controller.toggleTagSuggestionView,
                      child: SvgPicture.asset(
                        Assets.notification,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: controller.navigateToEditPost,
                  child: Image.asset(
                    Assets.edit,
                  ),
                ),
              ),
            ],
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id !=
                    controller.bottomNavigationController.userId)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => controller.showReportSpot(),
                  child: Icon(
                    Icons.report_gmailerrorred,
                    size: 30,
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: controller.visitor
            ? VisitorBottomBar(
                onLoginPressed: () =>
                    Get.find<OpeningController>().backToAuth(true),
                onSignUpPressed: () =>
                    Get.find<OpeningController>().backToAuth(false))
            : null,
        body: Obx(() {
          if (controller.routeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.tagSuggestionView.value) {
            return tagSuggestionView();
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
                      const SizedBox(height: 60),
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
        leading: InkWell(
            onTap: () => Get.toNamed(Routes.profile,
                arguments: {'userId': comment.enigmaUser.id}),
            child: comment.enigmaUser.pictureUrl != null &&
                    comment.enigmaUser.pictureUrl!.isNotEmpty
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(comment.enigmaUser.pictureUrl!),
                  )
                : const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(Assets.profilePlaceholder),
                  )),
        title: InkWell(
          onTap: () => Get.toNamed(Routes.profile,
              arguments: {'userId': comment.enigmaUser.id}),
          child: Text(
            '@${comment.enigmaUser.username}',
            style: TextStyle(
              color: ThemePalette.main,
              fontSize: 12,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ),
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
        trailing: (comment.enigmaUser.id ==
                controller.bottomNavigationController.userId)
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

  Widget tagSuggestionView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text('Tag Suggestions:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.tagSuggestions.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 0),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 10),
                    minVerticalPadding: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(controller.tagSuggestions[index].label,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: Text(controller.tagSuggestions[index].description,
                        style: TextStyle(fontSize: 12)),
                    leading: Column(
                      children: [
                        Text(
                            controller.tagSuggestions[index].requesterCount
                                .toString(),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        Text(
                            controller.tagSuggestions[index].requesterCount > 1
                                ? 'Requests'
                                : 'Request',
                            style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () => controller.acceptTagSuggestion(
                                controller.tagSuggestions[index].id),
                            icon: const Icon(Icons.check, color: Colors.green)),
                        IconButton(
                            onPressed: () => controller.rejectTagSuggestion(
                                controller.tagSuggestions[index].id),
                            icon: const Icon(Icons.close, color: Colors.red)),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              }),
        ),
      ],
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
