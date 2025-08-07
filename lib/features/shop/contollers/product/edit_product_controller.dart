import 'package:admin_panel/data/repositories/product/product_repository.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_attribute_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_image_controller.dart';
import 'package:admin_panel/features/shop/contollers/product/product_variation_controller.dart';
import 'package:admin_panel/features/shop/model/brand_model.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/features/shop/model/product_category.dart';
import 'package:admin_panel/features/shop/model/product_model.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;
  final selectedCategoriesLoader = false.obs;

  // Controllers and keys
  final variationsController = Get.put(ProductVariationController());
  final attributesController = Get.put(ProductAttributesController());
  final imagesController = Get.put(ProductImageController());
  final stockPriceFormKey = GlobalKey<FormState>();
  final productRepository = Get.put(ProductRepository());
  final titleDescriptionFormKey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController salePrice = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController brandTextField = TextEditingController();

  final Rx<BrandModel?> selectedBrand = Rx<BrandModel?>(null);
  final RxList<CategoryModel> selectedCategories = <CategoryModel>[].obs;
  final List<CategoryModel> alreadyAddedCategories = <CategoryModel>[];

  RxBool thumbnailUploader = true.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = true.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  void initProductData(ProductModel product) {
    try {
      isLoading.value = true;

      // Basic Info
      title.text = product.title;
      description.text = product.description ?? '';
      productType.value = product.productType == ProductType.single.toString()
          ? ProductType.single
          : ProductType.variable;
      // Stock and Pricing
      if (product.productType == ProductType.single.toString()) {
        stock.text = product.stock.toString();
        price.text = product.price.toString();
        salePrice.text = product.salePrice.toString();
      }

      // Product Brand
      selectedBrand.value = product.brand;
      brandTextField.text = product.brand?.name ?? "";

      print(product.brand!.name);
      print(brandTextField.text);

      // Product Thumbnail and Images
      if (product.images != null) {
        // Set the thumbnail
        imagesController.selectedThumbnailImageUrls.value = product.thumbnail;

        // Add the images to additionalProductImagesUrls
        imagesController.additionalProductImagesUrls
            .assignAll(product.images ?? []);
      }
      print(imagesController.additionalProductImagesUrls);

      // Product Attributes & Variations
      attributesController.productAttributes
          .assignAll(product.productAttributes ?? []);
      variationsController.productVariations
          .assignAll(product.productVariations ?? []);
      variationsController
          .initializeVariationControllers(product.productVariations ?? []);

      // Load categories if product has categoryIds
      if (product.categoryIds != null && product.categoryIds!.isNotEmpty){
        loadCategoriesFromIds(product.categoryIds!);
      }

      isLoading.value = false;

      update();
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }

  Future<List<CategoryModel>> loadSelectedCategories(String productId) async {
    selectedCategoriesLoader.value = true;

    // Fetch product categories from repository
    final productCategories =
        await productRepository.getProductCategories(productId);

    // Ensure categories are loaded in the controller
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    // Extract category IDs from product categories
    final categoryIds = productCategories.map((e) => e.categoryId).toList();

    // Filter existing categories to match selected IDs
    final categories = categoriesController.allItems
        .where((element) => categoryIds.contains(element.id))
        .toList();

    // Assign to reactive lists
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);

    selectedCategoriesLoader.value = false;
    return categories;
  }

  Future<List<CategoryModel>> loadCategoriesFromIds(List<String> categoryIds) async {
    selectedCategoriesLoader.value = true;

    // Ensure categories are loaded in the controller
    final categoriesController = Get.put(CategoryController());
    if (categoriesController.allItems.isEmpty) {
      await categoriesController.fetchItems();
    }

    // Filter existing categories to match selected IDs
    final categories = categoriesController.allItems
        .where((element) => categoryIds.contains(element.id))
        .toList();

    // Assign to reactive lists
    selectedCategories.assignAll(categories);
    alreadyAddedCategories.assignAll(categories);

    selectedCategoriesLoader.value = false;
    return categories;
  }

  Future<void> editProduct(ProductModel product) async {
    try {
      showProgressDialog();

      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      if (!titleDescriptionFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (productType.value == ProductType.single &&
          !stockPriceFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }
      if (selectedBrand.value == null) throw 'Select Brand for this product';

// Check variation data if ProductType = Variable
      if (productType.value == ProductType.variable &&
          ProductVariationController.instance.productVariations.isEmpty) {
        throw 'There are no variations for the Product Type Variable. Create some variations or change Product type.';
      }

      if (productType.value == ProductType.variable) {
        final variationCheckFailed = ProductVariationController
            .instance.productVariations
            .any((element) =>
                element.price.isNaN ||
                element.price < 0 ||
                element.salePrice.isNaN ||
                element.salePrice < 0 ||
                element.stock.isNaN ||
                element.stock < 0 ||
                element.image.value.isEmpty
);

        if (variationCheckFailed) {
          throw 'Variation data is not accurate. Please recheck variations';
        }
      }

// Upload Product Thumbnail Image
      thumbnailUploader.value = true;
      final imagesController = ProductImageController.instance;
      if (imagesController.selectedThumbnailImageUrls.value == null) {
        throw 'Select Product Thumbnail Image';
      }

// Additional Product Images
      additionalImagesUploader.value = true;

      // Product Variation Images
      final variations = ProductVariationController.instance.productVariations;
      if (productType.value == ProductType.single && variations.isNotEmpty) {
        ProductVariationController.instance.resetAllValues();
        variations.value = [];
      }

      product.sku = '';
      product.isFeatured = true;
      product.title = title.text.trim();
      product.brand = selectedBrand.value;
      product.productVariations = variations;
      product.description = description.text.trim();
      product.productType = productType.value.toString();
      product.stock = int.tryParse(stock.text.trim()) ?? 0;
      product.price = double.tryParse(price.text.trim()) ?? 0;
      product.images = imagesController.additionalProductImagesUrls;
      product.salePrice = double.tryParse(salePrice.text.trim()) ?? 0;
      product.thumbnail =
          imagesController.selectedThumbnailImageUrls.value ?? '';
      product.productAttributes =
          ProductAttributesController.instance.productAttributes;
      product.categoryIds = selectedCategories.map((category) => category.id).toList();

      productDataUploader.value = true;
      await ProductRepository.instance.updateProduct(product);
      if (selectedCategories.isNotEmpty) {
        categoriesRelationshipUploader.value = true;

        List<String> existingCategoryIds =
            alreadyAddedCategories.map((category) => category.id).toList();

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          if (!existingCategoryIds.contains(category.id)) {
            final productCategory = ProductCategoryModel(
                productId: product.id, categoryId: category.id);
            await ProductRepository.instance
                .createProductCategory(productCategory);
          }
        }
        for (var existingCategoryId in existingCategoryIds) {
          if (!selectedCategories
              .any((category) => category.id == existingCategoryId)) {
            await ProductRepository.instance
                .removeProductCategory(product.id, existingCategoryId);
          }
        }
      }

      ProductController.instance.updateItemFromLists(product);

      TFullScreenLoader.stopLoading();

      showCompletionDialog();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void resetValues() {
    isLoading.value = false;
    productType.value = ProductType.single;
    productVisibility.value = ProductVisibility.hidden;
    stockPriceFormKey.currentState?.reset();
    titleDescriptionFormKey.currentState?.reset();
    title.clear();
    description.clear();
    stock.clear();
    price.clear();
    salePrice.clear();
    brandTextField.clear();
    selectedBrand.value = null;
    selectedCategories.clear();
    ProductVariationController.instance.resetAllValues();
    ProductAttributesController.instance.resetProductAttributes();

// Reset Upload Flags
    thumbnailUploader.value = false;
    additionalImagesUploader.value = false;
    productDataUploader.value = false;
    categoriesRelationshipUploader.value = false;
  }

  void showCompletionDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Congratulations'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(TImages.productsIllustration, height: 200, width: 200),
            const SizedBox(height: TSizes.spaceBtwItems),
            Text(
              'Congratulations',
              style: Theme.of(Get.context!).textTheme.headlineSmall,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            const Text('Your Product has been Updated'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Navigate back to products
            },
            child: const Text('Go to Products'),
          ),
        ],
      ),
    );
  }

  void showProgressDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Creating Product'),
          content: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(TImages.creatingProductIllustration,
                    height: 200, width: 200),
                const SizedBox(height: TSizes.spaceBtwItems),
                buildCheckbox('Thumbnail Image', thumbnailUploader),
                buildCheckbox('Additional Images', additionalImagesUploader),
                buildCheckbox('Product Data, Attributes & Variations',
                    productDataUploader),
                buildCheckbox(
                    'Product Categories', categoriesRelationshipUploader),
                const SizedBox(height: TSizes.spaceBtwItems),
                const Text('Sit Tight, your product is uploading...'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCheckbox(String label, RxBool value) {
    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: value.value
              ? const Icon(CupertinoIcons.checkmark_alt_circle_fill,
                  color: Colors.blue)
              : const Icon(CupertinoIcons.checkmark_alt_circle),
        ), // AnimatedSwitcher
        const SizedBox(width: TSizes.spaceBtwItems),
        Text(label),
      ],
    ); // Row
  }
}
