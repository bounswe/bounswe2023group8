import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_post_controller.dart';

class NewPostView extends GetView<NewPostController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NewPostView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NewPostView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
