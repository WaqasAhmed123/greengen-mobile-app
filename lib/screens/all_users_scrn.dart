import 'dart:async';

import 'package:Greengen/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:Greengen/apis/api_services.dart';
import 'package:Greengen/widgets/appbar_show_menu.dart';

import '../model/all_users.dart';
import 'package:Greengen/widgets/container_button.dart';

import '../widgets/folder_options.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key? key}) : super(key: key);

  @override
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final String _selectedOption = '';
  String? constructionSiteId;
  TextEditingController searchController = TextEditingController();

  StreamSubscription<List<AllUsers>>? _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = ApiServices.getUsersFromApi().listen((data) {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    searchController.dispose();
    super.dispose();
  }

  final tableTitleArr = [
    "NOME",
    "COMUNE",
    "VIA",
  ];
  String chkString = "annas";
  bool searchContainer = false;

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
                // scrName: "Casa",
                // navFunc: () {
                //   // Future.delayed(Duration(seconds: 1));
                //   Navigator.pop(context);
                //   // Navigator.push(
                //   //     context,
                //   //     MaterialPageRoute(
                //   //         builder: (context) => const ImageUploadScreen()));
                // }
              ),
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
              padding: const EdgeInsets.only(top: 8),
              child: const Text(
                "Elenco cantieri",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
              child: SizedBox(
                height: 30,

                // width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  autofocus: false,
                  controller: searchController,
                  onChanged: (text) {
                    if (text.isEmpty) {
                      setState(() {
                        searchContainer = false;
                      });
                    } else {
                      setState(() {
                        searchContainer = true;
                      });
                    }
                  },
                  onEditingComplete: () {
                    // if (searchController.text.isEmpty) {
                    //   setState(() {
                    //     searchContainer = false;
                    //   });
                    // }
                    // setState(() {
                    //   searchContainer = true;
                    // });
                    // print(searchController.text);
                    FocusScope.of(context).unfocus();
                    // FocusScope.of(context).requestFocus(FocusNode());
                    // ApiServices.search(keyword: searchController.text);
                  },

                  // onChanged: (text) async {
                  //   // handleSearch();
                  //   print('First text field: $text');
                  //   setState(() {
                  //     searchChk = !searchChk;
                  //   });
                  //   if (text.isNotEmpty) {
                  //     setState(() {
                  //       print("setstate1");
                  //       // searchLoading = true;
                  //       searchContainer = true;
                  //     });
                  //     // Stream<List<AllUsers>> searchList =

                  //     ApiServices.search(keyword: text);
                  //     setState(() {
                  //       print("setstate2");
                  //       // searchLoading = false;
                  //     });
                  //   } else {
                  //     setState(() {
                  //       searchContainer = false;
                  //     });
                  //   }
                  // },
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  decoration: const InputDecoration(
                    hintText: 'Ricerca veloce',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: searchContainer,
              // child: searchList?.map((event) => null)
              child: FutureBuilder(
                future: ApiServices.search(keyword: searchController.text),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AllUsers>> snapshot) {
                  print(searchController.text);
                  // print("streaam builder func run ${searchController.text}");
                  if (snapshot.hasData) {
                    final userList = snapshot.data!;
                    print(userList.length);
                    if (userList.isEmpty) {
                      // return const Center(child: Text('Nessun utente trovato'));
                      return const Center(child: Text('No user found'));
                    }

                    // loadMoreButtonVisible = true;a

                    // List<AllUsers> displayedUsers;
                    // if (userList.length <= limit) {
                    //   displayedUsers = userList;
                    //   loadMore = false;
                    // } else {
                    //   displayedUsers = userList.sublist(0, limit);
                    // }
                    // return Text(searchController.text);
                    return Table(
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
                                      constructionSiteId =
                                          user.value.id.toString();
                                      print(constructionSiteId);
                                      print(_selectedOption);
                                      showUploadOptions(
                                        constructionSiteId: constructionSiteId,
                                        context: context,
                                        selectedOption: _selectedOption,
                                      );
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
                              // TableCell(
                              //   child: Container(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Text(
                              //       user.value.residenceHouseNumber == null
                              //           ? ""
                              //           : user.value.residenceHouseNumber!,
                              //       style: const TextStyle(
                              //         fontSize: 12,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // TableCell(
                              //   child: Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Container(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //           color: Colors.red,
                              //           border: Border.all(color: Colors.red),
                              //           borderRadius:
                              //               BorderRadius.circular(8.0),
                              //         ),
                              //         child: Text(
                              //           user.value.archive == null
                              //               ? ""
                              //               : user.value.archive!,
                              //           style: const TextStyle(
                              //             fontSize: 12,
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // TableCell(
                              //     child: Container(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     color: Colors.yellow,
                              //     child: Text(
                              //       user.value.latestStatus == null
                              //           ? ""
                              //           : user.value.latestStatus!,
                              //       style: const TextStyle(
                              //         fontSize: 12,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ),
                              // ))
                            ],
                          ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print("snapshot11111");
                    print(snapshot);
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Center(
                        child: Text(
                            'Failed To Load Users. Check your Internet Connection'
                            // "Impossibile caricare gli utenti. Controlla la tua connessione Internet"
                            ),
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            // if (loadMoreButtonVisible && loadMore)
            //   ElevatedButton(
            //     onPressed: () => loadMoreEntries(),
            //     child: const Text('Load More'),
            // ),
            Visibility(
              visible: !searchContainer,
              child: StreamBuilder<List<AllUsers>>(
                stream: ApiServices.getUsersFromApi(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AllUsers>> snapshot) {
                  // if (snapshot.data!.isEmpty) {}
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

                    return Table(
                      // defaultColumnWidth: FixedColumnWidth(
                      //     MediaQuery.of(context).size.width * 0.33),
                      // columnWidths: const {
                      //   // 0: FixedColumnWidth(90),
                      //   // 1: FixedColumnWidth(100),
                      //   // 2: FixedColumnWidth(120),
                      //   // 3: FixedColumnWidth(120),
                      //   // 4: FixedColumnWidth(120),
                      //   // 5: FixedColumnWidth(120),
                      // },
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
                                      constructionSiteId =
                                          user.value.id.toString();
                                      print(constructionSiteId);
                                      print(_selectedOption);
                                      showUploadOptions(
                                        constructionSiteId: constructionSiteId,
                                        context: context,
                                        selectedOption: _selectedOption,
                                      );
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
                              // TableCell(
                              //   child: Container(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Text(
                              //       user.value.residenceHouseNumber == null
                              //           ? ""
                              //           : user.value.residenceHouseNumber!,
                              //       style: const TextStyle(
                              //         fontSize: 12,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // TableCell(
                              //   child: Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Container(
                              //       padding: const EdgeInsets.all(8.0),
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //           color: Colors.red,
                              //           border: Border.all(color: Colors.red),
                              //           borderRadius:
                              //               BorderRadius.circular(8.0),
                              //         ),
                              //         child: Text(
                              //           user.value.archive == null
                              //               ? ""
                              //               : user.value.archive!,
                              //           style: const TextStyle(
                              //             fontSize: 12,
                              //             color: Colors.black,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // TableCell(
                              //     child: Container(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Container(
                              //     color: Colors.yellow,
                              //     child: Text(
                              //       user.value.latestStatus == null
                              //           ? ""
                              //           : user.value.latestStatus!,
                              //       style: const TextStyle(
                              //         fontSize: 12,
                              //         color: Colors.black,
                              //       ),
                              //     ),
                              //   ),
                              // ))
                            ],
                          ),
                      ],
                    );
                  } else if (snapshot.error
                          .toString()
                          .contains("Network is unreachable") ||
                      snapshot.error
                          .toString()
                          .contains("Check your Internet Connection")) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 08),
                      child: Center(
                          child: Text(
                              'Failed To Load Users. Check your Internet Connection'
                              // "Impossibile caricare gli utenti. Controlla la tua connessione Internet"
                              )),
                    );
                  } else if (snapshot.hasError) {
                    // return Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 08),
                    //   child: Center(
                    //       child: Text('${snapshot.error.toString()}'
                    //           // "Impossibile caricare gli utenti. Controlla la tua connessione Internet"
                    //           )),
                    // );
                    // Future<void> _showErrorDialog() async {
                    //   return showDialog<void>(
                    //       context: context,
                    //       barrierDismissible: false,
                    //       builder: (BuildContext context) {
                    return Builder(builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Login expired',
                          textAlign: TextAlign.center,
                          // style: TextStyle(),
                        ),
                        content: Text(
                            'Your login session has expired. Please log in again to continue.'),
                        actions: <Widget>[
                          containerButton(
                              context: context,
                              text: "Accedi",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()),
                                );
                              },
                              alert: true
                              // loading: loading
                              ),
                        ],
                      );
                    });
                    // return AlertDialog(
                    //   title: Text('Login expired'),
                    //   content: Text('Login Expired'),
                    //   actions: <Widget>[
                    //     TextButton(
                    //       child: Text('OK'),
                    //       onPressed: () {
                    //         Navigator.of(context).pop(); // Close the dialog
                    //       },
                    //     ),
                    //   ],
                    // );
                    //       });
                    // }

                    // _showErrorDialog();
                    // return Container();
                    // return const Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 08),
                    //   child: Center(
                    //       child: Text('Connection timeout, Please try again!'
                    //           // "Impossibile caricare gli utenti. Controlla la tua connessione Internet"
                    //           )),
                    // );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
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
