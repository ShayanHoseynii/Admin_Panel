import 'package:admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:admin_panel/common/widgets/images/t_rounded_image.dart';
import 'package:admin_panel/common/widgets/loaders/animation_loader.dart';
import 'package:admin_panel/common/widgets/loaders/loader_animation.dart';
import 'package:admin_panel/features/media/controllers/media_controller.dart';
import 'package:admin_panel/features/media/models/image_model.dart';
import 'package:admin_panel/features/media/screens/media/widgets/folder_dropdown.dart';
import 'package:admin_panel/features/media/screens/media/widgets/view_image_details.dart';
import 'package:admin_panel/utils/constants/colors.dart';
import 'package:admin_panel/utils/constants/enums.dart';
import 'package:admin_panel/utils/constants/image_strings.dart';
import 'package:admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class MediaContent extends StatelessWidget {
  MediaContent(
      {super.key,
      required this.allowSelection,
      required this.allowMultipleSelection,
      this.alreadySelectedURLs,
      this.onImageSelected});
  final bool allowSelection;
  final bool allowMultipleSelection;
  final List<String>? alreadySelectedURLs;
  final List<ImageModel> selectedImages = [];
  final Function(List<ImageModel> selectedImages)? onImageSelected;
  @override
  Widget build(BuildContext context) {
    bool loadedPreviousSelections = false;
    final controller = MediaController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Media Images Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Select Folder',
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  MediaFolderDropdown(
                    onChanged: (MediaCategory? newValue) {
                      if (newValue != null) {
                        controller.selectedPath.value = newValue;
                        controller.getMediaImages();
                      }
                    },
                  ),
                ],
              ),
              if (allowSelection == true) buildAddSelectedImageButton(),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          /// Show Media
          Obx(() {
            List<ImageModel> images = _getSelectedFolderImages(controller);
            if (!loadedPreviousSelections) {
              if (alreadySelectedURLs != null &&
                  alreadySelectedURLs!.isNotEmpty) {
                final selectedUrlsSet = Set<String>.from(alreadySelectedURLs!);

                for (var image in images) {
                  image.isSelected.value = selectedUrlsSet.contains(image.url);
                  if (image.isSelected.value) {
                    selectedImages.add(image);
                  }
                }
              } else {
                for (var image in images) {
                  image.isSelected.value = false;
                }
              }
              loadedPreviousSelections = true;
            }
            if (controller.loading.value && images.isEmpty) {
              return const TLoaderAnimation();
            }

            if (images.isEmpty) return _buildEmptyAnimationWidget(context);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: TSizes.spaceBtwItems / 2,
                  runSpacing: TSizes.spaceBtwItems / 2,
                  children: images
                      .map(
                        (image) => GestureDetector(
                          onTap: () => Get.dialog(ImagePopup(image: image)),
                          child: SizedBox(
                            width: 140,
                            height: 180,
                            child: Column(
                              children: [
                                allowSelection
                                    ? _buildListWithChackbox(image)
                                    : _buildSimpleList(image),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: TSizes.sm),
                                    child: Text(
                                      image.fileName,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                if (!controller.loading.value)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: TSizes.buttonWidth,
                          child: ElevatedButton.icon(
                            icon: const Icon(Iconsax.arrow_down),
                            onPressed: () {
                              controller.loadMoreImages();
                            },
                            label: const Text('Load More'),
                          ),
                        )
                      ],
                    ),
                  )
              ],
            );
          }),

          /// Load more media button
        ],
      ),
    );
  }

  List<ImageModel> _getSelectedFolderImages(MediaController controller) {
    List<ImageModel> images = [];
    if (controller.selectedPath.value == MediaCategory.banners) {
      images = controller.allBannerImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.brands) {
      images = controller.allBrandImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.categories) {
      images = controller.allCategoryImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.products) {
      images = controller.allProductImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    } else if (controller.selectedPath.value == MediaCategory.users) {
      images = controller.allUserImages
          .where((image) => image.url.isNotEmpty)
          .toList();
    }
    return images;
  }

  Widget _buildEmptyAnimationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: TSizes.lg * 3),
      child: TAnimationLoaderWidget(
        width: 300,
        height: 300,
        text: 'Select your desired folder',
        animation: TImages.packageAnimation,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSimpleList(ImageModel image) {
    return TRoundedImage(
      width: 140,
      height: 140,
      padding: TSizes.sm,
      image: image.url,
      imageType: ImageType.network,
      margin: TSizes.spaceBtwItems / 2,
      backgroundColor: TColors.primaryBackground,
    );
  }

  Widget _buildListWithChackbox(ImageModel image) {
    return Stack(
      children: [
        TRoundedImage(
          width: 140,
          height: 140,
          padding: TSizes.sm,
          image: image.url,
          imageType: ImageType.network,
          margin: TSizes.spaceBtwItems / 2,
          backgroundColor: TColors.primaryBackground,
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Obx(() => Checkbox(
              value: image.isSelected.value,
              onChanged: (selected) {
                if (selected != null) {
                  image.isSelected.value = selected;

                  if (selected) {
                    if (!allowMultipleSelection) {
                      for (var otherImage in selectedImages) {
                        if (otherImage != image) {
                          otherImage.isSelected.value = false;
                        }
                      }
                      selectedImages.clear();
                    }
                    selectedImages.add(image);
                  } else {
                    selectedImages.remove(image);
                  }
                }
              })),
        )
      ],
    );
  }

  Widget buildAddSelectedImageButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 120,
          child: OutlinedButton.icon(
              icon: const Icon(Iconsax.close_circle),
              onPressed: () => Get.back(),
              label: const Text('Close')),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        SizedBox(
          width: 120,
          child: ElevatedButton.icon(
            onPressed: () => Get.back(result: selectedImages),
            label: const Text('Add'),
            icon: const Icon(Iconsax.image),
          ),
        ),
      ],
    );
  }
}
