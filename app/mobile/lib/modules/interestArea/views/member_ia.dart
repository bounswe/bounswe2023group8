import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import '../controllers/ia_controller.dart';
import '../../../data/widgets/custom_app_bar.dart';

class InterestAreaView extends GetView<InterestAreaController> {
  const InterestAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.routeLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
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
        body: Container(
          color: ThemePalette.white,
          child: SingleChildScrollView(
            child: controller.searchQuery.value.isNotEmpty
                ? _searchBody()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: Get.width,
                                height: Get.height * 0.2,
                                decoration: BoxDecoration(
                                  color: BackgroundPalette.regular,
                                  // if ekle foto varsa image olsun
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 16),
                                padding: const EdgeInsets.only(
                                    left: 16, top: 33, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10)),
                                  color: BackgroundPalette.regular,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Sort By:',
                                      style: TextStyle(
                                        color: ThemePalette.dark,
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.2,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 28,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette.soft,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              Assets.sortNew,
                                              width: 24,
                                              height: 24,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              "New",
                                              style: TextStyle(
                                                color: ThemePalette.dark,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.15,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 28,
                                        padding: const EdgeInsets.only(
                                            left: 2,
                                            right: 4,
                                            top: 2,
                                            bottom: 2),
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette.soft,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              Assets.sortTop,
                                              width: 24,
                                              height: 24,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              "Top",
                                              style: TextStyle(
                                                color: ThemePalette.dark,
                                                fontSize: 12,
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: -0.15,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: Get.height * 0.17,
                            child: Container(
                              width: Get.width * 0.8,
                              padding: const EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                color: BackgroundPalette.dark,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: ThemePalette.black.withOpacity(0.25),
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(width: 16),
                                      Text(
                                        controller.interestArea.name,
                                        style: TextStyle(
                                          color: ThemePalette.light,
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -0.25,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette.light,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          'Join',
                                          style: TextStyle(
                                            color: ThemePalette.main,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 3),
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette.light,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: SvgPicture.asset(
                                          Assets.notification,
                                          width: 10,
                                          height: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 16,
                                            top: 3,
                                            bottom:
                                                3), //if ekle hangi sayfadaysa
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette
                                              .regular, // if ekle hangi sayfadaysa
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(10)),
                                        ),
                                        child: Text(
                                          'Spots',
                                          style: TextStyle(
                                            color: ThemePalette.dark,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical:
                                                2), //if ekle hangi sayfadaysa
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette
                                              .solid, // if ekle hangi sayfadaysa
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                        ),
                                        child: Text(
                                          'About',
                                          style: TextStyle(
                                            color: ThemePalette.dark,
                                            fontSize: 10,
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      /*if (!controller.isOwner)
                        controller.isFollower.value
                            ? OutlinedButton(
                                onPressed: controller.unfollowIa,
                                child: Text('Unfollow',
                                    style: TextStyle(color: ThemePalette.main)))
                            : OutlinedButton(
                                onPressed: controller.followIa,
                                child: Text('Follow',
                                    style:
                                        TextStyle(color: ThemePalette.main))),*/
                      if (controller.interestArea.accessLevel != 'PUBLIC')
                        Expanded(
                          child: Center(
                            child: Text(
                              'This bunch is private',
                              style: TextStyle(
                                color: ThemePalette.negative,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        ),
                      /*if (controller.nestedIas.isNotEmpty) ...[
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
                                  onTap: () => controller.navigateToIa(
                                      controller.nestedIas[index]),
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
                      ],*/
                      const SizedBox(height: 8),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.posts.length,
                        itemBuilder: (context, index) {
                          return PostTileWidget(
                            onTap: () => controller
                                .navigateToPostDetails(controller.posts[index]),
                            post: controller.posts[index],
                            hideTags: true,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                      )
                    ],
                  ),
          ),
        ),
      );
    });
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
