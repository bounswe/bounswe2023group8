import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/constants/config.dart';
import 'package:mobile/modules/newPost/controllers/new_post_controller.dart';

class SelectLocationView extends GetView<NewPostController> {
  const SelectLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return MapLocationPicker(
      apiKey: Config.googleApiKey,
      currentLatLng: const LatLng(41.083556, 29.050598),
      onNext: controller.onSelectAddress,
    );
  }
}
