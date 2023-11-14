import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_post_controller.dart';

class EditPostView extends GetView<EditPostController> {

  final EditPostController editPostController = Get.put(EditPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
        centerTitle: true,
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
              const SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                    children:   [
                    const Text("Tags"),
                    SizedBox(width: 20,),
                    ElevatedButton(
                        onPressed: () => controller.showSuggestionModal(context),
                        child: const Text("Add")
                    ),
                    const SizedBox(width: 20,),
                      Obx(() =>
                          Row(
                            children:
                            controller.tags.map<Widget>((element) => ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: InkWell (child: Container(
                                  color: Colors.grey, // Set the grey background color
                                  margin: const EdgeInsets.all(1.0), // Add margin between rows
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(4.0), // Adjust padding as needed
                                    child: Text(
                                      "- #${element}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors
                                            .black54, // Text color inside the grey background
                                      ),
                                    ),
                                  ),
                                ), onTap: (){
                                    editPostController.removeTag(element);
                                },
                                )
                            )).toList()
                            ,
                          )
                      ),
                      // child: Obx(() => Text("Tags:  ${controller.tags.join(', ')}")),

                  ],
                ),
              ),
              Row(
                children: [
                  const Flexible(
                    child: Text("Label")
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: () => controller.showLabelModal(context),
                      child: Obx(() => Text(controller.label.value == '' ? "Choose" : "#${controller.label}"))
                  )
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
              SizedBox(height: 20,),
              InkWell(
                  onTap: () => controller.pickDate(),
                  child:
                      Obx(() =>
                        InkWell(onTap: () => editPostController.pickDate(),
                          child:
                              Row(
                                children: [
                                  Text("Publication Date: "),
                                  SizedBox(width: 10,),
                                  Text(
                                      "${controller.publicationDate.value == '' ? 'Pick a Date' : controller.publicationDate}"
                                    // enabled: false,
                                    // decoration: const InputDecoration(labelText: 'Publication Date'),
                                    // onChanged: (value) => controller.publicationDate(value),
                                    // maxLines: null,
                                    // keyboardType: TextInputType.multiline,
                                  ),
                                ],
                              )
                        ),
                      )
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Location'),
                onChanged: (value) => controller.location(value),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              // Add other fields like tags, label, source, etc.
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => print(1),
                // onPressed: () => controller.createPost(),
                child: const Text('Edit Post'),
              ),
              const SizedBox(height: 60),
            ],
          ),
        )

      ),
    );
  }
}
