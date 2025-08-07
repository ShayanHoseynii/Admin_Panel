class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'values': values,
    };
  }

  /// Create from JSON (Firestore document or API)
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    if (document.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: document['name'] ?? '',
      values: document['values'] != null
          ? List<String>.from(document['values'])
          : [],
    );
  }
}
