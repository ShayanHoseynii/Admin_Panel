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

class CreateBrandController extends GetxController {
  static CreateBrandController get instance => Get.find();
  final _brandRepository = Get.put(BrandRepository());
  final _brandController = Get.put(BrandController());
  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> selectedCategories = <CategoryModel>[].obs;

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

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      imageURL.value = selectedImage.url;
    }
  }

  void createBrand() async {
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

      final newRecord = BrandModel(
        id: '',
        name: name.text.trim(),
        productCount: 0,
        image: imageURL.value,
        createdAt: DateTime.now(),
        isFeatured: isFeatured.value,
      );

      newRecord.id = await _brandRepository.createBrand(newRecord);

      if (selectedCategories.isNotEmpty) {
        if (newRecord.id.isEmpty) {
          throw 'Error storing relation data. Try again';
        }

        for (var category in selectedCategories) {
          final brandCategory = BrandCategoryModel(
              brandId: newRecord.id, categoryId: category.id);
          await _brandRepository.createBrandCategory(brandCategory);
        }

        newRecord.brandCategory ??= [];
        newRecord.brandCategory!.addAll(selectedCategories);
      }

      _brandController.addItemToLists(newRecord);

      resetFields();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: '${name.text.trim()} New Brand has been created.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  /// Method to reset fields

  /// Pick Thumnail Image from Media

  /// Register new Category
}
