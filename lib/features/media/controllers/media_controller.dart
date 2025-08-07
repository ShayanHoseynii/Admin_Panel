import 'dart:typed_data';

import 'package:admin_panel/common/widgets/loaders/circular_loader.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/media/repository/media_repository.dart';
import 'package:admin_panel/features/media/screens/media/widgets/media_content.dart';
import 'package:admin_panel/features/media/screens/media/widgets/media_uploader.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:admin_panel/utils/constants/text_strings.dart';
import 'package:admin_panel/utils/popups/dialogs.dart';
import 'package:admin_panel/utils/popups/full_screen_loader.dart';
import 'package:admin_panel/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();
  final RxBool loading = false.obs;

  late DropzoneViewController dropzoneController;
  final int initialLoadCount = 20;
  final int loadMoreCount = 25;
  final RxBool showImagesUploaderSection = false.obs;
  final Rx<MediaCategory> selectedPath = MediaCategory.folders.obs;

  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;

  final RxList<ImageModel> allImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBannerImages = <ImageModel>[].obs;
  final RxList<ImageModel> allProductImages = <ImageModel>[].obs;
  final RxList<ImageModel> allBrandImages = <ImageModel>[].obs;
  final RxList<ImageModel> allCategoryImages = <ImageModel>[].obs;
  final RxList<ImageModel> allUserImages = <ImageModel>[].obs;

  final MediaRepository mediaRepository = MediaRepository.instance;

  Future<void> selectLocalImages() async {
    final files = await dropzoneController.pickFiles(
      multiple: true,
      mime: ['image/jpeeg', 'image/png'],
    );
    if (files.isNotEmpty) {
      for (var file in files) {
        final bytes = await dropzoneController.getFileData(file);
        final filename = await dropzoneController.getFilename(file);
        final mimeType = await dropzoneController.getFileMIME(file);
        final image = ImageModel(
          url: '',
          folder: '',
          fileName: filename,
          contentType: mimeType,
          localImageToDisplay: Uint8List.fromList(bytes),
        );
        selectedImagesToUpload.add(image);
      }
    }
  }

  void uploadImagesConfirmation() {
    if (selectedPath.value == MediaCategory.folders) {
      TLoaders.warningSnackBar(
          title: 'Select Folder',
          message: 'Please select a folder to upload images to.');
      return;
    }

    TDialogs.defaultDialog(
        context: Get.context!,
        title: 'Upload Images',
        confirmText: 'Upload',
        onConfirm: () async {
          await uploadImages();
        },
        content:
            'Are you sure you want to upload all images in${selectedPath.value.name.toUpperCase()} folder?');
  }

  Future<void> uploadImages() async {
    try {
      //Remove confirmation dialog
      Get.back();
      //Loader
      uploadImagesLoader();
      // Get the selected folder
      MediaCategory selectedCategory = selectedPath.value;

      // Get the corresponding list to update
      RxList<ImageModel> targetlist;

      switch (selectedCategory) {
        case MediaCategory.folders:
          targetlist = allImages;
          break;
        case MediaCategory.banners:
          targetlist = allBannerImages;
          break;
        case MediaCategory.products:
          targetlist = allProductImages;
          break;
        case MediaCategory.brands:
          targetlist = allBrandImages;
          break;
        case MediaCategory.categories:
          targetlist = allCategoryImages;
          break;
        case MediaCategory.users:
          targetlist = allUserImages;
          break;
        default:
          return;
      }
      // Upload each image
      //Using a reverse loop to avoid 'Concurrent modification' error
      for (int i = selectedImagesToUpload.length - 1; i >= 0; i--) {
        final selectedImage = selectedImagesToUpload[i];

        // Upload the image in the storage
        final ImageModel uploadedImage =
            await mediaRepository.uploadImageFileInStorage(
          fileData: selectedImage.localImageToDisplay!,
          mimeType: selectedImage.contentType!,
          path: getSelectedPath(),
          imageName: selectedImage.fileName,
        );

        // Upload image in the firestrore
        uploadedImage.mediaCategory = selectedCategory.name;
        final id =
            await mediaRepository.uploadImageFileInDatabase(uploadedImage);
        uploadedImage.id = id;

        selectedImagesToUpload.removeAt(i);
        targetlist.add(uploadedImage);
      }
      TFullScreenLoader.stopLoading();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(
          title: 'Error Uploading Images',
          message: 'An error occurred while uploading images.');
    }
  }

  void uploadImagesLoader() {
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text('Uploading Images'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(TImages.uploadingImageIllustration,
                  height: 300, width: 300),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Text('Sit tight while we upload your images...'),
            ],
          ),
        ),
      ),
    );
  }

  String getSelectedPath() {
    String path = '';
    switch (selectedPath.value) {
      case MediaCategory.banners:
        path = TTexts.bannersStoragePath;
        break;
      case MediaCategory.products:
        path = TTexts.productsStoragePath;
        break;
      case MediaCategory.brands:
        path = TTexts.brandsStoragePath;
        break;
      case MediaCategory.categories:
        path = TTexts.categoriesStoragePath;
        break;
      case MediaCategory.users:
        path = TTexts.usersStoragePath;
        break;
      default:
        path = 'Others';
    }
    return path;
  }

