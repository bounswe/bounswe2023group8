import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';

import '../controllers/new_post_controller.dart';

class NewPostView extends GetView<NewPostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Text(
          'NewPostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
