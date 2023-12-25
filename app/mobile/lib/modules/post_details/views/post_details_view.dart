import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/modules/post_details/models/comment.dart';
import 'package:mobile/modules/post_details/views/post_detail_widget.dart';
import 'package:mobile/routes/app_pages.dart';

import '../../../data/constants/assets.dart';
import '../controllers/post_details_controller.dart';

class PostDetailsView extends GetView<PostDetailsController> {
  const PostDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.routeLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: CustomAppBar(
          leadingAppIcon: true,
          leadingBackIcon: true,
          search: false,
          notification: false,
          actions: [
            InkWell(
              onTap: controller.showAnnotation,
              child: Image.asset(
                Assets.annotation,
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(width: 16),
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id ==
                    controller.bottomNavigationController.userId) ...[
              InkWell(
                onTap: controller.navigateToEditPost,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Image.asset(
                  Assets.edit,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: controller.toggleTagSuggestionView,
                child: SvgPicture.asset(
                  Assets.notification,
                  width: 22,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
            ],
            if (!controller.visitor &&
                controller.post.value.enigmaUser.id !=
                    controller.bottomNavigationController.userId) ...[
              InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => controller.showReportSpot(),
                child: Image.asset(
                  Assets.report,
                  width: 24,
                  height: 24,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ],
        ),
        body: controller.tagSuggestionView.value
            ? tagSuggestionView()
            : SizedBox(
                height: Get.height,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 16),
                      child: Column(
                        children: [
                          const PostDetailWidget(),
                          const SizedBox(height: 20),
                          (controller.showAnnotations.value)
                              ? _annotationsView()
                              : ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.comments.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(height: 4);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return commentRow(
                                        controller.comments[index]);
                                  },
                                ),
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                    if ((controller.annotationSelection.value.extentOffset -
                            controller.annotationSelection.value.baseOffset) >
                        0)
                      Positioned(
                        bottom: 10,
                        left: 20,
                        child: Column(
                          children: [
                            //write comment
                            Container(
                              width: Get.width - 40,
                              decoration: BoxDecoration(
                                color: BackgroundPalette.soft,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: TextFormField(
                                controller: controller.annotationController,
                                decoration: const InputDecoration(
                                  hintText: 'Annotate...',
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

                            CustomButton(
                                text: 'Annotate',
                                onPressed: controller.onAnnotate),
                          ],
                        ),
                      ),
                    if ((controller.annotationSelection.value.extentOffset -
                                controller
                                    .annotationSelection.value.baseOffset) ==
                            0 &&
                        !controller.showAnnotations.value)
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
                                    hintText: 'Write comment...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
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
              ),
      );
    });
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

  Widget _annotationsView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.annotations.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 4);
      },
      itemBuilder: (BuildContext context, int index) {
        final annotation = controller.annotations[index];
        return Padding(
          padding: const EdgeInsets.only(left: 40),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            tileColor: BackgroundPalette.regular,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: InkWell(
                onTap: () => Get.toNamed(Routes.profile,
                    arguments: {'userId': annotation.userId}),
                child: annotation.profilePhoto != null &&
                        annotation.profilePhoto!.isNotEmpty
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(annotation.profilePhoto!),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(Assets.profilePlaceholder),
                      )),
            title: InkWell(
              onTap: () => Get.toNamed(Routes.profile,
                  arguments: {'userId': annotation.userId}),
              child: Text(
                '@${annotation.username}',
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
                  controller.post.value.content
                      .substring(annotation.start, annotation.end),
                  style: TextStyle(
                    color: ThemePalette.negative,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.2,
                  ),
                ),
                Text(
                  annotation.note,
                  style: TextStyle(
                    color: ThemePalette.dark,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.2,
                  ),
                ),
              ],
            ),
            trailing: (annotation.userId ==
                    controller.bottomNavigationController.userId)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 2),
                      InkWell(
                          onTap: () => controller.deleteAnnotation(annotation),
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
      },
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
