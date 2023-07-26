

class AllUsers {
  int? id;
  String? oldId;
  String? name;
  String? surename;
  String? dateOfBirth;
  String? townOfBirth;
  String? province;
  String? residenceStreet;
  String? residenceHouseNumber;
  String? residencePostalCode;
  String? residenceCommon;
  String? residenceProvince;
  String? pageStatus;
  String? archive;
  String? status;
  dynamic pinLocation;
  String? latestStatus;
  String? createdAt;
  String? updatedAt;

  AllUsers({
    this.id,
    this.oldId,
    this.name,
    this.surename,
    this.dateOfBirth,
    this.townOfBirth,
    this.province,
    this.residenceStreet,
    this.residenceHouseNumber,
    this.residencePostalCode,
    this.residenceCommon,
    this.residenceProvince,
    this.pageStatus,
    this.archive,
    this.status,
    this.pinLocation,
    this.latestStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory AllUsers.fromJson(Map<String, dynamic> json) {
    return AllUsers(
      id: json['id'],
      oldId: json['oldid'],
      name: json['name'],
      surename: json['surename'],
      dateOfBirth: json['date_of_birth'],
      townOfBirth: json['town_of_birth'],
      province: json['province'],
      residenceStreet: json['residence_street'],
      residenceHouseNumber: json['residence_house_number'],
      residencePostalCode: json['residence_postal_code'],
      residenceCommon: json['residence_common'],
      residenceProvince: json['residence_province'],
      pageStatus: json['page_status'],
      archive: json['archive'],
      status: json['status'],
      pinLocation: json['pin_location'],
      latestStatus: json['latest_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  // static Stream<List<AllUsers>> getUsersFromApi() async* {
  //   const url = 'https://crm-crisaloid.com/api/constructionUser';
  //   print(await UserModel.getToken());

  //   final response = await http.get(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization': 'Bearer ${await UserModel.getToken()}',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonData = json.decode(response.body);
  //     // print(jsonData);
  //     final userList = List<AllUsers>.from(jsonData['users']
  //             .map((json) => AllUsers.fromJson(json as Map<String, dynamic>)))
  //         .toList();
  //     yield userList;
  //   } else {
  //     throw Exception('Failed to load users from API');
  //   }
  // }
}
