import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/shop/model/product_variation_model.dart';
import 'package:get/get.dart';

class ProductImageController extends GetxController {
  static ProductImageController get instance => Get.find();

  Rx<String?> selectedThumbnailImageUrls = Rx<String?>(null);

  final RxList<String> additionalProductImagesUrls = <String>[].obs;

  /// Pick Thumnail Image from Media
  void selectThumnailImage() async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;

      selectedThumbnailImageUrls.value = selectedImage.url;
    }
  }

  /// Pick Multiple Images from Media
  void selectMultipleProductImages() async {
    final controller = Get.put(MediaController());
    final selectedImages = await controller.selectImagesFromMedia(
        multipleSelection: true, selectedUrls: additionalProductImagesUrls);

    if (selectedImages != null && selectedImages.isNotEmpty) {
      additionalProductImagesUrls.assignAll(selectedImages.map((e) => e.url));
    }
  }

  Future<void> removeImage(int index) async {
    additionalProductImagesUrls.removeAt(index);
  }

  void selectVariationImage(ProductVariationModel varition) async {
    final controller = Get.put(MediaController());
    List<ImageModel>? selectedImages = await controller.selectImagesFromMedia();
    if (selectedImages != null && selectedImages.isNotEmpty) {
      ImageModel selectedImage = selectedImages.first;
      varition.image.value = selectedImage.url;
    }
  }
}