// Get Images

  void getMediaImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }
      final images = await mediaRepository.fetchImagesFromDatabase(
          selectedPath.value, initialLoadCount);

      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap',
          message: 'Unable to fetch images, Somthing went wrong. Try again.');
    }
  }

  void loadMoreImages() async {
    try {
      loading.value = true;
      RxList<ImageModel> targetList = <ImageModel>[].obs;
      if (selectedPath.value == MediaCategory.banners &&
          allBannerImages.isEmpty) {
        targetList = allBannerImages;
      } else if (selectedPath.value == MediaCategory.brands &&
          allBrandImages.isEmpty) {
        targetList = allBrandImages;
      } else if (selectedPath.value == MediaCategory.categories &&
          allCategoryImages.isEmpty) {
        targetList = allCategoryImages;
      } else if (selectedPath.value == MediaCategory.products &&
          allProductImages.isEmpty) {
        targetList = allProductImages;
      } else if (selectedPath.value == MediaCategory.users &&
          allUserImages.isEmpty) {
        targetList = allUserImages;
      }
      final images = await mediaRepository.loadMoreImagesFromDatabase(
          selectedPath.value,
          loadMoreCount,
          targetList.last.createdAt ?? DateTime.now());

      targetList.assignAll(images);
      loading.value = false;
    } catch (e) {
      loading.value = false;
      TLoaders.errorSnackBar(
          title: 'Oh Snap',
          message: 'Unable to fetch images, Somthing went wrong. Try again.');
    }
  }

  void removeCloudImageConfirmation(ImageModel image) {
    TDialogs.defaultDialog(
      context: Get.context!,
      onConfirm: () {
        Get.back();

        removeCloudeImage(image);
      },
    );
  }

  void removeCloudeImage(ImageModel image) async {
    try {
      Get.back();
      Get.defaultDialog(
          title: '',
          barrierDismissible: false,
          backgroundColor: Colors.transparent,
          content: const PopScope(
            canPop: false,
            child: SizedBox(width: 150, height: 150, child: TCircularLoader()),
          ));

      await mediaRepository.deleteFileFromStorage(image);

      RxList<ImageModel> targetlist;

      switch (selectedPath.value) {
        case MediaCategory.folders:
          targetlist = allImages;
          break;
        case MediaCategory.banners:
          targetlist = allBannerImages;
          break;
        case MediaCategory.products:
          targetlist = allProductImages;
          break;
        case MediaCategory.brands:
          targetlist = allBrandImages;
          break;
        case MediaCategory.categories:
          targetlist = allCategoryImages;
          break;
        case MediaCategory.users:
          targetlist = allUserImages;
          break;
        default:
          return;
      }

      targetlist.remove(image);
      update();

      TFullScreenLoader.stopLoading();
      TLoaders.successSnackBar(
          title: 'Image Deleted',
          message: 'Image successfuly deleted from your cloud storage');
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  Future<List<ImageModel>?> selectImagesFromMedia(
      {List<String>? selectedUrls,
      bool allowSelection = true,
      bool multipleSelection = false}) async {
    showImagesUploaderSection.value = true;
    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
        backgroundColor: TColors.primaryBackground,
        isScrollControlled: true,
        FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const MediaUploader(),
                  MediaContent(
                      allowSelection: allowSelection,
                      allowMultipleSelection: multipleSelection,
                      alreadySelectedURLs: selectedUrls ?? [])
                ],
              ),
            ),
          ),
        ));
    return selectedImages;
  }
}
