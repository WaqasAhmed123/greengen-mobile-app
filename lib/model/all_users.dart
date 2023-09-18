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
}
