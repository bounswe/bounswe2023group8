import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import '../controllers/ia_controller.dart';
import '../../../data/widgets/custom_app_bar.dart';

class InterestAreaView extends GetView<InterestAreaController> {
  const InterestAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingAppIcon: true,
        titleWidget: CustomSearchBar(
          controller: controller.searchController,
          onChanged: controller.onSearchQueryChanged,
        ),
        actions: [
          if (controller.isOwner)
          IconButton(
              onPressed: controller.navigateToEdit,
              icon: const Icon(Icons.edit))
        ],
      ),
      body: Obx(() {
      if (controller.routeLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
        }
        return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: controller.searchQuery.value.isNotEmpty
              ? _searchBody()
              : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          color: Colors.grey.shade300,
                          margin: const EdgeInsets.all(1.0),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              controller.interestArea.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                    if (!controller.isOwner)
                      controller.isFollower.value
                          ? OutlinedButton(
                              onPressed: controller.unfollowIa,
                              child: Text('Unfollow',
                                  style: TextStyle(color: ThemePalette.main)))
                          : OutlinedButton(
                              onPressed: controller.followIa,
                              child: Text('Follow',
                                  style: TextStyle(color: ThemePalette.main))),

                  if (controller.nestedIas.isNotEmpty) ...[
                    const Text(
                        'Sub Bunches',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 40,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.nestedIas.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => controller
                                  .navigateToIa(controller.nestedIas[index]),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  controller.nestedIas[index].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          }),
                    ),
                  ],
                
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
                          hideTags: true,
                        );
                      })
              ],
            ),
        ));
      }),
    );
  }

  Widget _searchBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.searchIas.isNotEmpty) ...[
          const Text('Bunches',
              style: TextStyle(
                fontSize: 16,
              )),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.searchIas.length,
              itemBuilder: (context, index) {
                final ia = controller.searchIas[index];
                return BunchWidget(
                    ia: ia, onTap: () => controller.navigateToIa(ia));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              }),
          const SizedBox(
            height: 10,
          ),
        ],
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}


