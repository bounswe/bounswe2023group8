import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';
import 'package:mobile/data/widgets/select_circle.dart';

import '../../../data/constants/assets.dart';
import '../controllers/new_post_controller.dart';

class NewPostView extends GetView<NewPostController> {
  const NewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.routeLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: const CustomAppBar(
            leadingAppIcon: true,
            search: false,
            notification: false,
            actions: [],
          ),
          body: SingleChildScrollView(
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
                    child: Text("Create a new Spot!",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white)),
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
                        "Bunch: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ThemePalette.dark),
                      ),
                      const SizedBox(height: 8),
                      Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: BackgroundPalette.light,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            onTap: () =>
                                controller.showIaSelectionModal(context),
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set the width to screen width
                                height: 36,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF7EA4B9),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 4),
                                  child: Text(
                                    controller.selectedIa.value?.name ?? '',
                                    style: const TextStyle(
                                      color: Color(0xFFEEF0EB),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )),
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 8),
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
                        "Title: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ThemePalette.dark),
                      ),
                      const SizedBox(height: 8),
                      Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFAF6),
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
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: BackgroundPalette.regular,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "Label: ",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            controller.showLabelSelectionModal(context),
                        child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFF7EA4B9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16,
                                top: 4,
                                right: 16), // Added right padding
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.label.value == 0
                                      ? "Documentation"
                                      : controller.label.value == 1
                                          ? "Learning"
                                          : controller.label.value == 2
                                              ? "News"
                                              : controller.label.value == 3
                                                  ? "Research"
                                                  : "Discussion",
                                  style: const TextStyle(
                                    color: Color(0xFFFFFAF6),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                                const Icon(
                                  size: 34,
                                  Icons.arrow_drop_down,
                                  color: Color(0xFF203376),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                        "Source: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ThemePalette.dark),
                      ),
                      const SizedBox(height: 8),
                      Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFAF6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: controller.sourceLinkController,
                              onChanged: controller.onChangeSourceLink,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
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
                        "Location: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: ThemePalette.dark),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFAF6),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Center(
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      controller.address.value == ''
                                          ? 'Select Location'
                                          : controller.address.value,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: controller.navigateToSelectAddress,
                            child: Image.asset(
                              Assets.geolocation,
                              width: 36,
                              height: 36,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
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
                            fontSize: 20,
                            color: ThemePalette.dark),
                      ),
                      const SizedBox(height: 8),
                      Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFAF6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: TextField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              controller: controller.contentController,
                              onChanged: controller.onChangeContent,
                            ),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
                Row(
                  children: [
                    SelectCircle(
                        value: controller.isAgeRestricted.value,
                        onTap: (val) {
                          controller.onChangeIsAgeRestricted();
                        }),
                    const Text(" Age Restricted Content"),
                  ],
                ),
                const SizedBox(height: 8),
                InkWell(
                    onTap: () => controller.pickDate(),
                    child: Row(
                      children: [
                        const Text("Publication Date: "),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            "${controller.publicationDate.value == '' ? 'Pick a Date' : controller.publicationDate}"
                            // enabled: false,
                            // decoration: const InputDecoration(labelText: 'Publication Date'),
                            // onChanged: (value) => controller.publicationDate(value),
                            // maxLines: null,
                            // keyboardType: TextInputType.multiline,
                            ),
                      ],
                    )),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      fontSize: 20,
                      active: controller.isFormValid,
                      onPressed: controller.onCreatePost,
                      text: "Spot",
                      inProgress: controller.createInProgress.value,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchTagResults() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF486376),
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
}
