import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/user_model.dart';

Widget buildImageWidget({int? index, pickedImagesPath, context}) {
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Image.file(
              File(pickedImagesPath[index]),
              fit: BoxFit.contain,
            ),
          );
        },
      );
    },
    child: Container(
      padding: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.4),
      //       blurRadius: 10,
      //       offset: const Offset(0, 0), // Shadow position
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   width: double.infinity,
          //   height: 100,
          //   child: Image.file(
          //     File(pickedImagesPath[index]),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  File(pickedImagesPath[index]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd/MM/yy').format(DateTime.now()),
                  style: const TextStyle(color: Colors.grey, fontSize: 9),
                ),
                const Spacer(),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.download,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Scarica',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 8),
                              Text('Elimina',
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              "Caricato da:",
              style: TextStyle(color: Colors.black, fontSize: 9),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  "${UserModel.name}",
                  style: const TextStyle(color: Colors.black, fontSize: 9),
                ),
                const Spacer(),
                Text(
                  DateFormat('dd/MM/yy').format(DateTime.now()),
                  style: const TextStyle(color: Colors.grey, fontSize: 9),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
