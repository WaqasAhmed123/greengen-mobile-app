class FetchedImagesModel {
  final int id;
  final int constructionSiteId;
  final int uploadedBy;
  final String name;
  final String folder;
  final String path;
  final String status;
  final String version;
  final DateTime createdAt;
  final DateTime updatedAt;

  FetchedImagesModel({
    required this.id,
    required this.constructionSiteId,
    required this.uploadedBy,
    required this.name,
    required this.folder,
    required this.path,
    required this.status,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FetchedImagesModel.fromJson(Map<String, dynamic> json) {
    return FetchedImagesModel(
      id: json['id'],
      constructionSiteId: json['construction_site_id'],
      uploadedBy: json['uploaded_by'],
      name: json['name'],
      folder: json['folder'],
      path: json['path'],
      status: json['status'],
      version: json['version'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }



  
}
