import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';

import '../../../data/widgets/custom_app_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.routeLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
          titleWidget: CustomSearchBar(),
        ),
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.posts.length,
                      itemBuilder: (context, index) {
                        return PostTileWidget(
                          onTap: () => controller
                              .navigateToPostDetails(controller.posts[index]),
                          post: controller.posts[index],
                          hideTags: false,
                        );
                      })
                ],
              ),
            ))),
      );
    }
    );
  }
}
