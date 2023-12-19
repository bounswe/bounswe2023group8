import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';
import 'package:flutter_svg/svg.dart';
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
                icon: const Icon(Icons.edit)),
          if (!controller.isOwner)
            Padding(
              padding: const EdgeInsets.all(10),
              child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => controller.showReportBunch(),
                  child: Icon(
                    Icons.report_gmailerrorred,
                    size: 30,
                  )),
            )
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
                    Container(
                      padding:
                          const EdgeInsets.only(right: 20, left: 0, top: 6),
                      decoration: BoxDecoration(
                        color: BackgroundPalette.dark, // Arka plan rengi
                        borderRadius: BorderRadius.circular(
                            30), // Köşe yuvarlaklık derecesi
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                controller.interestArea.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              if (!controller.isOwner)
                                controller.isFollower.value
                                    ? OutlinedButton(
                                        onPressed: controller.unfollowIa,
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide.none,
                                          minimumSize: const Size(0, 0),
                                          backgroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                        ),
                                        child: Text('Leave',
                                            style: TextStyle(
                                                color: ThemePalette.main)))
                                    : OutlinedButton(
                                        onPressed: controller.followIa,
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide.none,
                                          minimumSize: const Size(0, 0),
                                          backgroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                        ),
                                        child: Text(
                                            controller.requestSent.value
                                                ? 'Sent'
                                                : 'Join',
                                            style: TextStyle(
                                              color: ThemePalette.main,
                                            ))),
                              if (controller.isOwner)
                                InkWell(
                                  onTap: () => controller
                                      .onChangeState(BunchViewState.requests),
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: SvgPicture.asset(
                                      Assets
                                          .notification, // SVG dosyasının yolu
                                      color:
                                          const Color(0xff0B68B1), // İkon rengi
                                      width: 14,
                                      height: 14,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => controller
                                    .onChangeState(BunchViewState.main),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: BackgroundPalette.regular,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(30)),
                                  ),
                                  child: const Text(
                                    'Spots',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: const Color(0xff434343),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                  width:
                                      18), // Spots ve About arasındaki boşluk
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: BackgroundPalette.solid,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      topLeft: Radius.circular(12)),
                                ),
                                child: const Text(
                                  'About',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: const Color(0xff434343),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (controller.viewState.value == BunchViewState.main)
                      ...mainBody()
                    else if (controller.viewState.value == BunchViewState.about)
                      ...aboutBody()
                    else if (controller.viewState.value ==
                        BunchViewState.requests)
                      ...requestBody()
                  ],
                ),
        ));
      }),
    );
  }

  List<Widget> requestBody() {
    return [
      Text('Follow Requests', style: TextStyle(fontSize: 18)),
      const SizedBox(
        height: 10,
      ),
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.followRequests.length,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.only(left: 10),
              minVerticalPadding: 0,
              tileColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: Text(controller.followRequests[index].follower.name),
              subtitle:
                  Text(controller.followRequests[index].follower.username),
              leading: CircleAvatar(
                backgroundImage: AssetImage(Assets.profilePlaceholder),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => controller.acceptIaRequest(
                          controller.followRequests[index].requestId),
                      icon: const Icon(Icons.check)),
                  IconButton(
                      onPressed: () => controller.rejectIaRequest(
                          controller.followRequests[index].requestId),
                      icon: const Icon(Icons.close)),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          }),
    ];
  }

  List<Widget> aboutBody() {
    return [Text('about')];
  }

  List<Widget> mainBody() {
    if (controller.interestArea.accessLevel != 'PUBLIC' &&
        !controller.hasAccess.value)
      return [
        const Text(
          'You do not have access to this bunch.',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.red,
          ),
        ),
      ];

    return [
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
                  onTap: () =>
                      controller.navigateToIa(controller.nestedIas[index]),
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
      ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            return PostTileWidget(
                onTap: () =>
                    controller.navigateToPostDetails(controller.posts[index]),
                post: controller.posts[index],
                hideTags: true,
                onDownvote: () =>
                    controller.downvotePost(controller.posts[index].id),
                onUpvote: () =>
                    controller.upvotePost(controller.posts[index].id),
                showDownvoters: () =>
                    controller.showDownVotes(controller.posts[index].id),
                showUpvoters: () =>
                    controller.showUpVotes(controller.posts[index].id));
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          })
    ];
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
