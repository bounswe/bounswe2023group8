import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';

import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/modules/home/views/visitor_view.dart';
import 'member_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            Assets.logo,
            height: 30,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 72),
            child: CustomSearchBar(),
          ),
        ],
      ),
      body:  MemberView(),
    );
  }
}

class CustomSearchBar extends StatelessWidget {
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
