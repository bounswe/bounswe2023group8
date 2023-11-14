import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';

import '../../../data/widgets/custom_app_bar.dart';
import 'member_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
          titleWidget: CustomSearchBar(),
        ),
      body:  MemberView(),
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
