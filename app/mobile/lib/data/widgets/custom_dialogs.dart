import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/palette.dart';

class Dialogs {
  static void showCustomDialog(
      {required void Function() onAction,
      void Function()? onCancel,
      required String title,
      required Widget content,
      required String cancelText,
      required String actionText}) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
              color: ThemePalette.light,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Center(
              child: Text(title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))),
        ),
        content: content,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ThemePalette.dark,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  onPressed: onCancel ??
                      () {
                        Get.back();
                      },
                  child: Text(cancelText,
                      style: TextStyle(
                          color: ThemePalette.light,
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  onPressed: onAction,
                  style: TextButton.styleFrom(
                    backgroundColor: ThemePalette.negative,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Text(actionText,
                      style: TextStyle(
                          color: ThemePalette.light,
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
