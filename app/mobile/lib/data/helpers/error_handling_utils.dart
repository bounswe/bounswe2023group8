import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/palette.dart';
import '../models/custom_exception.dart';

class ErrorHandlingUtils {
  static void handleApiError(dynamic error) {
    String title;
    String message;

    if (error is CustomException) {
      title = error.message;
      message = error.errors;
    } else {
      title = 'Error';
      message = 'An error occurred. Please try again later';
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.brown,
      borderRadius: 0,
      colorText: Colors.white,
      margin: EdgeInsets.zero,
    );
  }
}
