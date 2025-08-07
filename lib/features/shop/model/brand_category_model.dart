import 'package:cloud_firestore/cloud_firestore.dart';

class BrandCategoryModel {
  String? id;
  final String brandId;
  final String categoryId;

  BrandCategoryModel({
    this.id,
    required this.brandId,
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      'brandId': brandId,
      'categoryId': categoryId,
    };
  }

  factory BrandCategoryModel.fromSnapshot(
      DocumentSnapshot document) {
      final data = document.data() as Map<String, dynamic>;
      return BrandCategoryModel( 
        id: document.id,
        brandId: data['brandId'] as String,
        categoryId: data['categoryId'] as String,
      );

  }

}
