import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';
import 'package:mobile/data/widgets/post_detail_widget.dart';

import '../controllers/new_ia_controller.dart';

class NewIaView extends GetView<NewIaController> {
  const NewIaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          leadingAppIcon: true,
        ),
        body: Obx(() {
          if (controller.routeLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Create a new Interest Area!",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 26,
                    )),
                SizedBox(height: 40),
                Row(
                  children: [
                    Text(
                      "Title: ",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    Expanded(
                        child: Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: TextField(
                                controller: controller.titleController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22,
                                ),
                              ),
                            )))
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  "Sub-IAs:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 4),
                // Sub-IA list
                SizedBox(height: 8),
                TextField(
                  controller: controller.subIASearchController,
                  onChanged: (_) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.search)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Tags:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 4),
                // Tag list
                SizedBox(height: 8),
                TextField(
                  controller: controller.tagSearchController,
                  onChanged: (_) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.search)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Related IAs:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 4),
                // Related IAs list
                SizedBox(height: 8),
                TextField(
                  controller: controller.relatedIASearchController,
                  onChanged: (_) {},
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.search)),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Description:",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 4),
                // Related IAs list
                SizedBox(height: 8),
                TextField(
                  controller: controller.descriptionController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    hintText: "Enter description here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Create"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0B68B1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                        minimumSize: Size(100, 50),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }));
  }
}
