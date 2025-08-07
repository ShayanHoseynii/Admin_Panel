import 'package:admin_panel/data/repositories/brands/brands_repository.dart';
import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/shop/contollers/brand/brand_controller.dart';
import 'package:admin_panel/features/shop/model/brand_category_model.dart';
import 'package:admin_panel/features/shop/model/brand_model.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditbrandController extends GetxController {
  static EditbrandController get instance => Get.find();

  final selectedParent = BrandModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

  final _brandRepository = Get.put(BrandRepository());
  final _brandController = Get.put(BrandController());

  // Assigning all the variables send through the brand argument
  void init(BrandModel brand) {
    name.text = brand.name;
    isFeatured.value = brand.isFeatured;
    imageURL.value = brand.image;
    if (brand.brandCategory != null) {
      selectedCategories.addAll(brand.brandCategory ?? []);
    }
  }

  void toggleSelection(CategoryModel category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
  }

  void resetFields() {
    name.clear();
    loading(false);
    isFeatured(false);
    imageURL.value = '';
    selectedCategories.clear();
  }

  /// Pick Thumbnail Image from Media
  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      imageURL.value = selectedImage.url;
    }
  }

  /// Register new brand
  void updateBrand(BrandModel brand) async {
    try {
      TFullScreenLoader.popUpCircular();

      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      // if (!formKey.currentState!.validate()) {
      //   TFullScreenLoader.stopLoading();
      //   return;
      // }

      bool isBrandUpdated = false;
      if (brand.image != imageURL.value ||
          brand.name != name.text.trim() ||
          brand.isFeatured != isFeatured.value) {
        isBrandUpdated = true;
        brand.name = name.text.trim();
        brand.image = imageURL.value;
        brand.isFeatured = isFeatured.value;
        brand.updatedAt = DateTime.now();
        await _brandRepository.updateBrand(brand);
      }
      if (selectedCategories.isNotEmpty) await updateBrandCategories(brand);

      // if (isBrandUpdated) await updateBrandInProducts(brand);
      // Update all data list
      _brandController.updateItemFromLists(brand);

      resetFields();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations', message: 'brand has been created.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  updateBrandCategories(BrandModel brand) async {
    final brandCategories =
        await _brandRepository.getCategoriesofSpecificBrand(brand.id);

// SelectedCategoryIds
    final selectedCategoryIds = selectedCategories.map((e) => e.id);

// Identify categories to remove
    final categoriesToRemove = brandCategories
        .where((existingCategory) =>
            !selectedCategoryIds.contains(existingCategory.categoryId))
        .toList();

// Remove unselected categories
    for (var categoryToRemove in categoriesToRemove) {
      await BrandRepository.instance
          .deleteBrandCategory(categoryToRemove.id ?? '');

// Identify new categories to add
      final newCategoriesToAdd = selectedCategories
          .where((newCategory) => !brandCategories.any((existingCategory) =>
              existingCategory.categoryId == newCategory.id))
          .toList();
// Add new categories
      for (var newCategory in newCategoriesToAdd) {
        var brandCategory =
            BrandCategoryModel(brandId: brand.id, categoryId: newCategory.id);
        brandCategory.id =
            await BrandRepository.instance.createBrandCategory(brandCategory);
      }
      brand.brandCategory!.assignAll(selectedCategories);
      _brandController.updateItemFromLists(brand);
    }
  }
}
