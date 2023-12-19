import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportDialog extends StatelessWidget {
  final String title;
  final void Function(String) onReport;
  const ReportDialog({super.key, required this.title, required this.onReport});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Theme(
        data: ThemeData(
          dialogBackgroundColor:
              const Color(0xFFF6F6F6), // Set the background color
        ),
        child: SimpleDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                IconButton(
                  icon: const Icon(Icons.close), // Close icon
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
            children: [
              const Divider(),
              SizedBox(
                  width: Get.width - 40,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Reason for reporting',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          onReport(controller.text);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Report'),
                      )
                    ],
                  )),
            ]));
  }
}
