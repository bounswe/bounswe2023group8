import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/assets.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/select_circle.dart';

import '../controllers/new_ia_controller.dart';

class NewIaView extends GetView<NewIaController> {
  const NewIaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
          search: false,
          notification: false,
          actions: [],
        ),
        body: Obx(() {
          if (controller.routeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: BackgroundPalette.dark,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: const Center(
                    child: Text("Create a new Bunch!",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.regular,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bunch Name: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ThemePalette.dark),
                      ),
                      Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: BackgroundPalette.light,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ThemePalette.dark),
                              onChanged: controller.onChangeTitle,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.regular,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ThemePalette.dark),
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: BackgroundPalette.light,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              maxLines: 5,
                              decoration: const InputDecoration(
                                hintText: "Enter description here...",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                border: InputBorder.none,
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: ThemePalette.dark),
                              onChanged: controller.onChangeDescription,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.regular,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Access Level: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ThemePalette.dark),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SelectCircle(
                                  value: controller.accesLevel.value == 0,
                                  onTap: (val) {
                                    controller.onChangeAccessLevel(0);
                                  }),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.public,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text('Public',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ThemePalette.main,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SelectCircle(
                                  value: controller.accesLevel.value == 1,
                                  onTap: (val) {
                                    controller.onChangeAccessLevel(1);
                                  }),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.private,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text('Private',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ThemePalette.main)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              SelectCircle(
                                  value: controller.accesLevel.value == 2,
                                  onTap: (val) {
                                    controller.onChangeAccessLevel(2);
                                  }),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                Assets.personal,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text('Personal',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: ThemePalette.main,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ])),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.regular,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tags:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ThemePalette.dark),
                          ),
                          const SizedBox(height: 4),
                          if (controller.selectedTags.isNotEmpty)
                            selectedTags(),
                          const SizedBox(height: 6),
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: BackgroundPalette.light,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: controller.onChangeTagQuery,
                              onSubmitted: controller.submitTagQuery,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: ThemePalette.dark),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ])),
                if (controller.searchTagResults.isNotEmpty) _searchTagResults(),
                const SizedBox(height: 10),
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: BackgroundPalette.regular,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sub-Bunches:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: ThemePalette.dark),
                          ),
                          const SizedBox(height: 4),
                          if (controller.selectedSubIas.isNotEmpty)
                            selectedIas(),
                          const SizedBox(height: 6),
                          Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: BackgroundPalette.light,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: controller.onChangeSubIaQuery,
                              onSubmitted: controller.submitSubIaQuery,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12,
                                  color: ThemePalette.dark),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ])),
                if (controller.searchSubIaResults.isNotEmpty)
                  _searchIaResults(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      fontSize: 14,
                      active: controller.isFormValid,
                      onPressed: controller.onCreate,
                      text: "Create",
                      inProgress: controller.createInProgress.value,
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }

  Widget _searchTagResults() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: ThemePalette.dark,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.searchTagResults.length,
          itemBuilder: (context, index) {
            var tag = controller.searchTagResults[index];
            return InkWell(
              onTap: () {
                controller.addTag(tag);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: SeparatorPalette.light,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text('#${tag.label}',
                      style: TextStyle(
                          color: SeparatorPalette.dark,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget selectedTags() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 90,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Wrap(
          children: [
            for (var tag in controller.selectedTags)
              InkWell(
                onTap: () {
                  controller.removeTag(tag);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: SeparatorPalette.light,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('#${tag.label}',
                      style: TextStyle(
                          color: SeparatorPalette.dark,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _searchIaResults() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: ThemePalette.dark,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.searchSubIaResults.length,
          itemBuilder: (context, index) {
            var ia = controller.searchSubIaResults[index];
            return InkWell(
              onTap: () {
                controller.addSubIa(ia);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: BackgroundPalette.solid,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(ia.name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget selectedIas() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 90,
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Wrap(
          children: [
            for (var ia in controller.selectedSubIas)
              InkWell(
                onTap: () {
                  controller.removeSubIa(ia);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8, bottom: 4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.solid,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(ia.name,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 12)),
                ),
              )
          ],
        ),
      ),
    );
  }
}
