import 'package:get/get.dart';

class ProductVariationModel {
  final String id;
  String sku;
  Rx<String> image;
  String? description;
  double price;
  double salePrice;
  int stock;
  int soldQuantity;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    String image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    this.soldQuantity = 0,
    required this.attributeValues,
  }) : image = image.obs;

  /// Create empty instance
  static ProductVariationModel empty() => ProductVariationModel(
        id: '',
        attributeValues: {},
      );

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sku': sku,
      'image': image.value,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'stock': stock,
      'soldQuantity': soldQuantity,
      'attributeValues': attributeValues,
    };
  }

  /// Create from JSON / Firestore snapshot data
  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: json['id'] ?? '',
      sku: json['sku'] ?? '',
      image: (json['image'] ?? '').toString(),
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      salePrice: (json['salePrice'] as num?)?.toDouble() ?? 0.0,
      stock: json['stock'] ?? 0,
      soldQuantity: json['soldQuantity'] ?? 0,
      attributeValues: json['attributeValues'] != null
          ? Map<String, String>.from(json['attributeValues'])
          : {},
    );
  }
}
