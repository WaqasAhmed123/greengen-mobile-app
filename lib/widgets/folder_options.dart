import 'package:flutter/material.dart';

import '../screens/img_upload_scrn.dart';

void showUploadOptions({context, selectedOption, constructionSiteId}) {
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
                  // print(constructionSiteId);
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageUploadScreen(selectedOption,
                          constructionSiteId: constructionSiteId),
                    ),
                  );
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
