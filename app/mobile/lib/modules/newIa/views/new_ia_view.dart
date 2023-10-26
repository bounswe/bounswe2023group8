import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
      body: const Center(
        child: Text(
          'NewIaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
