import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/new_post_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NewPostView extends GetView<NewPostController> {

  final NewPostController newPostController = Get.put(NewPostController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
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
              Row(
                children: [
                  Flexible(
                    child: Obx(() => Text("Tags:  ${controller.tags.join(', ')}")),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: () => controller.showSuggestionModal(context),
                      child: const Text("Add")
                  )
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Obx(() => Text("Label:  ${controller.label}")),
                  ),
                  const SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: () => controller.showLabelModal(context),
                      child: const Text("Add")
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
                        InkWell(onTap: () => newPostController.pickDate(),
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
                child: const Text('Create Post'),
              ),
              const SizedBox(height: 60),
            ],
          ),
        )

      ),
    );
  }
}
