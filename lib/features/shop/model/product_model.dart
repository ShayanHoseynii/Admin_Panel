import 'package:admin_panel/features/shop/model/brand_model.dart';
import 'package:admin_panel/features/shop/model/product_attribute_model.dart';
import 'package:admin_panel/features/shop/model/product_variation_model.dart';
import 'package:admin_panel/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ProductModel {
  String id;
  int stock;
  String? sku;
  double price;
  String title;
  DateTime? date;
  double salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? categoryId;
  String productType;
  String? description;

  List<String>? images;
  int soldQuantity;
  List<ProductAttributeModel>? productAttributes;
  List<ProductVariationModel>? productVariations;
  List<String>? categoryIds;

  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.soldQuantity = 0,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice = 0.0,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
    this.categoryIds,
  });

  /// Convert to Firestore-compatible map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'stock': stock,
      'sku': sku,
      'price': price,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'productType': productType,
      'soldQuantity': soldQuantity,
      'date': date?.toIso8601String(),
      'isFeatured': isFeatured,
      'categoryId': categoryId,
      'description': description,
      'images': images ?? [],
      'brand': brand?.toJson(),
      'categoryIds': categoryIds ?? [],
      'productAttributes': productAttributes!= null ? productAttributes!.map((e) => e.toJson()).toList() : [],
      'productVariations': productVariations != null? productVariations!.map((e) => e.toJson()).toList() : [],
    };
  }

  /// Create from Firestore DocumentSnapshot
  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data()!;

  return ProductModel(
    id: document.id,
    title: data['title'] ?? '',
    price: double.tryParse(data['price']?.toString() ?? '0.0') ?? 0.0,
    sku: data['sku'],
    stock: data['stock'] ?? 0,
    soldQuantity: data.containsKey('soldQuantity') ? data['soldQuantity'] ?? 0 : 0,
    isFeatured: data['isFeatured'] ?? false,
    salePrice: double.tryParse(data['salePrice']?.toString() ?? '0.0') ?? 0.0,
    thumbnail: data['thumbnail'] ?? '',
    categoryId: data['categoryId'] ?? '',
    description: data['description'] ?? '',
    productType: data['productType'] ?? '',

    brand: data['brand'] != null ? BrandModel.fromJson(data['brand']) : null,

    categoryIds: data['categoryIds'] != null
        ? List<String>.from(data['categoryIds'])
        : [],

    images: data['images'] != null
        ? List<String>.from(data['images'])
        : [],

    productAttributes: data['productAttributes'] != null
        ? (data['productAttributes'] as List)
            .map((e) => ProductAttributeModel.fromJson(e))
            .toList()
        : [],

    productVariations: data['productVariations'] != null
        ? (data['productVariations'] as List)
            .map((e) => ProductVariationModel.fromJson(e))
            .toList()
        : [],

    date: data['date'] != null
        ? DateTime.tryParse(data['date'].toString())
        : null,
  );
}


  /// Optional: Formats the date
  String get formattedDate => TFormatter.formatDate(date);

  /// Returns a placeholder empty model
  static ProductModel empty() => ProductModel(
        id: '',
        title: '',
        stock: 0,
        price: 0.0,
        thumbnail: '',
        productType: '',
      );
}
