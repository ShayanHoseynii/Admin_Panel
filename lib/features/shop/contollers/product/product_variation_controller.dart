import 'package:admin_panel/features/shop/contollers/product/product_attribute_controller.dart';
import 'package:admin_panel/features/shop/model/product_variation_model.dart';
import 'package:admin_panel/utils/popups/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductVariationController extends GetxController {
  static ProductVariationController get instance => Get.find();
  final isLoading = false.obs;
  final RxList<ProductVariationModel> productVariations =
      <ProductVariationModel>[].obs;

// Lists to store controllers for each variation attribute
  List<Map<ProductVariationModel, TextEditingController>> stockControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>> priceControllersList =
      [];
  List<Map<ProductVariationModel, TextEditingController>>
      salePriceControllersList = [];
  List<Map<ProductVariationModel, TextEditingController>>
      descriptionControllersList = [];

// Instance of ProductAttributesController
  final attributesController = Get.put(ProductAttributesController());

  void initializeVariationControllers(List<ProductVariationModel> variations) {
    // Clear existing lists
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();

    // Initialize controllers for each variation
    for (var variation in variations) {
      // Stock Controllers
      Map<ProductVariationModel, TextEditingController> stockControllers = {};
      stockControllers[variation] =
          TextEditingController(text: variation.stock.toString());
      stockControllersList.add(stockControllers);

      // Price Controllers
      Map<ProductVariationModel, TextEditingController> priceControllers = {};
      priceControllers[variation] =
          TextEditingController(text: variation.price.toString());
      priceControllersList.add(priceControllers);

      // Sale Price Controllers
      Map<ProductVariationModel, TextEditingController> salePriceControllers =
          {};
      salePriceControllers[variation] =
          TextEditingController(text: variation.salePrice.toString());
      salePriceControllersList.add(salePriceControllers);

      // Description Controllers
      Map<ProductVariationModel, TextEditingController> descControllers = {};
      descControllers[variation] =
          TextEditingController(text: variation.description ?? '');
      descriptionControllersList.add(descControllers);
    }
  }

  void removeVariations(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      title: 'Remove Variation',
      content:
          'Once variations are created, you cannot add more attributes. In order to add more varitaions, you have to delete any of the attributes.',
      onConfirm: () {
        productVariations.value = [];
        resetAllValues();
        Navigator.of(context).pop();
      },
    );
  }

  void generateVariationsConfirmation(BuildContext context) {
    TDialogs.defaultDialog(
      context: context,
      confirmText: 'Generate',
      title: 'Generate Variation',
      content:
          'Once variations are created, you cannot add more attributes. In order to add more varitaions, you have to delete any of the attributes.',
      onConfirm: () => generateVariationsFromAttributes(),
    );
  }

  void generateVariationsFromAttributes() {
    // Close the previous Popup
    Get.back();

    final List<ProductVariationModel> variations = [];

    // Check if there are attributes
    if (attributesController.productAttributes.isNotEmpty) {
      // Get all combinations of attribute values, e.g., [[Green, Blue], [Small, Large]]
      final List<List<String>> attributeCombinations = getCombinations(
          attributesController.productAttributes
              .map((attr) => attr.values ?? <String>[])
              .toList());

      // Generate ProductVariationModel for each combination
      for (final combination in attributeCombinations) {
        final Map<String, String> attributeValues = Map.fromIterables(
          attributesController.productAttributes.map((attr) => attr.name ?? ''),
          combination,
        );

        // Create the variation with default values
        final ProductVariationModel variation = ProductVariationModel(
          id: UniqueKey().toString(),
          attributeValues: attributeValues,
        );

        variations.add(variation);

        // Create controllers
        final Map<ProductVariationModel, TextEditingController>
            stockControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            priceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            salePriceControllers = {};
        final Map<ProductVariationModel, TextEditingController>
            descriptionControllers = {};

        stockControllers[variation] = TextEditingController();
        priceControllers[variation] = TextEditingController();
        salePriceControllers[variation] = TextEditingController();
        descriptionControllers[variation] = TextEditingController();

        // Add the maps to their respective lists
        stockControllersList.add(stockControllers);
        priceControllersList.add(priceControllers);
        salePriceControllersList.add(salePriceControllers);
        descriptionControllersList.add(descriptionControllers);
      }
    }

    // Update the observable list
    productVariations.assignAll(variations);
  }

  void resetAllValues() {
    productVariations.clear();
    stockControllersList.clear();
    priceControllersList.clear();
    salePriceControllersList.clear();
    descriptionControllersList.clear();
  }

  List<List<String>> getCombinations(List<List<String>> lists) {
    final List<List<String>> result = [];
    combine(lists, 0, <String>[], result);

    return result;
  }

  void combine(
      lists, int index, List<String> current, List<List<String>> result) {
    if (index == lists.length) {
      result.add(List.from(current));
      return;
    }

    for (final item in lists[index]) {
      final List<String> updated = List.from(current)..add(item);

      combine(lists, index + 1, updated, result);
    }
  }
}
