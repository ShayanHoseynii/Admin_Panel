import 'package:admin_panel/data/repositories/product/product_repository.dart';
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateProductController extends GetxController {
  static CreateProductController get instance => Get.find();

  final isLoading = false.obs;
  final productType = ProductType.single.obs;
  final productVisibility = ProductVisibility.hidden.obs;

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

  RxBool thumbnailUploader = false.obs;
  RxBool additionalImagesUploader = false.obs;
  RxBool productDataUploader = false.obs;
  RxBool categoriesRelationshipUploader = false.obs;

  Future<void> createProduct() async {
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
      // if (productType.value == ProductType.single &&
      //     !stockPriceFormKey.currentState!.validate()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }
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
      final newRecord = ProductModel(
        id: '',
        sku: '',
        isFeatured: true,
        title: title.text.trim(),
        brand: selectedBrand.value,
        productVariations: variations,
        description: description.text.trim(),
        productType: productType.value.toString(),
        stock: int.tryParse(stock.text.trim()) ?? 0,
        price: double.tryParse(price.text.trim()) ?? 0,
        images: imagesController.additionalProductImagesUrls,
        salePrice: double.tryParse(salePrice.text.trim()) ?? 0,
        thumbnail: imagesController.selectedThumbnailImageUrls.value ?? '',
        productAttributes:
            ProductAttributesController.instance.productAttributes,
        categoryIds: selectedCategories.map((category) => category.id).toList(),
        date: DateTime.now(),
      );
      productDataUploader.value = true;
      newRecord.id = await ProductRepository.instance.createProduct(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error Storing Data.';
        }

        categoriesRelationshipUploader.value = true;
        for (var category in selectedCategories) {
          final productCategory = ProductCategoryModel(
              productId: newRecord.id, categoryId: category.id);
          await ProductRepository.instance
              .createProductCategory(productCategory);
        }
      }

      // Updating the Product List
      ProductController.instance.addItemToLists(newRecord);

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
            const Text('Your Product has been Created'),
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
