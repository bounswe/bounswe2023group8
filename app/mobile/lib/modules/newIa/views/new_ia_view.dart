import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';

import '../controllers/new_ia_controller.dart';

class NewIaView extends GetView<NewIaController> {
  const NewIaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
      
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
