// interest_area_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_search_bar.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import '../controllers/ia_controller.dart';
import '../../../data/widgets/custom_app_bar.dart';


class InterestAreaView extends GetView<InterestAreaController> {
  const InterestAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
          titleWidget: CustomSearchBar(),
        ),
      body:  InterestBody(),
    );
  }
}
class InterestBody extends GetView<InterestAreaController>  {

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.routeLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container(
          color: Colors.white,
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
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
                            padding: EdgeInsets.all(4.0),
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
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          color: Colors.grey.shade400,
                          margin: const EdgeInsets.all(1.0),
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "Tags: #Jane Austen #Literature #Cinema",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
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
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.posts.length,
                    itemBuilder: (context, index) {
                      return PostTileWidget(
                        onTap: () => controller
                            .navigateToPostDetails(controller.posts[index]),
                        post: controller.posts[index],
                        getAreaNameById: controller.getAreaNameById,
                        getUserNameById: controller.getUserNameById,
                        hideTags: true,
                      );
                    })
              ],
            ),
          ))
        
        
        
        );
    }
    );
  }
}

