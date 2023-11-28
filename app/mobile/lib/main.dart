import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/routes/app_pages.dart';


void main() async {
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      title: "Application",
      theme: ThemeData(fontFamily: 'Inter'),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
