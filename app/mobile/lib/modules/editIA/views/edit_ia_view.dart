import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/custom_dialogs.dart';
import 'package:mobile/data/widgets/select_circle.dart';

import '../controllers/edit_ia_controller.dart';

class EditIaView extends GetView<EditIaController> {
  const EditIaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leadingAppIcon: true,
          actions: [
            IconButton(
                onPressed: () {
                  Dialogs.showCustomDialog(
                      onAction: () {
                        controller.onDeleteIa();
                        Get.back();
                      },
                      title: 'Delete Bunch',
                      content: Text(
                          'Are you sure you want to delete the ${controller.interestArea.name} bunch?'),
                      cancelText: 'No',
                      actionText: 'Yes');
                },
                icon: Icon(Icons.delete))
          ],
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
                const Text("Edit Bunch!",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    )),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      "Title: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: TextField(
                                controller: controller.titleController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                                onChanged: controller.onChangeTitle,
                              ),
                            )))
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Sub-IAs:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                // Sub-IA list
                const SizedBox(height: 8),

                TextField(
                  onChanged: controller.onChangeSubIaQuery,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.search)),
                ),
                if (controller.searchSubIaResults.isNotEmpty)
                  _searchIaResults(),
                if (controller.selectedSubIas.isNotEmpty) selectedIas(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Tags:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: controller.onChangeTagQuery,
                  onSubmitted: controller.submitTagQuery,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: const Icon(Icons.search)),
                ),
                if (controller.searchTagResults.isNotEmpty) _searchTagResults(),
                if (controller.selectedTags.isNotEmpty) selectedTags(),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Description:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter description here...",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: controller.onChangeDescription,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Access Level:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    SelectCircle(
                        value: controller.accesLevel.value == 0,
                        onTap: (val) {
                          controller.onChangeAccessLevel(0);
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('Public',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const Spacer(),
                    SelectCircle(
                        value: controller.accesLevel.value == 1,
                        onTap: (val) {
                          controller.onChangeAccessLevel(1);
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('Private',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const Spacer(),
                    SelectCircle(
                        value: controller.accesLevel.value == 2,
                        onTap: (val) {
                          controller.onChangeAccessLevel(2);
                        }),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text('Personal',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      fontSize: 14,
                      active: controller.isFormValid,
                      onPressed: controller.onUpdate,
                      text: "Update",
                      inProgress: controller.actionInProgress.value,
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
      child: SizedBox(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tag.label),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.add,
                      size: 16,
                    )
                  ],
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
        height: 100,
        width: Get.width,
        decoration: BoxDecoration(
          color: ThemePalette.light,
          border: Border.all(color: ThemePalette.main, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            for (var tag in controller.selectedTags)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tag.label),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        controller.removeTag(tag);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    )
                  ],
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
      child: SizedBox(
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(ia.name),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.add,
                      size: 16,
                    )
                  ],
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
        height: 100,
        width: Get.width,
        decoration: BoxDecoration(
          color: ThemePalette.light,
          border: Border.all(color: ThemePalette.main, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Wrap(
          children: [
            for (var ia in controller.selectedSubIas)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(ia.name),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        controller.removeSubIa(ia);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
