import 'dart:async';

import 'package:flutter/material.dart';
import 'package:greengen/apis/api_services.dart';
import 'package:greengen/widgets/appbar_show_menu.dart';

import '../model/all_users.dart';
import '../widgets/folder_options.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final String _selectedOption = '';
  String? constructionSiteId;

  StreamSubscription<List<AllUsers>>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = ApiServices.getUsersFromApi().listen((data) {
      // handle stream data
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  final tableTitleArr = [
    "NOME",
    "COMUNE",
    "VIA",
    "TECHNICO",
    "DOCUMENTI",
    "STATO"
  ];

  int limit = 10;
  bool loadMore = true;
  bool loadMoreButtonVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/pictures/logo.png',
                width: 100,
              ),
              const Spacer(),
              showPopUp(
                  context: context,
                  scrName: "Casa",
                  navFunc: () {
                    // Future.delayed(Duration(seconds: 1));
                    Navigator.pop(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const ImageUploadScreen()));
                  }),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Elenco utenti",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            StreamBuilder<List<AllUsers>>(
              stream: ApiServices.getUsersFromApi(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AllUsers>> snapshot) {
                if (snapshot.hasData) {
                  final userList = snapshot.data!;

                  // loadMoreButtonVisible = true;

                  // List<AllUsers> displayedUsers;
                  // if (userList.length <= limit) {
                  //   displayedUsers = userList;
                  //   loadMore = false;
                  // } else {
                  //   displayedUsers = userList.sublist(0, limit);
                  // }

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(90),
                        1: FixedColumnWidth(100),
                        2: FixedColumnWidth(120),
                        3: FixedColumnWidth(120),
                        4: FixedColumnWidth(120),
                        5: FixedColumnWidth(120),
                      },
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(width: 2.0)),
                          ),
                          children: tableTitleArr.map((title) {
                            return TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        // for (var user in displayedUsers.asMap().entries)
                        for (var user in userList.asMap().entries)
                          TableRow(
                            decoration: BoxDecoration(
                              color: user.key % 2 != 0
                                  ? Colors.white
                                  : Colors.grey.shade200,
                            ),
                            children: [
                              TableCell(
                                child: Container(
                                  // width: (user.value.surename?.length ?? 0) * 50.0, // Adjust the multiplication factor to your desired width per character
                                  child: InkWell(
                                    onTap: () {
                                      showUploadOptions(
                                        constructionSiteId:constructionSiteId,
                                        context: context,
                                        selectedOption: _selectedOption,
                                      );
                                      constructionSiteId =
                                          user.value.id!.toString();
                                      print(constructionSiteId);
                                      
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${user.value.surename == null ? "" : user.value.surename!} ${user.value.name == null ? "" : user.value.name!}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  // color: user.value.,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    user.value.residenceCommon == null
                                        ? ""
                                        : user.value.residenceCommon!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    user.value.residenceStreet == null
                                        ? ""
                                        : "${user.value.residenceStreet!} ${user.value.residenceHouseNumber == null ? "" : user.value.residenceHouseNumber!} ${user.value.residencePostalCode == null ? "" : user.value.residencePostalCode!}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    user.value.residenceHouseNumber == null
                                        ? ""
                                        : user.value.residenceHouseNumber!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        border: Border.all(color: Colors.red),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Text(
                                        user.value.archive == null
                                            ? ""
                                            : user.value.archive!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                  child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.yellow,
                                  child: Text(
                                    user.value.latestStatus == null
                                        ? ""
                                        : user.value.latestStatus!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ))
                            ],
                          ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // if (loadMoreButtonVisible && loadMore)
            //   ElevatedButton(
            //     onPressed: () => loadMoreEntries(),
            //     child: const Text('Load More'),
            //   ),
          ],
        ),
      ),
    );
  }

  // void loadMoreEntries() {
  //   setState(() {
  //     limit += 10;
  //     loadMoreButtonVisible = false;
  //   });
  // }
}
