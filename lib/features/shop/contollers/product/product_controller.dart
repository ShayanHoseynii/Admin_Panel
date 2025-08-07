import 'package:admin_panel/data/abstract/base_data_table_controller.dart';
import 'package:admin_panel/data/repositories/product/product_repository.dart';
import 'package:admin_panel/features/shop/model/product_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:get/get.dart';

class ProductController extends TBaseController<ProductModel> {
  static ProductController get instance => Get.find();

  final _productRepository = Get.put(ProductRepository());

  @override
  Future<List<ProductModel>> fetchItems() async {
    return await _productRepository.getAllProducts();
  }

  @override
  bool containsSearchQuery(ProductModel item, String query) {
    final lowerQuery = query.toLowerCase();
    return item.title.toLowerCase().contains(lowerQuery) ||
           item.sku?.toLowerCase().contains(lowerQuery) == true ||
           item.brand?.name?.toLowerCase().contains(lowerQuery) == true;
  }

  @override
  Future<void> deleteItem(ProductModel item) async {
    // Optionally: Check for related orders before deleting the product
    await _productRepository.deleteProduct(item);
  }

  /// Sorting by title
  void sortByName(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.title.toLowerCase(),
    );
  }

  /// Sorting by price
  void sortByPrice(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.price,
    );
  }

  /// Sorting by stock
  void sortByStock(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.stock,
    );
  }

  /// Sorting by sold quantity
  void sortBySoldItems(int sortColumnIndex, bool ascending) {
    sortByProperty(
      sortColumnIndex,
      ascending,
      (ProductModel product) => product.soldQuantity,
    );
  }

  String getProductPrice(ProductModel product) {
  // If no variations exist, return the simple price or sale price
  if (product.productType == ProductType.single.toString() ||
      product.productVariations == null ||
      product.productVariations!.isEmpty) {
    double price = product.salePrice > 0.0 ? product.salePrice : product.price;
    return '\$${price.toStringAsFixed(2)}';
  } else {
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;

    // Calculate the smallest and largest prices among variations
    for (var variation in product.productVariations!) {
      double priceToConsider =
          variation.salePrice > 0.0 ? variation.salePrice : variation.price;

      if (priceToConsider < smallestPrice) {
        smallestPrice = priceToConsider;
      }

      if (priceToConsider > largestPrice) {
        largestPrice = priceToConsider;
      }
    }

    // If smallest and largest prices are the same, return a single price
    if (smallestPrice == largestPrice) {
      return '\$${largestPrice.toStringAsFixed(2)}';
    } else {
      return '\$${smallestPrice.toStringAsFixed(2)} - \$${largestPrice.toStringAsFixed(2)}';
    }
  }
}
String? calculateSalePercentage(double originalPrice, double? salePrice) {
  if (salePrice == null || salePrice <= 0.0) return null;
  if (originalPrice <= 0) return null;

  double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
  return percentage.toStringAsFixed(0); // returns like "25"
}

String getProductStockTotal(ProductModel product) {
  return product.productType == ProductType.single.toString()
      ? product.stock.toString()
      : product.productVariations!.fold<int>(
            0, (total, variation) => total + variation.stock).toString();
}
String getProductSoldQuantity(ProductModel product) {
  return product.productType == ProductType.single.toString()
      ? product.soldQuantity.toString()
      : product.productVariations!.fold<int>(
            0, (total, variation) => total + variation.soldQuantity).toString();
}
String getProductStockStatus(ProductModel product) {
  return product.stock > 0 ? 'In Stock' : 'Out of Stock';
}

}
