import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/home/controllers/home_controller.dart';

import '../../../data/widgets/custom_app_bar.dart';
import '../../../data/widgets/custom_search_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
          titleWidget: CustomSearchBar(),
        ),
      body: Container()
    );
  }
}
