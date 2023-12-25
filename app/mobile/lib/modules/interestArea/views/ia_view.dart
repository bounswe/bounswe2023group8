import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/routes/app_pages.dart';
import '../controllers/ia_controller.dart';
import '../../../data/widgets/custom_app_bar.dart';

class InterestAreaView extends GetView<InterestAreaController> {
  const InterestAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.routeLoading.value) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: CustomAppBar(
            leadingAppIcon: true,
            leadingBackIcon: true,
            search: true,
            onSearchQueryChanged: controller.onSearchQueryChanged,
            notification: false,
            actions: [
              if (controller.isOwner)
                InkWell(
                  onTap: controller.navigateToEdit,
                  child: Image.asset(
                    Assets.edit,
                    width: 20,
                    height: 20,
                  ),
                )
              else
                InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () => controller.showReportBunch(),
                  child: Image.asset(
                    Assets.report,
                    width: 24,
                    height: 24,
                  ),
                ),
              const SizedBox(width: 16),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width,
                                  height: Get.height * 0.2,
                                  decoration: BoxDecoration(
                                    color: BackgroundPalette.regular,
                                    image: controller.interestArea.pictureUrl !=
                                            null
                                        ? DecorationImage(
                                            image: NetworkImage(controller
                                                .interestArea.pictureUrl!),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                Divider(
                                  height: 0,
                                  thickness: 1,
                                  color: SeparatorPalette.dark,
                                ),
                                if (controller.viewState.value ==
                                    BunchViewState.main)
                                  ...mainBody()
                                else if (controller.viewState.value ==
                                    BunchViewState.about)
                                  ...aboutBody()
                                else if (controller.viewState.value ==
                                    BunchViewState.requests)
                                  ...requestBody()
                              ],
                            ),
                            if (controller.isOwner)
                              Positioned(
                                top: 16,
                                right: 16,
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: controller.uploadImage,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: BackgroundPalette.light,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(
                                          Assets.newPicture,
                                          width: 16,
                                          height: 16,
                                        ),
                                      ),
                                    ),
                                    if (controller.interestArea.pictureUrl !=
                                            null &&
                                        controller.interestArea.pictureUrl!
                                            .isNotEmpty)
                                      InkWell(
                                        onTap: controller.deletePicture,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: BackgroundPalette.light,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Image.asset(
                                            Assets.delete,
                                            width: 16,
                                            height: 16,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            Positioned(
                              top: Get.height * 0.17,
                              child: Container(
                                width: Get.width * 0.8,
                                padding:
                                    const EdgeInsets.only(top: 8, right: 16),
                                decoration: BoxDecoration(
                                  color: BackgroundPalette.dark,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          ThemePalette.black.withOpacity(0.25),
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
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: Get.width * 0.8 - 112,
                                          ),
                                          child: Text(
                                            controller.interestArea.name,
                                            style: TextStyle(
                                              color: ThemePalette.light,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.25,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        if (!controller.isOwner)
                                          controller.isFollower.value
                                              ? InkWell(
                                                  onTap: controller.unfollowIa,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: BackgroundPalette
                                                          .light,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Text(
                                                      "Leave",
                                                      style: TextStyle(
                                                        color: ThemePalette
                                                            .negative,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: -0.15,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: controller.followIa,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: BackgroundPalette
                                                          .light,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Text(
                                                      controller
                                                              .requestSent.value
                                                          ? 'Sent'
                                                          : 'Join',
                                                      style: TextStyle(
                                                        color:
                                                            ThemePalette.main,
                                                        fontSize: 10,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        letterSpacing: -0.15,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                        const SizedBox(width: 8),
                                        if (controller.isOwner)
                                          InkWell(
                                            onTap: () =>
                                                controller.onChangeState(
                                                    BunchViewState.requests),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 6,
                                                      vertical: 3),
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
                                          ),
                                      ],
                                    ),
                                    controller.viewState.value ==
                                            BunchViewState.requests
                                        ? const SizedBox(height: 8)
                                        : const SizedBox(height: 6),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (controller.viewState.value !=
                                                BunchViewState.main) {
                                              controller.onChangeState(
                                                  BunchViewState.main);
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 16,
                                                top: controller
                                                            .viewState.value ==
                                                        BunchViewState.main
                                                    ? 3
                                                    : 2,
                                                bottom: controller
                                                            .viewState.value ==
                                                        BunchViewState.main
                                                    ? 3
                                                    : 2),
                                            decoration: BoxDecoration(
                                              color: controller
                                                          .viewState.value ==
                                                      BunchViewState.main
                                                  ? BackgroundPalette.regular
                                                  : BackgroundPalette.solid,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10)),
                                            ),
                                            child: Text(
                                              'Spots',
                                              style: TextStyle(
                                                color: ThemePalette.dark,
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: controller
                                                            .viewState.value ==
                                                        BunchViewState.main
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                letterSpacing: -0.15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        InkWell(
                                          onTap: () {
                                            if (controller.viewState.value !=
                                                BunchViewState.about) {
                                              controller.onChangeState(
                                                  BunchViewState.about);
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: controller
                                                            .viewState.value ==
                                                        BunchViewState.about
                                                    ? 3
                                                    : 2),
                                            decoration: BoxDecoration(
                                              color: controller
                                                          .viewState.value ==
                                                      BunchViewState.about
                                                  ? BackgroundPalette.regular
                                                  : BackgroundPalette.solid,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(10),
                                                      topRight:
                                                          Radius.circular(10)),
                                            ),
                                            child: Text(
                                              'About',
                                              style: TextStyle(
                                                color: ThemePalette.dark,
                                                fontSize: 10,
                                                fontFamily: 'Inter',
                                                fontWeight: controller
                                                            .viewState.value ==
                                                        BunchViewState.about
                                                    ? FontWeight.w700
                                                    : FontWeight.w500,
                                                letterSpacing: -0.15,
                                              ),
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
                      ],
                    ),
            ),
          ),
        );
      },
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

  List<Widget> mainBody() {
    return [
      Container(
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.only(left: 16, top: 33, bottom: 8),
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(10)),
          color: BackgroundPalette.regular,
        ),
        child: Row(
          children: [
            Text(
              'Sort By:',
              style: TextStyle(
                color: ThemePalette.dark,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2,
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () {
                controller.sortByDate(); //Call sorting fnc here
              },
              child: Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: BackgroundPalette.soft,
                  borderRadius: BorderRadius.circular(20),
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
              onTap: () {
                controller.sortByTop(); //Call sorting fnc here
              },
              child: Container(
                height: 28,
                padding:
                    const EdgeInsets.only(left: 2, right: 4, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  color: BackgroundPalette.soft,
                  borderRadius: BorderRadius.circular(20),
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
      const SizedBox(height: 8),
      ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.posts.length,
        itemBuilder: (context, index) {
          final spot = controller.posts[index];
          final isVoted = controller.isVotes[spot.id] ?? [false, false];
          return PostTileWidget(
            onTap: () => controller.navigateToPostDetails(spot),
            post: spot,
            hideTags: true,
            isUpvoted: isVoted[0],
            isDownvoted: isVoted[1],
            onUpvote: () => controller.upvotePost(spot.id),
            onDownvote: () => controller.downvotePost(spot.id),
            showVoters: () => controller.showVotes(spot.id),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    ];
  }

  List<Widget> aboutBody() {
    return [
      Container(
        width: Get.width,
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 41, bottom: 16),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: BackgroundPalette.regular,
          borderRadius:
              const BorderRadius.only(bottomRight: Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Get.width,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: BackgroundPalette.light,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About ${controller.interestArea.name} Bunch:",
                    style: TextStyle(
                      color: ThemePalette.dark,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.25,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        controller.interestArea.description,
                        style: TextStyle(
                          color: ThemePalette.dark,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: Get.width,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                height: 21,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.interestArea.wikiTags.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == controller.interestArea.wikiTags.length) {
                      if (!controller.hasAccess.value || controller.isOwner) {
                        return SizedBox.shrink();
                      }
                      return InkWell(
                        onTap: () => controller.showTagSuggestionModal(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: BackgroundPalette.solid,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Assets.add,
                                width: 12,
                                height: 12,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Suggest",
                                style: TextStyle(
                                  color: ThemePalette.light,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final wikitag = controller.interestArea.wikiTags[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: SeparatorPalette.light,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "#${wikitag.label}",
                          style: TextStyle(
                            color: SeparatorPalette.dark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      );
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 8);
                  },
                ),
              ),
            ),
            if (controller.interestArea.nestedInterestAreas.isNotEmpty) ...[
              const SizedBox(height: 8),
              Container(
                width: Get.width,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: BackgroundPalette.dark,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 21,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        controller.interestArea.nestedInterestAreas.length,
                    itemBuilder: (BuildContext context, int index) {
                      final nestedBunch =
                          controller.interestArea.nestedInterestAreas[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: BackgroundPalette.solid,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          nestedBunch,
                          style: TextStyle(
                            color: BackgroundPalette.soft,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(width: 8);
                    },
                  ),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: BackgroundPalette.dark,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.light,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Created at:",
                          style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 7.5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.15,
                          ),
                        ),
                        Text(
                          controller.interestArea.createTime.year.toString(),
                          style: TextStyle(
                            color: ThemePalette.dark,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Container(
                  //   padding: const EdgeInsets.all(8),
                  //   decoration: BoxDecoration(
                  //     color: BackgroundPalette.light,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "201k",

                  //             style: TextStyle(
                  //               color: ThemePalette.dark,
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.w500,
                  //               letterSpacing: -0.25,
                  //             ),
                  //           ),
                  //           Text(
                  //             "Members",
                  //             style: TextStyle(
                  //               color: ThemePalette.dark,
                  //               fontSize: 6,
                  //               fontWeight: FontWeight.w500,
                  //               letterSpacing: -0.1,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       const SizedBox(width: 8),
                  //       Container(
                  //         width: 1,
                  //         height: 24,
                  //         color: SeparatorPalette.dark,
                  //       ),
                  //       const SizedBox(width: 8),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Row(
                  //             children: [
                  //               Text(
                  //                 "•",
                  //                 style: TextStyle(
                  //                   color: ThemePalette.positive,
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w500,
                  //                   letterSpacing: -0.25,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 "308",
                  //                 style: TextStyle(
                  //                   color: ThemePalette.dark,
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.w500,
                  //                   letterSpacing: -0.25,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             "Online",
                  //             style: TextStyle(
                  //               color: ThemePalette.dark,
                  //               fontSize: 6,
                  //               fontWeight: FontWeight.w500,
                  //               letterSpacing: -0.1,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      )
    ];
  }

  List<Widget> requestBody() {
    return [
      const SizedBox(
        height: 40,
      ),
      if (controller.followRequests.isNotEmpty) ...[
        Text('Follow Requests:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
                title: InkWell(
                    onTap: () => Get.toNamed(Routes.profile, arguments: {
                          'userId': controller.followRequests[index].follower.id
                        }),
                    child:
                        Text(controller.followRequests[index].follower.name)),
                subtitle: InkWell(
                    onTap: () => Get.toNamed(Routes.profile, arguments: {
                          'userId': controller.followRequests[index].follower.id
                        }),
                    child: Text(
                        controller.followRequests[index].follower.username)),
                leading: InkWell(
                    onTap: () => Get.toNamed(Routes.profile, arguments: {
                          'userId': controller.followRequests[index].follower.id
                        }),
                    child:
                        controller.followRequests[index].follower.pictureUrl !=
                                    null &&
                                controller.followRequests[index].follower
                                    .pictureUrl!.isNotEmpty
                            ? CircleAvatar(
                                backgroundImage: NetworkImage(controller
                                    .followRequests[index]
                                    .follower
                                    .pictureUrl!),
                              )
                            : const CircleAvatar(
                                backgroundImage:
                                    AssetImage(Assets.profilePlaceholder),
                              )),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => controller.acceptIaRequest(
                            controller.followRequests[index].requestId),
                        icon: const Icon(Icons.check, color: Colors.green)),
                    IconButton(
                        onPressed: () => controller.rejectIaRequest(
                            controller.followRequests[index].requestId),
                        icon: const Icon(Icons.close, color: Colors.red)),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            }),
      ],
      if (controller.tagSuggestions.isNotEmpty) ...[
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
      ]
    ];
  }
}
