import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/modules/settings/views/privacy_view.dart';

import '../controllers/visitor_settings_controller.dart';

class VisitorSettingsView extends GetView<VisitorSettingsController> {
  const VisitorSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PrivacyPolicyView();
  }
}
