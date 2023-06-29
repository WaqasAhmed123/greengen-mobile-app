import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../screens/login.dart';

List<String> popUpOptionsList = [
  UserModel.name.toString(),
  // UserModel.email.toString()=="null"?"NA":UserModel.email.toString(),
  UserModel.locallyStoredemail.toString(),
  "Ripristina",
  "Disconnettersi"
];
appbarMenuItem({context, scrName, navFunc}) {
  return showMenu(
    context: context,
    position: const RelativeRect.fromLTRB(20, 0, 0, 0),
    items: <PopupMenuEntry>[
      PopupMenuItem(
        child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: popUpOptionsList.map((option) {
              int index = popUpOptionsList.indexOf(option);
              return PopupMenuItem(
                child: GestureDetector(
                  onTap: () async {
                    // Handle option based on index
                    if (index == 0) {
                      // Handle name option
                    } else if (index == 1) {
                      // Handle email option
                    } else if (index == 2) {
                      // Handle password reset option
                    } else if (index == 3) {
                      if (await UserModel.logout() == true) {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false,
                        );
                      }
                      // Handle logout option
                    }
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Text(
                      option,
                      style: TextStyle(
                        color: index == 2 || index == 3
                            ? Colors.blue
                            : index == 1
                                ? Colors.black.withOpacity(0.5)
                                : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            }).toList()),
      ),
      PopupMenuItem(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Divider(
          height: 0,
          color: Colors.black.withOpacity(0.3),
        ),
      )),
      PopupMenuItem(
          child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
          navFunc();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 1,
            child: Text(
              scrName,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      )),
    ],
  );
}

Widget showPopUp({context, scrName, navFunc}) {
  return GestureDetector(
    onTap: () =>
        appbarMenuItem(context: context, scrName: scrName, navFunc: navFunc),
    child: Container(
      child: Row(
        children: [
          Text(
            popUpOptionsList[0].toString(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Icon(
            Icons.person,
            color: Colors.white,
            size: 14,
          )
          // IconButton(
          //     onPressed: (){} ,
          //     icon: const Icon(
          //       Icons.person,
          //       color: Colors.white,
          //       size: 14,
          //     )),
        ],
      ),
    ),
  );
}

Widget showMenuOptions({text}) {
  return ListTile(
    leading: Text(text),
  );
}
