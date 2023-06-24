// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

class Images {
  List<File> images = [];
  int? construction_side_id;
  String? folder;
  Images({
    required this.images,
    this.construction_side_id,
    this.folder,
  });

  Images copyWith({
    List<File>? images,
    int? construction_side_id,
    String? folder,
  }) {
    return Images(
      images: images ?? this.images,
      construction_side_id: construction_side_id ?? this.construction_side_id,
      folder: folder ?? this.folder,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'images': images.map((x) => x.toMap()).toList(),
      'images': images,
      'construction_side_id': construction_side_id,
      'folder': folder,
    };
  }

  // factory Images.fromMap(Map<String, dynamic> map) {
  //   return Images(
  //     images: List<File>.from((map['images'] as List<int>).map<File>((x) => File.fromMap(x as Map<String,dynamic>),),),
  //     construction_side_id: map['construction_side_id'] != null ? map['construction_side_id'] as int : null,
  //     folder: map['folder'] != null ? map['folder'] as String : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory Images.fromJson(String source) => Images.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Images(images: $images, construction_side_id: $construction_side_id, folder: $folder)';

  @override
  bool operator ==(covariant Images other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      listEquals(other.images, images) &&
      other.construction_side_id == construction_side_id &&
      other.folder == folder;
  }

  @override
  int get hashCode => images.hashCode ^ construction_side_id.hashCode ^ folder.hashCode;
}
