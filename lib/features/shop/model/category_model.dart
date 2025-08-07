import 'package:admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  bool isFeatured;
  String parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isFeatured = false,
    this.parentId = '',
    this.createdAt,
    this.updatedAt,
  });

  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedDate => TFormatter.formatDate(updatedAt);

  static CategoryModel empty() => CategoryModel(id: '', name: '', image: '');

  // Converting model into json to store in fireStore
  toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
      'UpdatedAt': updatedAt = DateTime.now(),
      'CreatedAt': createdAt,
    };
  }

  // Converting the DocumentSnapShotData Received from firestore into Category model
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel( 
        id: document.id,
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        parentId: data['ParentId'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        createdAt:
            data.containsKey('CreatedAt') ? data['CreatedAt']?.toDate() : null,
        updatedAt:
            data.containsKey('UpdatedAt') ? data['UpdatedAt']?.toDate() : null,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}
