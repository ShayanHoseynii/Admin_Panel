import 'package:admin_panel/data/repositories/category/category_repository.dart';
import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/shop/contollers/category/category_controller.dart';
import 'package:admin_panel/features/shop/model/category_model.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final selectedParent = CategoryModel.empty().obs;
  final loading = false.obs;
  RxString imageURL = ''.obs;
  final isFeatured = false.obs;
  final name = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void pickImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      imageURL.value = selectedImage.url;
    }
  }

  void createCategory() async {
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

      final newRecord = CategoryModel(
          id: '',
          name: name.text.trim(),
          image: imageURL.value,
          createdAt: DateTime.now(),
          isFeatured: isFeatured.value,
          parentId: selectedParent.value.id);

      newRecord.id =
          await CategoryRepository.instance.createCategory(newRecord);

      CategoryController.instance.addItemToLists(newRecord);

      resetTheFields();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: '${name.text.trim()} category has been created.');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  void resetTheFields() {
    selectedParent(CategoryModel.empty());
    loading(false);
    isFeatured(false);
    name.clear();
    imageURL.value = '';
  }

  /// Method to reset fields

  /// Pick Thumnail Image from Media

  /// Register new Category
}
