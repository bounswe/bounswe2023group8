import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/constants/palette.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/custom_button.dart';

import '../controllers/new_post_controller.dart';

class NewPostView extends GetView<NewPostController> {
  const NewPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
        ),
        body: Obx(() {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Create a new Spot!",
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
                Row(
                  children: [
                    const Text(
                      "Bunch:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () => controller.showIaSelectionModal(context),
                      child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child:
                                Text(controller.selectedIa.value?.name ?? ''),
                          )),
                    ))
                  ],
                ),
                const SizedBox(height: 4),
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
                  "Content:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 5,
                  controller: controller.contentController,
                  decoration: InputDecoration(
                    hintText: "Enter content here...",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: controller.onChangeContent,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Source:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: controller.sourceLinkController,
                  decoration: InputDecoration(
                    hintText: "Enter source here...",
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: controller.onChangeContent,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Label:",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                        child: InkWell(
                      onTap: () => controller.showLabelSelectionModal(context),
                          child: Container(
                          height: 36,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F1F1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Text(
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
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          )),
                    ))
                  ],
                ),
                
                
                const SizedBox(
                  height: 20,
                ),
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
                  height: 10,
                ),
                InkWell(
                    onTap: controller.navigateToSelectAddress,
                    child: Row(
                      children: [
                        const Text("Location: "),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          controller.address.value == ''
                              ? 'Select Location'
                              : '${controller.address.value.substring(0, 30)}...',
                        ),
                      ],
                    )),


                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      fontSize: 14,
                      active: controller.isFormValid,
                      onPressed: controller.onCreatePost,
                      text: "Spot",
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
}

