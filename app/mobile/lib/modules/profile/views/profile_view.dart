import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import 'package:mobile/modules/profile/widgets/profile_header_widget.dart';

import '../../../data/constants/assets.dart';
import '../../../data/widgets/custom_app_bar.dart';
import '../controllers/profile_controller.dart';
import '../widgets/followers_popup.dart';
import '../widgets/followings_popup.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingAppIcon: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: InkWell(
              child: SvgPicture.asset(Assets.notification),
              onTap: () {},
            ),
          )
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeaderWidget(
                user: controller.bottomNavController.signedInUser,
                onFollowersPressed: () {
                  Get.dialog(FollowersPopup());
                },
                onFollowingPressed: () {
                  Get.dialog(FollowingsPopup());
                },
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                title: Text(
                  'Interest Areas',
                  style: TextStyle(color: Palette.hintColor, fontSize: 16),
                ),
                subtitle: const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                initiallyExpanded: true,
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.ias.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: Palette.lightColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            controller.ias[index].areaName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 14,
                          )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Posts',
                style: TextStyle(color: Palette.hintColor, fontSize: 16),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.posts.length,
                  itemBuilder: (context, index) {
                    return PostTileWidget(
                      post: controller.posts[index],
                      getAreaNameById: controller.getAreaNameById,
                      getUserNameById: controller.getUserNameById,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
