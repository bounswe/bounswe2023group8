import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/data/widgets/custom_app_bar.dart';

import '../controllers/new_post_controller.dart';

class NewPostView extends GetView<NewPostController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Create Post',
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Interest Area'),
              onChanged: (value) => controller.interestArea(value),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) => controller.title(value),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Link'),
              onChanged: (value) => controller.link(value),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) => controller.description(value),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const Text("Tags"),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => controller.showSuggestionModal(context),
                      child: const Text("Add")),
                  const SizedBox(
                    width: 20,
                  ),
                  Obx(() => Row(
                        children: controller.tags
                            .map<Widget>((element) => ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: Container(
                                  color: Colors
                                      .grey, // Set the grey background color
                                  margin: const EdgeInsets.all(
                                      1.0), // Add margin between rows
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        4.0), // Adjust padding as needed
                                    child: Text(
                                      "#${element}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors
                                            .black54, // Text color inside the grey background
                                      ),
                                    ),
                                  ),
                                )))
                            .toList(),
                      )),
                  // child: Obx(() => Text("Tags:  ${controller.tags.join(', ')}")),
                ],
              ),
            ),
            Row(
              children: [
                Flexible(
                    child: Obx(
                  () => controller.label.value != ''
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            color: Colors.grey, // Set the grey background color
                            margin: const EdgeInsets.all(
                                1.0), // Add margin between rows
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  4.0), // Adjust padding as needed
                              child: Text(
                                "#${controller.label}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors
                                      .black54, // Text color inside the grey background
                                ),
                              ),
                            ),
                          ))
                      : const Text("Label"),
                )),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () => controller.showLabelModal(context),
                    child: Text(
                        controller.label.value == '' ? "Choose" : "Change"))
              ],
            ),
            // TextField(
            //   decoration: const InputDecoration(labelText: 'Label'),
            //   onChanged: (value) => controller.label(value),
            //   maxLines: null,
            //   keyboardType: TextInputType.multiline,
            // ),
            TextField(
              decoration: const InputDecoration(labelText: 'Source'),
              onChanged: (value) => controller.source(value),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () => controller.pickDate(),
                child: Obx(
                  () => InkWell(
                      onTap: () => controller.pickDate(),
                      child: Row(
                        children: [
                          Text("Publication Date: "),
                          SizedBox(
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
                )),
            TextField(
              decoration: const InputDecoration(labelText: 'Location'),
              onChanged: (value) => controller.location(value),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            // Add other fields like tags, label, source, etc.
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.onCreatePost,
              // onPressed: () => controller.createPost(),
              child: const Text('Create Post'),
            ),
            const SizedBox(height: 60),
          ],
        ),
      )),
    );
  }
}
