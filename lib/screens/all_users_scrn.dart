import 'package:flutter/material.dart';

import '../model/all_users.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});
  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final allUsers = AllUsers();
  final tableTitleArr = [
    "NOME",
    "COMUNE",
    "VIA",
    "TECHNICO",
    "DOCUMENTI",
    "STATO"
  ];

  // final userData = [
  //   "AFFATATO ROCCO",
  //   "PUTIGNANO",
  //   "S.C.S.CATALDO STRETTOLA n. 6",
  //   "ARTURO DE MARCO",
  //   "12/11",
  //   "Saldo Enea In Attesa",
  // ];

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
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
                // height: 32,
              ),
              const Spacer(),
              const Text(
                'PASQUALE',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4.0),
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 14.0,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: Container(
        //   width: MediaQuery.of(context).size.width*0.8,
        //   margin: EdgeInsets.only(left: 16),
        //   child: Image.asset(
        //     'assets/pictures/logo.png',
        //     width:50,
        //     height: 32,
        //   ),
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1.0,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "Users List",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            StreamBuilder<List<AllUsers>>(
              stream: AllUsers.getUsersFromApi(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<AllUsers>> snapshot) {
                if (snapshot.hasData) {
                  final userList = snapshot.data!;
                  // userList.map((e) => print(e.id));
                  // for (var i in userList) {
                  //   print(i.name);
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
                        // for (int i = 0; i < tableTitleArr.length; i++)
                        //   i: FixedColumnWidth(120)
                      },
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(width: 2.0))),
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
                        // for (int i = 0; i < 5; i++)
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    (user.value.name == null
                                            ? ""
                                            : user.value.name!) +
                                        (user.value.surename == null
                                            ? ""
                                            : user.value.surename!),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
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
                                        : user.value.residenceStreet!,
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
                                ),
                              ),
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
          ],
        ),
      ),
    ));
  }
}
