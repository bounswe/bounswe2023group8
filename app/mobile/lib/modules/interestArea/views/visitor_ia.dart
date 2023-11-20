// visitor_interest_area_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:mobile/data/widgets/post_widget.dart';
import '../../../data/widgets/visitor_bottom_bar.dart';
import '../../opening/controllers/opening_controller.dart';
import '../controllers/ia_controller.dart';
import '../../../data/widgets/custom_app_bar.dart';


class VisitorInterestAreaView extends GetView<InterestAreaController> {
  const VisitorInterestAreaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: VisitorBottomBar(
          onLoginPressed: () => Get.find<OpeningController>().backToAuth(true),
          onSignUpPressed: () =>
              Get.find<OpeningController>().backToAuth(false)),
        appBar: const CustomAppBar(
          leadingAppIcon: true,
          titleWidget: CustomSearchBar(),
        ),
      body: const VisitorInterestBody(),
    );
  }
}
class VisitorInterestBody extends GetView<InterestAreaController>  {
  const VisitorInterestBody({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child:
        Padding(
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
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "JANE AUSTEN MOVIES",
                            style: TextStyle(
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
              const SizedBox(height: 5,),
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
              const SizedBox(height: 5,),
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
        )    
       
      )



    );
  }
}

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 30,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF9A9A9A), width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Icon(Icons.search, color: const Color(0xFF9A9A9A)),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }
}