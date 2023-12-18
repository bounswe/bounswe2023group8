import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';
import 'package:mobile/data/constants/config.dart';

class LocationView extends StatelessWidget {
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
