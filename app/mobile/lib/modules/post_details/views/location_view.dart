import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/constants/config.dart';
import 'package:mobile/modules/newPost/controllers/new_post_controller.dart';

class LocationView extends GetView<NewPostController> {
  final LatLng? currentLatLng;
  const LocationView({super.key, this.currentLatLng});

  @override
  Widget build(BuildContext context) {
    return MapLocationPicker(
      apiKey: Config.googleApiKey,
      currentLatLng: currentLatLng,
      hideMoreOptions: true,
      hideBottomCard: true,
      hideLocationButton: true,
      hideSuggestionsOnKeyboardHide: true,
    );
  }
}
