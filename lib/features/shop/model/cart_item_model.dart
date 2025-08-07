class CartItemModel {
  String productId;
  String title;
  String? image;
  int quantity;
  double price;
  Map<String, String>? selectedVariation;
  String variationId;
  String? brandName;

  CartItemModel({
    required this.productId,
    this.title = '',
    this.image,
    required this.quantity,
    this.price = 0.0,
    this.brandName,
    this.selectedVariation,
    this.variationId = '',
  });

  String get totalAmount => (price * quantity).toStringAsFixed(1);

  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'image': image,
      'quantity': quantity,
      'price': price,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'] ?? '',
      title: json['title'] ?? '',
      image: json['image'],
      quantity: json['quantity'] ?? 1,
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0),
      variationId: json['variationId'] ?? '',
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}
