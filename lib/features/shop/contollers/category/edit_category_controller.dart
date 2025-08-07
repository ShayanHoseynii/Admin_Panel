import 'package:admin_panel/data/repositories/category/category_repository.dart';
import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Assigning all the variables send through the category argument
  void init(CategoryModel category) {
    name.text = category.name;
    isFeatured.value = category.isFeatured;
    imageURL.value = category.image;
    if (category.parentId.isNotEmpty) {
      selectedParent.value = CategoryController.instance.allItems
          .where((c) => c.id == category.parentId)
          .single;
    }
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

  /// Register new Category
  void updateCategory(CategoryModel category) async {
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

      category.name = name.text.trim();
      category.image = imageURL.value;
      category.parentId = selectedParent.value.id;
      category.isFeatured = isFeatured.value;
      category.updatedAt = DateTime.now();


      // Call Repository to update the selected category
      await CategoryRepository.instance.updateCategory(category);

      // Update all data list
      CategoryController.instance.updateItemFromLists(category);
      
      resetTheFields();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'category has been created.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }


  /// Method to reset fields
  void resetTheFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }




}
