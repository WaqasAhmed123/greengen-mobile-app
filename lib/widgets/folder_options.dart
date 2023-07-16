import 'package:flutter/material.dart';

import '../screens/img_upload_scrn.dart';

void showUploadOptions({
  required BuildContext context,
  String? selectedOption,
   String? constructionSiteId,
}) {
  bool optionSelected = false; // Flag to check if an option is selected

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Upload Options'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: const Text('ante'),
                  value: 'ante',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      optionSelected = true;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('cantiere'),
                  value: 'cantiere',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      optionSelected = true;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('post'),
                  value: 'post',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      optionSelected = true;
                    });
                  },
                ),
                RadioListTile<String>(
                  title: const Text('durante'),
                  value: 'durante',
                  groupValue: selectedOption,
                  onChanged: (value) {
                    setState(() {
                      selectedOption = value!;
                      optionSelected = true;
                    });
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (optionSelected) {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageUploadScreen(
                          selectedOption!,
                          constructionSiteId: constructionSiteId,
                        ),
                      ),
                    );
                  } else {
                    // No option is selected, show an error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select an option'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: const Text('Upload'),
              ),
            ],
          )
        ],
      );
    },
  );
}
