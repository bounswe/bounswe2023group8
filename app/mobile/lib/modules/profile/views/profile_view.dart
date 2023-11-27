import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/bunch_widget.dart';
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
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 50),
        child: Obx(() {
          if (controller.routeLoading.value) {
            return SizedBox(
                height: Get.height - 200,
                child: const Center(child: CircularProgressIndicator()));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeaderWidget(
                user: controller.userProfile,
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
                  'Bunches',
                  style: TextStyle(color: ThemePalette.dark, fontSize: 16),
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
                        return BunchWidget(
                            ia: controller.ias[index],
                            onTap: () =>
                                controller.navigateToIa(controller.ias[index]));    
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
                'Spots',
                style: TextStyle(color: ThemePalette.dark, fontSize: 16),
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
                      onTap: () => controller
                          .navigateToPostDetails(controller.posts[index]),
                      post: controller.posts[index],
                      hideTags: false,
                    );
                  })
            ],
          );
        }
          ),
        
      ),
    );
  }
}
