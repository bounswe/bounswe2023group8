import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobile/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:mobile/modules/newPost/providers/new_post_provider.dart';

class NewPostController extends GetxController {
  // Observable variable for text input
  var inputText = ''.obs;
  var interestArea = ''.obs;
  var title = ''.obs;
  var link = ''.obs;
  var description = ''.obs;
  var tags = [].obs;
  var label = ''.obs;
  var source = ''.obs;
  var publicationDate = ''.obs;
  var location = ''.obs;
  // Static list of suggestions
  final List<String> allSuggestions = [
    "Suggestion 1",
    "Suggestion 2",
    "Suggestion 3",
    "Suggestion 4",
    "Suggestion 5",
    // ... more suggestions
  ];
  // Observable list of shown suggestions
  var shownSuggestions = <String>[].obs;

  final bottomNavController = Get.find<BottomNavigationController>();
  final newPostProvider = Get.find<NewPostProvider>();

  @override
  void onInit() {
    super.onInit();
    // Initially, all suggestions are shown
    shownSuggestions.value = allSuggestions;
  }

  void pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      publicationDate.value = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void onCreatePost() async {
    newPostProvider.createNewPost(
        title: 'title',
        description: 'description',
        tags: [],
        token: 'token',
        link: '');
  }

  void updateSuggestions(String input) {
    if (input.isEmpty) {
      shownSuggestions.value = allSuggestions;
    } else {
      // Filter the list of suggestions based on the input text
      shownSuggestions.value = allSuggestions
          .where((suggestion) =>
              suggestion.toLowerCase().contains(input.toLowerCase()))
          .toList();
    }
  }

  void showSuggestionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Type something',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: updateSuggestions,
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: shownSuggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(shownSuggestions[index]),
                        onTap: () {
                          String suggestionToAdd = shownSuggestions[index];
                          if (!tags.contains(suggestionToAdd)) {
                            // If it's not in the list, add it
                            tags.add(suggestionToAdd);
                          }
                          print(tags);
                          // Handle the tap event on a suggestion
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLabelModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Type something',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: updateSuggestions,
              ),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: shownSuggestions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(shownSuggestions[index]),
                        onTap: () {
                          label.value = shownSuggestions[index];
                          print(15);
                          print(label);
                          // Handle the tap event on a suggestion
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onClose() {}
}
