import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/post_detail_widget.dart';

import '../controllers/new_ia_controller.dart';

class NewIaView extends GetView<NewIaController> {
  const NewIaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('NewIaView'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
          child: ListView.builder(
              itemCount: controller.posts.length,
              itemBuilder: (context, index) {
                final post = controller.posts[index];
                return PostDetailWidget(
                    post: post,
                    getProfileImageById: controller.getProfileImageById,
                    getIANameById: controller.getIaNameById,
                    getNameSurnameById: controller.getNameSurnameById);
              }),
        ));
  }
}
